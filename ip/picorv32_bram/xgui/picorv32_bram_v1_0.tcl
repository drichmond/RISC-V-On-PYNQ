# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BARREL_SHIFTER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CATCH_ILLINSN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CATCH_MISALIGN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "COMPRESSED_ISA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_COUNTERS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_COUNTERS64" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_DIV" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_FAST_MUL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_IRQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_IRQ_QREGS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_IRQ_TIMER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_MUL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_PCPI" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_REGS_16_31" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_REGS_DUALPORT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_TRACE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LATCHED_IRQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MASKED_IRQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PROGADDR_IRQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PROGADDR_RESET" -parent ${Page_0}
  ipgui::add_param $IPINST -name "REGS_INIT_ZERO" -parent ${Page_0}
  ipgui::add_param $IPINST -name "STACKADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TWO_CYCLE_ALU" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TWO_CYCLE_COMPARE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TWO_STAGE_SHIFT" -parent ${Page_0}

  ipgui::add_param $IPINST -name "ENABLE_LOOKAHEAD"
  set LATCHED_MEM_RDATA [ipgui::add_param $IPINST -name "LATCHED_MEM_RDATA"]
  set_property tooltip {Set to 1 if RDATA of BRAM interface is latched and does not change after read} ${LATCHED_MEM_RDATA}

}

proc update_PARAM_VALUE.BARREL_SHIFTER { PARAM_VALUE.BARREL_SHIFTER } {
	# Procedure called to update BARREL_SHIFTER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BARREL_SHIFTER { PARAM_VALUE.BARREL_SHIFTER } {
	# Procedure called to validate BARREL_SHIFTER
	return true
}

proc update_PARAM_VALUE.CATCH_ILLINSN { PARAM_VALUE.CATCH_ILLINSN } {
	# Procedure called to update CATCH_ILLINSN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CATCH_ILLINSN { PARAM_VALUE.CATCH_ILLINSN } {
	# Procedure called to validate CATCH_ILLINSN
	return true
}

proc update_PARAM_VALUE.CATCH_MISALIGN { PARAM_VALUE.CATCH_MISALIGN } {
	# Procedure called to update CATCH_MISALIGN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CATCH_MISALIGN { PARAM_VALUE.CATCH_MISALIGN } {
	# Procedure called to validate CATCH_MISALIGN
	return true
}

proc update_PARAM_VALUE.COMPRESSED_ISA { PARAM_VALUE.COMPRESSED_ISA } {
	# Procedure called to update COMPRESSED_ISA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COMPRESSED_ISA { PARAM_VALUE.COMPRESSED_ISA } {
	# Procedure called to validate COMPRESSED_ISA
	return true
}

proc update_PARAM_VALUE.ENABLE_COUNTERS { PARAM_VALUE.ENABLE_COUNTERS } {
	# Procedure called to update ENABLE_COUNTERS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_COUNTERS { PARAM_VALUE.ENABLE_COUNTERS } {
	# Procedure called to validate ENABLE_COUNTERS
	return true
}

proc update_PARAM_VALUE.ENABLE_COUNTERS64 { PARAM_VALUE.ENABLE_COUNTERS64 } {
	# Procedure called to update ENABLE_COUNTERS64 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_COUNTERS64 { PARAM_VALUE.ENABLE_COUNTERS64 } {
	# Procedure called to validate ENABLE_COUNTERS64
	return true
}

proc update_PARAM_VALUE.ENABLE_DIV { PARAM_VALUE.ENABLE_DIV } {
	# Procedure called to update ENABLE_DIV when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_DIV { PARAM_VALUE.ENABLE_DIV } {
	# Procedure called to validate ENABLE_DIV
	return true
}

proc update_PARAM_VALUE.ENABLE_FAST_MUL { PARAM_VALUE.ENABLE_FAST_MUL } {
	# Procedure called to update ENABLE_FAST_MUL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_FAST_MUL { PARAM_VALUE.ENABLE_FAST_MUL } {
	# Procedure called to validate ENABLE_FAST_MUL
	return true
}

proc update_PARAM_VALUE.ENABLE_IRQ { PARAM_VALUE.ENABLE_IRQ } {
	# Procedure called to update ENABLE_IRQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_IRQ { PARAM_VALUE.ENABLE_IRQ } {
	# Procedure called to validate ENABLE_IRQ
	return true
}

proc update_PARAM_VALUE.ENABLE_IRQ_QREGS { PARAM_VALUE.ENABLE_IRQ_QREGS } {
	# Procedure called to update ENABLE_IRQ_QREGS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_IRQ_QREGS { PARAM_VALUE.ENABLE_IRQ_QREGS } {
	# Procedure called to validate ENABLE_IRQ_QREGS
	return true
}

