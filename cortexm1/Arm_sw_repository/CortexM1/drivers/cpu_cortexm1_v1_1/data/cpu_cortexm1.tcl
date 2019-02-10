###############################################################################
#
# Copyright (C) 2018 Xilinx, Inc.  All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# Use of the Software is limited solely to applications:
# (a) running on a Xilinx device, or
# (b) that interact with a Xilinx device through a bus or interconnect.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
# OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Except as contained in this notice, the name of the Xilinx shall not be used
# in advertising or otherwise to promote the sale, use or other dealings in
# this Software without prior written authorization from Xilinx.
#
###############################################################################
#
# Modification History
#
# Ver   Who  Date     Changes
# ----- ---- -------- -----------------------------------------------
# 1.0   sa   18/04/25 Initial version
##############################################################################
#uses "xillib.tcl"

############################################################
# "generate" procedure
############################################################
proc generate {drv_handle} {

    xdefine_cortexm1_params $drv_handle
    ::hsi::utils::define_include_file $drv_handle "xparameters.h" "XCPU_CORTEXM1" "C_CPU_CLK_FREQ_HZ"
    ::hsi::utils::define_canonical_xpars $drv_handle "xparameters.h" "CPU_CORTEXM1" "C_CPU_CLK_FREQ_HZ"
    xdefine_addr_params_for_ext_intf $drv_handle "xparameters.h"
}

proc xdefine_cortexm1_params {drvhandle} {

    set sw_proc_handle [hsi::get_sw_processor]
    set hw_proc_handle [hsi::get_cells -hier [common::get_property HW_INSTANCE $sw_proc_handle ]]
    set procdrv [hsi::get_sw_processor]
    set compiler [common::get_property CONFIG.compiler $procdrv]
    set compiler_name [file tail $compiler]
    set archiver [common::get_property CONFIG.archiver $procdrv]
    set extra_flags [::common::get_property VALUE [hsi::get_comp_params -filter { NAME == extra_compiler_flags } ] ]
    if {[string compare -nocase $compiler_name "arm-none-eabi-gcc"] == 0} {
        # -mtune=cortex-m1
        # -mtune=cortex-m1.small-multiply
        # -mlittle-endian
        # -mbig-endian -mbe8
	set temp_flag $extra_flags
	if {[string compare -nocase $temp_flag "-march=armv6-m -mthumb -Wall -Wextra "] != 0} {
		set flagindex [string first {-march=armv6-m} $temp_flag 0]
		if { $flagindex == -1 } {
		    set temp_flag "$temp_flag -march=armv6-m"
		}
		set flagindex [string first {-mthumb} $temp_flag 0]
		if { $flagindex == -1 } {
		    set temp_flag "$temp_flag -mthumb"
		}
		set flagindex [string first {-Wall} $temp_flag 0]
		if { $flagindex == -1 } {
                    set temp_flag "$temp_flag -Wall"
		}
		set flagindex [string first {-Wextra} $temp_flag 0]
		if { $flagindex == -1 } {
		    set temp_flag "$temp_flag -Wextra"
		}
		set extra_flags $temp_flag
		common::set_property -name VALUE -value $extra_flags -objects  [hsi::get_comp_params -filter { NAME == extra_compiler_flags } ]
	}
   } elseif {[string compare -nocase $compiler_name "iccarm"] == 0} {
	set temp_flag $extra_flags
	if {[string compare -nocase $temp_flag "--debug"] != 0} {
		regsub -- {-march=armv6-m -Wall -Wextra} $temp_flag "" temp_flag
		regsub -- {--debug } $temp_flag "" temp_flag
		set extra_flags "--debug $temp_flag"
		common::set_property -name VALUE -value $extra_flags -objects  [hsi::get_comp_params -filter { NAME == extra_compiler_flags } ]
	}

	set compiler_flags [::common::get_property VALUE [hsi::get_comp_params -filter { NAME == compiler_flags } ] ]
	if {[string compare -nocase $compiler_flags "-Om --cpu=Cortex-M1"] != 0} {
		regsub -- "-O2 -c" $compiler_flags "" compiler_flags
		regsub -- {-Om --cpu=Cortex-M1 } $compiler_flags "" compiler_flags
		set compiler_flags "-Om --cpu=Cortex-M1 $compiler_flags"
		common::set_property -name VALUE -value $compiler_flags -objects  [hsi::get_comp_params -filter { NAME == compiler_flags } ]
	}
   } elseif {[string compare -nocase $compiler_name "arm-xilinx-eabi-gcc"] == 0
	    || [string compare -nocase $compiler_name "armcc"] == 0} {
	set temp_flag $extra_flags
	if {[string compare -nocase $temp_flag "-g"] != 0} {
		regsub -- {-march=armv6-m -Wall -Wextra} $temp_flag {} temp_flag
		regsub -- {-g } $temp_flag "" temp_flag
		set extra_flags "-g $temp_flag"
		common::set_property -name VALUE -value $extra_flags -objects  [hsi::get_comp_params -filter { NAME == extra_compiler_flags }]
	}
    } else {
	common::set_property -name VALUE -value $extra_flags -objects  [hsi::get_comp_params -filter { NAME == extra_compiler_flags } ]
    }

    if {[string first "iarchive" $archiver] < 0 } {
    } else {
    	 set libxil_a [file join .. .. lib libxil.a]
	 if { ![file exists $libxil_a] } {
	 # create empty libxil.a
	 	set fd [open "test.a" a+]
	    	close $fd
	    	exec $archiver --create --output $libxil_a test.a
	    	file delete -force test.a
    	}
    }
    set periphs [::hsi::utils::get_common_driver_ips $drvhandle]
    set lprocs [hsi::get_cells -hier -filter "IP_NAME==CORTEXM1_AXI"]
    set lprocs [lsort $lprocs]

    set config_inc [::hsi::utils::open_include_file "xparameters.h"]
    puts $config_inc "#ifndef XPARAMETERS_H   /* prevent circular inclusions */"
    puts $config_inc "#define XPARAMETERS_H   /* by using protection macros */"
    puts $config_inc ""
    puts $config_inc "/* Definition for CPU ID */"

    foreach periph $periphs {
        set iname [common::get_property NAME $periph]
	
	#-----------
	# Set CPU ID
	#-----------
	set id 0
	set uSuffix "U"
	foreach processor $lprocs {
	    if {[string compare -nocase $processor $iname] == 0} {
		puts $config_inc "#define XPAR_CPU_ID $id$uSuffix"
	    }
	    incr id
	}
    }
    
    close $config_inc
}

