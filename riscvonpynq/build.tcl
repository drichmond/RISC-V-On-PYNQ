# ----------------------------------------------------------------------
# Copyright (c) 2018, The Regents of the University of California All
# rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#
#     * Neither the name of The Regents of the University of California
#       nor the names of its contributors may be used to endorse or
#       promote products derived from this software without specific
#       prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL REGENTS OF THE
# UNIVERSITY OF CALIFORNIA BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
# USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.
# ----------------------------------------------------------------------

# This file is a script for building Overlay Designs in various
# ways. It can be used to synthesize a design (run_type = synth),
# binary search to find a maximum frequency (run_type = sweep), or run
# a single compilation (run_type) = single. It can handle multiple
# boards, parts. It also handles IP directories.
# The arguments are as follows:
# 1. Name of the Overlay without the .tcl extension
# 2. Run type (synth, single, or sweep)
# 3. Xilinx Part (e.g. xc7z020clg400-1)
# 4. Board Name (e.g PYNQ-Z1)
# 5. IP Directories (list of paths).
set argc [llength $argv]
set run_type "single"
set target ""
set part ""
set board ""
set board_dir "../../"
set ip_dirs ""
if { $argc != 0 } {
    if { $argc <= 4 } {
	puts ""
	set errmsg "Expected at least three arguments: Name of Overlay \
                (e.g. riscv), run type (e.g sweep, single, or synth), part \
                (e.g. xc7z020clg400-1), and board (e.g PYNQ-Z1)"
	catch {common::send_msg_id "PYNQ-000" "ERROR" $errmsg}
	return 1
    }

    set target [lindex $argv 0]
    if { [file exists $target.tcl] == 0 } {
        puts ""
	set errmsg "Could not find file: $target.tcl. \
            The makefile must be co-located with $target.tcl, or \
            $target is incorrect"
        catch {common::send_msg_id "PYNQ-000" "ERROR" $errmsg}
        return 1
    }

    set run_arg [lindex $argv 1]
    if { $run_arg == "sweep"} {
	set run_type "sweep"
    } elseif {$run_arg == "single"} {
	set run_type "single"
    } elseif {$run_arg == "synth"} {
	set run_type "synth"
    } else {
	puts ""
	set errmsg "Unknown argument value $run_arg. Valid values are \
            \"single\", \"sweep\" and \"synth\""
	catch {common::send_msg_id "PYNQ-000" "ERROR" $errmsg}
	return 1
    }

    set part [lindex $argv 2]
    create_project $target $target -part $part 

    set board [lindex $argv 3]
    set board_xdc $board_dir/$board.xdc
    if { [file exists $board_xdc] == 0 } {
        puts ""
	set errmsg "Could not find file: $board_dir/$board.xdc" 
        catch {common::send_msg_id "PYNQ-000" "ERROR" $errmsg}
        return 1
    }

    # In order to compile the Block Diagram design (in a .tcl file), we need to add
    # the directory containing the IP to the Vivado search path.
    set ip_dirs [lrange $argv 4 end]
    puts $ip_dirs
    set_property ip_repo_paths $ip_dirs [current_project]
    update_ip_catalog
}

# Build the Vivado Block Diagram design
set design_name $target
create_bd_design $design_name
current_bd_design $design_name
source $target.tcl
create_root_design ""

# Create top level file
make_wrapper -files [get_files ./$target/$target.srcs/sources_1/bd/$target/$target.bd] -top

# Add top level file to project
add_files -norecurse ./$target/$target.srcs/sources_1/bd/$target/hdl/$target\_wrapper.v
update_compile_order -fileset sources_1

# Mark top level file as top level
set_property top $target\_wrapper [current_fileset]
update_compile_order -fileset sources_1

# Add board design contraints file
add_files -fileset constrs_1 -norecurse $board_xdc
update_compile_order -fileset sources_1

# If $run_type is "sweep" run a simple binary search by modifying the
# Clock Wizard IP to change the target clock frequency. The script
# expects the IP name to match the value in clk_name.
if { ${run_type} eq "sweep" } {
    set clk_name subprocessorClk
    set min 0 
    set max 400
    set pass 0
    while {($max - $min) > .5} {
        set tgt [ expr {double($max + $min)/2} ]
        puts "Testing Target Frequency: $tgt"
        set_property CONFIG.CLKOUT1_REQUESTED_OUT_FREQ $tgt [get_bd_cells $clk_name]
        reset_run synth_1
        launch_runs impl_1 -jobs 4 -quiet
        wait_on_run impl_1
        open_run impl_1
	set mult [ get_property CONFIG.MMCM_CLKFBOUT_MULT_F [get_bd_cells $clk_name]]
	set div [ get_property CONFIG.MMCM_CLKOUT0_DIVIDE_F [get_bd_cells $clk_name]]
	set clkin [ get_property CONFIG.PRIM_IN_FREQ [get_bd_cells $clk_name]]
	set actual_freq [ expr $clkin * $mult / $div ]
        set slack [ get_property SLACK [get_timing_paths]]
        puts "Timing Slack @ $actual_freq: $slack"
        if {$slack > 0} {
            set min $tgt
	    set pass $actual_freq
	    write_bitstream -force $target.bit
        } else {
            set max $tgt
        }
        close_design
    }
    archive_project
    puts "Maximum frequency: $pass"
} elseif { ${run_type} eq "synth" } {
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1
} else {
    launch_runs impl_1 -to_step write_bitstream -jobs 4
    wait_on_run impl_1
    file copy -force ./$target/$target.runs/impl_1/$target\_wrapper.bit $target.bit
}