proc update_PARAM_VALUE.ENABLE_IRQ_TIMER { PARAM_VALUE.ENABLE_IRQ_TIMER } {
	# Procedure called to update ENABLE_IRQ_TIMER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_IRQ_TIMER { PARAM_VALUE.ENABLE_IRQ_TIMER } {
	# Procedure called to validate ENABLE_IRQ_TIMER
	return true
}

proc update_PARAM_VALUE.ENABLE_LOOKAHEAD { PARAM_VALUE.ENABLE_LOOKAHEAD } {
	# Procedure called to update ENABLE_LOOKAHEAD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_LOOKAHEAD { PARAM_VALUE.ENABLE_LOOKAHEAD } {
	# Procedure called to validate ENABLE_LOOKAHEAD
	return true
}

proc update_PARAM_VALUE.ENABLE_MUL { PARAM_VALUE.ENABLE_MUL } {
	# Procedure called to update ENABLE_MUL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_MUL { PARAM_VALUE.ENABLE_MUL } {
	# Procedure called to validate ENABLE_MUL
	return true
}

proc update_PARAM_VALUE.ENABLE_PCPI { PARAM_VALUE.ENABLE_PCPI } {
	# Procedure called to update ENABLE_PCPI when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_PCPI { PARAM_VALUE.ENABLE_PCPI } {
	# Procedure called to validate ENABLE_PCPI
	return true
}

proc update_PARAM_VALUE.ENABLE_REGS_16_31 { PARAM_VALUE.ENABLE_REGS_16_31 } {
	# Procedure called to update ENABLE_REGS_16_31 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_REGS_16_31 { PARAM_VALUE.ENABLE_REGS_16_31 } {
	# Procedure called to validate ENABLE_REGS_16_31
	return true
}

proc update_PARAM_VALUE.ENABLE_REGS_DUALPORT { PARAM_VALUE.ENABLE_REGS_DUALPORT } {
	# Procedure called to update ENABLE_REGS_DUALPORT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_REGS_DUALPORT { PARAM_VALUE.ENABLE_REGS_DUALPORT } {
	# Procedure called to validate ENABLE_REGS_DUALPORT
	return true
}

proc update_PARAM_VALUE.ENABLE_TRACE { PARAM_VALUE.ENABLE_TRACE } {
	# Procedure called to update ENABLE_TRACE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_TRACE { PARAM_VALUE.ENABLE_TRACE } {
	# Procedure called to validate ENABLE_TRACE
	return true
}

proc update_PARAM_VALUE.LATCHED_IRQ { PARAM_VALUE.LATCHED_IRQ } {
	# Procedure called to update LATCHED_IRQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LATCHED_IRQ { PARAM_VALUE.LATCHED_IRQ } {
	# Procedure called to validate LATCHED_IRQ
	return true
}

proc update_PARAM_VALUE.LATCHED_MEM_RDATA { PARAM_VALUE.LATCHED_MEM_RDATA } {
	# Procedure called to update LATCHED_MEM_RDATA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LATCHED_MEM_RDATA { PARAM_VALUE.LATCHED_MEM_RDATA } {
	# Procedure called to validate LATCHED_MEM_RDATA
	return true
}

proc update_PARAM_VALUE.MASKED_IRQ { PARAM_VALUE.MASKED_IRQ } {
	# Procedure called to update MASKED_IRQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MASKED_IRQ { PARAM_VALUE.MASKED_IRQ } {
	# Procedure called to validate MASKED_IRQ
	return true
}

proc update_PARAM_VALUE.PROGADDR_IRQ { PARAM_VALUE.PROGADDR_IRQ } {
	# Procedure called to update PROGADDR_IRQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PROGADDR_IRQ { PARAM_VALUE.PROGADDR_IRQ } {
	# Procedure called to validate PROGADDR_IRQ
	return true
}

proc update_PARAM_VALUE.PROGADDR_RESET { PARAM_VALUE.PROGADDR_RESET } {
	# Procedure called to update PROGADDR_RESET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PROGADDR_RESET { PARAM_VALUE.PROGADDR_RESET } {
	# Procedure called to validate PROGADDR_RESET
	return true
}

proc update_PARAM_VALUE.REGS_INIT_ZERO { PARAM_VALUE.REGS_INIT_ZERO } {
	# Procedure called to update REGS_INIT_ZERO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REGS_INIT_ZERO { PARAM_VALUE.REGS_INIT_ZERO } {
	# Procedure called to validate REGS_INIT_ZERO
	return true
}