proc xdefine_addr_params_for_ext_intf {drvhandle file_name} {
    set sw_proc_handle [hsi::get_sw_processor]
    set hw_proc_handle [hsi::get_cells -hier [common::get_property HW_INSTANCE $sw_proc_handle ]]
    
 # Open include file
   set file_handle [::hsi::utils::open_include_file $file_name]

   set mem_ranges [hsi::get_mem_ranges -of_objects $hw_proc_handle]
   foreach mem_range $mem_ranges {
       set inst [common::get_property INSTANCE $mem_range]
       if {$inst != ""} {
            continue
       } 
    
        
       set bparam_name [common::get_property BASE_NAME $mem_range]
       set bparam_value [common::get_property BASE_VALUE $mem_range]
       set hparam_name [common::get_property HIGH_NAME $mem_range]
       set hparam_value [common::get_property HIGH_VALUE $mem_range]

       # Print all parameters for all peripherals
           

           set name [string toupper [common::get_property NAME $mem_range]]
	   puts $file_handle ""
           puts $file_handle "/* Definitions for interface [string toupper $name] */"
           set name [format "XPAR_%s_" $name]
           

           if {$bparam_value != ""} {
               set value [::hsi::utils::format_addr_string $bparam_value $bparam_name]
                   set param [string toupper $bparam_name]
                   if {[string match C_* $param]} {
                       set name [format "%s%s" $name [string range $param 2 end]]
                   } else {
                       set name [format "%s%s" $name $param]
                   }
               set xparam_name [::hsi::utils::format_xparam_name $name]
	       puts $file_handle "#define $xparam_name $value"

           }

	   set name [string toupper [common::get_property NAME $mem_range]]
           set name [format "XPAR_%s_" $name]
           if {$hparam_value != ""} {
               set value [::hsi::utils::format_addr_string $hparam_value $hparam_name]
                set param [string toupper $hparam_name]
                   if {[string match C_* $param]} {
                       set name [format "%s%s" $name [string range $param 2 end]]
                   } else {
                       set name [format "%s%s" $name $param]
                   }
               set xparam_name [::hsi::utils::format_xparam_name $name]
	       puts $file_handle "#define $xparam_name $value"

           }

           
           puts $file_handle ""
      }		

    close $file_handle
}

proc post_generate_final {drv_handle} {

	set type [get_property CLASS $drv_handle]
	if {[string equal $type "driver"]} {
	   return
	}

	set file_handle [::hsi::utils::open_include_file "xparameters.h"]
	puts $file_handle "#endif  /* end of protection macro */"
	close $file_handle
}