proc update_PARAM_VALUE.STACKADDR { PARAM_VALUE.STACKADDR } {
	# Procedure called to update STACKADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STACKADDR { PARAM_VALUE.STACKADDR } {
	# Procedure called to validate STACKADDR
	return true
}

proc update_PARAM_VALUE.TWO_CYCLE_ALU { PARAM_VALUE.TWO_CYCLE_ALU } {
	# Procedure called to update TWO_CYCLE_ALU when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TWO_CYCLE_ALU { PARAM_VALUE.TWO_CYCLE_ALU } {
	# Procedure called to validate TWO_CYCLE_ALU
	return true
}

proc update_PARAM_VALUE.TWO_CYCLE_COMPARE { PARAM_VALUE.TWO_CYCLE_COMPARE } {
	# Procedure called to update TWO_CYCLE_COMPARE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TWO_CYCLE_COMPARE { PARAM_VALUE.TWO_CYCLE_COMPARE } {
	# Procedure called to validate TWO_CYCLE_COMPARE
	return true
}

proc update_PARAM_VALUE.TWO_STAGE_SHIFT { PARAM_VALUE.TWO_STAGE_SHIFT } {
	# Procedure called to update TWO_STAGE_SHIFT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TWO_STAGE_SHIFT { PARAM_VALUE.TWO_STAGE_SHIFT } {
	# Procedure called to validate TWO_STAGE_SHIFT
	return true
}


proc update_MODELPARAM_VALUE.ENABLE_COUNTERS { MODELPARAM_VALUE.ENABLE_COUNTERS PARAM_VALUE.ENABLE_COUNTERS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_COUNTERS}] ${MODELPARAM_VALUE.ENABLE_COUNTERS}
}

proc update_MODELPARAM_VALUE.ENABLE_COUNTERS64 { MODELPARAM_VALUE.ENABLE_COUNTERS64 PARAM_VALUE.ENABLE_COUNTERS64 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_COUNTERS64}] ${MODELPARAM_VALUE.ENABLE_COUNTERS64}
}

proc update_MODELPARAM_VALUE.ENABLE_REGS_16_31 { MODELPARAM_VALUE.ENABLE_REGS_16_31 PARAM_VALUE.ENABLE_REGS_16_31 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_REGS_16_31}] ${MODELPARAM_VALUE.ENABLE_REGS_16_31}
}

proc update_MODELPARAM_VALUE.ENABLE_REGS_DUALPORT { MODELPARAM_VALUE.ENABLE_REGS_DUALPORT PARAM_VALUE.ENABLE_REGS_DUALPORT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_REGS_DUALPORT}] ${MODELPARAM_VALUE.ENABLE_REGS_DUALPORT}
}

proc update_MODELPARAM_VALUE.TWO_STAGE_SHIFT { MODELPARAM_VALUE.TWO_STAGE_SHIFT PARAM_VALUE.TWO_STAGE_SHIFT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TWO_STAGE_SHIFT}] ${MODELPARAM_VALUE.TWO_STAGE_SHIFT}
}

proc update_MODELPARAM_VALUE.BARREL_SHIFTER { MODELPARAM_VALUE.BARREL_SHIFTER PARAM_VALUE.BARREL_SHIFTER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BARREL_SHIFTER}] ${MODELPARAM_VALUE.BARREL_SHIFTER}
}

proc update_MODELPARAM_VALUE.TWO_CYCLE_COMPARE { MODELPARAM_VALUE.TWO_CYCLE_COMPARE PARAM_VALUE.TWO_CYCLE_COMPARE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TWO_CYCLE_COMPARE}] ${MODELPARAM_VALUE.TWO_CYCLE_COMPARE}
}

proc update_MODELPARAM_VALUE.TWO_CYCLE_ALU { MODELPARAM_VALUE.TWO_CYCLE_ALU PARAM_VALUE.TWO_CYCLE_ALU } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TWO_CYCLE_ALU}] ${MODELPARAM_VALUE.TWO_CYCLE_ALU}
}

proc update_MODELPARAM_VALUE.COMPRESSED_ISA { MODELPARAM_VALUE.COMPRESSED_ISA PARAM_VALUE.COMPRESSED_ISA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COMPRESSED_ISA}] ${MODELPARAM_VALUE.COMPRESSED_ISA}
}

proc update_MODELPARAM_VALUE.CATCH_MISALIGN { MODELPARAM_VALUE.CATCH_MISALIGN PARAM_VALUE.CATCH_MISALIGN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CATCH_MISALIGN}] ${MODELPARAM_VALUE.CATCH_MISALIGN}
}

proc update_MODELPARAM_VALUE.CATCH_ILLINSN { MODELPARAM_VALUE.CATCH_ILLINSN PARAM_VALUE.CATCH_ILLINSN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CATCH_ILLINSN}] ${MODELPARAM_VALUE.CATCH_ILLINSN}
}

proc update_MODELPARAM_VALUE.ENABLE_PCPI { MODELPARAM_VALUE.ENABLE_PCPI PARAM_VALUE.ENABLE_PCPI } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_PCPI}] ${MODELPARAM_VALUE.ENABLE_PCPI}
}

proc update_MODELPARAM_VALUE.ENABLE_MUL { MODELPARAM_VALUE.ENABLE_MUL PARAM_VALUE.ENABLE_MUL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_MUL}] ${MODELPARAM_VALUE.ENABLE_MUL}
}

proc update_MODELPARAM_VALUE.ENABLE_FAST_MUL { MODELPARAM_VALUE.ENABLE_FAST_MUL PARAM_VALUE.ENABLE_FAST_MUL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_FAST_MUL}] ${MODELPARAM_VALUE.ENABLE_FAST_MUL}
}

proc update_MODELPARAM_VALUE.ENABLE_DIV { MODELPARAM_VALUE.ENABLE_DIV PARAM_VALUE.ENABLE_DIV } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_DIV}] ${MODELPARAM_VALUE.ENABLE_DIV}
}

proc update_MODELPARAM_VALUE.ENABLE_IRQ { MODELPARAM_VALUE.ENABLE_IRQ PARAM_VALUE.ENABLE_IRQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_IRQ}] ${MODELPARAM_VALUE.ENABLE_IRQ}
}

proc update_MODELPARAM_VALUE.ENABLE_IRQ_QREGS { MODELPARAM_VALUE.ENABLE_IRQ_QREGS PARAM_VALUE.ENABLE_IRQ_QREGS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_IRQ_QREGS}] ${MODELPARAM_VALUE.ENABLE_IRQ_QREGS}
}

proc update_MODELPARAM_VALUE.ENABLE_IRQ_TIMER { MODELPARAM_VALUE.ENABLE_IRQ_TIMER PARAM_VALUE.ENABLE_IRQ_TIMER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_IRQ_TIMER}] ${MODELPARAM_VALUE.ENABLE_IRQ_TIMER}
}

proc update_MODELPARAM_VALUE.ENABLE_TRACE { MODELPARAM_VALUE.ENABLE_TRACE PARAM_VALUE.ENABLE_TRACE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ENABLE_TRACE}] ${MODELPARAM_VALUE.ENABLE_TRACE}
}

proc update_MODELPARAM_VALUE.REGS_INIT_ZERO { MODELPARAM_VALUE.REGS_INIT_ZERO PARAM_VALUE.REGS_INIT_ZERO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REGS_INIT_ZERO}] ${MODELPARAM_VALUE.REGS_INIT_ZERO}
}

proc update_MODELPARAM_VALUE.MASKED_IRQ { MODELPARAM_VALUE.MASKED_IRQ PARAM_VALUE.MASKED_IRQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MASKED_IRQ}] ${MODELPARAM_VALUE.MASKED_IRQ}
}

proc update_MODELPARAM_VALUE.LATCHED_IRQ { MODELPARAM_VALUE.LATCHED_IRQ PARAM_VALUE.LATCHED_IRQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LATCHED_IRQ}] ${MODELPARAM_VALUE.LATCHED_IRQ}
}

proc update_MODELPARAM_VALUE.PROGADDR_RESET { MODELPARAM_VALUE.PROGADDR_RESET PARAM_VALUE.PROGADDR_RESET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PROGADDR_RESET}] ${MODELPARAM_VALUE.PROGADDR_RESET}
}

proc update_MODELPARAM_VALUE.PROGADDR_IRQ { MODELPARAM_VALUE.PROGADDR_IRQ PARAM_VALUE.PROGADDR_IRQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PROGADDR_IRQ}] ${MODELPARAM_VALUE.PROGADDR_IRQ}
}

proc update_MODELPARAM_VALUE.STACKADDR { MODELPARAM_VALUE.STACKADDR PARAM_VALUE.STACKADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STACKADDR}] ${MODELPARAM_VALUE.STACKADDR}
}

proc update_MODELPARAM_VALUE.LATCHED_MEM_RDATA { MODELPARAM_VALUE.LATCHED_MEM_RDATA PARAM_VALUE.LATCHED_MEM_RDATA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LATCHED_MEM_RDATA}] ${MODELPARAM_VALUE.LATCHED_MEM_RDATA}
}

