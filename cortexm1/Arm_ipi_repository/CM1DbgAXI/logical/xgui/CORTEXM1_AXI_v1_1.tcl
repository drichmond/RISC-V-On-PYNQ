# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Configuration [ipgui::add_page $IPINST -name "Configuration"]
  set_property tooltip {Basic configuration} ${Configuration}
  set NUM_IRQ [ipgui::add_param $IPINST -name "NUM_IRQ" -parent ${Configuration}]
  set_property tooltip {Number of interrupts.  Note IRQ port is fixed to 32.  Unused IRQ can be left floating.} ${NUM_IRQ}
  set OS [ipgui::add_param $IPINST -name "OS" -parent ${Configuration}]
  set_property tooltip {Enable to support OS extensions in hardware} ${OS}
  set SMALL_MUL [ipgui::add_param $IPINST -name "SMALL_MUL" -parent ${Configuration}]
  set_property tooltip {Enable to select smaller multiplier implementation.  Standard multiplier is 3 cycles} ${SMALL_MUL}
  set BE8 [ipgui::add_param $IPINST -name "BE8" -parent ${Configuration}]
  set_property tooltip {Enable to set core to big endian operation.  Default is small endian} ${BE8}

  #Adding Page
  set Debug [ipgui::add_page $IPINST -name "Debug"]
  set_property tooltip {Debug options} ${Debug}
  ipgui::add_param $IPINST -name "DEBUG_SEL" -parent ${Debug}
  ipgui::add_param $IPINST -name "SMALL_DEBUG" -parent ${Debug}

  #Adding Page
  set Instruction_Memory [ipgui::add_page $IPINST -name "Instruction Memory"]
  set_property tooltip {Configure the size and intialisation of the instruction memory} ${Instruction_Memory}
  ipgui::add_param $IPINST -name "ITCM_SIZE" -parent ${Instruction_Memory} -widget comboBox
  ipgui::add_param $IPINST -name "ITCM_INIT_RAM" -parent ${Instruction_Memory}
  set ITCM_INIT_FILE [ipgui::add_param $IPINST -name "ITCM_INIT_FILE" -parent ${Instruction_Memory}]
  set_property tooltip {Instruction memory Initialisation file name} ${ITCM_INIT_FILE}

  #Adding Page
  set Data_Memory [ipgui::add_page $IPINST -name "Data Memory"]
  set_property tooltip {Configure and initialise data memory} ${Data_Memory}
  ipgui::add_param $IPINST -name "DTCM_SIZE" -parent ${Data_Memory} -widget comboBox
  ipgui::add_param $IPINST -name "DTCM_INIT_RAM" -parent ${Data_Memory}
  set DTCM_INIT_FILE [ipgui::add_param $IPINST -name "DTCM_INIT_FILE" -parent ${Data_Memory}]
  set_property tooltip {Data memory initialisation file name} ${DTCM_INIT_FILE}


}

proc update_PARAM_VALUE.AUSER_MAX { PARAM_VALUE.AUSER_MAX } {
	# Procedure called to update AUSER_MAX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUSER_MAX { PARAM_VALUE.AUSER_MAX } {
	# Procedure called to validate AUSER_MAX
	return true
}

proc update_PARAM_VALUE.AUSER_WIDTH { PARAM_VALUE.AUSER_WIDTH } {
	# Procedure called to update AUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AUSER_WIDTH { PARAM_VALUE.AUSER_WIDTH } {
	# Procedure called to validate AUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.BE8 { PARAM_VALUE.BE8 } {
	# Procedure called to update BE8 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BE8 { PARAM_VALUE.BE8 } {
	# Procedure called to validate BE8
	return true
}

proc update_PARAM_VALUE.DEBUG_SEL { PARAM_VALUE.DEBUG_SEL } {
	# Procedure called to update DEBUG_SEL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEBUG_SEL { PARAM_VALUE.DEBUG_SEL } {
	# Procedure called to validate DEBUG_SEL
	return true
}

proc update_PARAM_VALUE.DTCM_INIT_FILE { PARAM_VALUE.DTCM_INIT_FILE } {
	# Procedure called to update DTCM_INIT_FILE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DTCM_INIT_FILE { PARAM_VALUE.DTCM_INIT_FILE } {
	# Procedure called to validate DTCM_INIT_FILE
	return true
}

proc update_PARAM_VALUE.DTCM_INIT_RAM { PARAM_VALUE.DTCM_INIT_RAM } {
	# Procedure called to update DTCM_INIT_RAM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DTCM_INIT_RAM { PARAM_VALUE.DTCM_INIT_RAM } {
	# Procedure called to validate DTCM_INIT_RAM
	return true
}

proc update_PARAM_VALUE.DTCM_SIZE { PARAM_VALUE.DTCM_SIZE } {
	# Procedure called to update DTCM_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DTCM_SIZE { PARAM_VALUE.DTCM_SIZE } {
	# Procedure called to validate DTCM_SIZE
	return true
}

proc update_PARAM_VALUE.ITCM_INIT_FILE { PARAM_VALUE.ITCM_INIT_FILE } {
	# Procedure called to update ITCM_INIT_FILE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ITCM_INIT_FILE { PARAM_VALUE.ITCM_INIT_FILE } {
	# Procedure called to validate ITCM_INIT_FILE
	return true
}

proc update_PARAM_VALUE.ITCM_INIT_RAM { PARAM_VALUE.ITCM_INIT_RAM } {
	# Procedure called to update ITCM_INIT_RAM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ITCM_INIT_RAM { PARAM_VALUE.ITCM_INIT_RAM } {
	# Procedure called to validate ITCM_INIT_RAM
	return true
}

proc update_PARAM_VALUE.ITCM_SIZE { PARAM_VALUE.ITCM_SIZE } {
	# Procedure called to update ITCM_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ITCM_SIZE { PARAM_VALUE.ITCM_SIZE } {
	# Procedure called to validate ITCM_SIZE
	return true
}

proc update_PARAM_VALUE.NUM_IRQ { PARAM_VALUE.NUM_IRQ } {
	# Procedure called to update NUM_IRQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_IRQ { PARAM_VALUE.NUM_IRQ } {
	# Procedure called to validate NUM_IRQ
	return true
}

proc update_PARAM_VALUE.OS { PARAM_VALUE.OS } {
	# Procedure called to update OS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OS { PARAM_VALUE.OS } {
	# Procedure called to validate OS
	return true
}

proc update_PARAM_VALUE.SMALL_DEBUG { PARAM_VALUE.SMALL_DEBUG } {
	# Procedure called to update SMALL_DEBUG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SMALL_DEBUG { PARAM_VALUE.SMALL_DEBUG } {
	# Procedure called to validate SMALL_DEBUG
	return true
}

proc update_PARAM_VALUE.SMALL_MUL { PARAM_VALUE.SMALL_MUL } {
	# Procedure called to update SMALL_MUL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SMALL_MUL { PARAM_VALUE.SMALL_MUL } {
	# Procedure called to validate SMALL_MUL
	return true
}

proc update_PARAM_VALUE.STRB_MAX { PARAM_VALUE.STRB_MAX } {
	# Procedure called to update STRB_MAX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STRB_MAX { PARAM_VALUE.STRB_MAX } {
	# Procedure called to validate STRB_MAX
	return true
}

proc update_PARAM_VALUE.STRB_WIDTH { PARAM_VALUE.STRB_WIDTH } {
	# Procedure called to update STRB_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STRB_WIDTH { PARAM_VALUE.STRB_WIDTH } {
	# Procedure called to validate STRB_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.NUM_IRQ { MODELPARAM_VALUE.NUM_IRQ PARAM_VALUE.NUM_IRQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_IRQ}] ${MODELPARAM_VALUE.NUM_IRQ}
}

proc update_MODELPARAM_VALUE.OS { MODELPARAM_VALUE.OS PARAM_VALUE.OS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OS}] ${MODELPARAM_VALUE.OS}
}

proc update_MODELPARAM_VALUE.SMALL_MUL { MODELPARAM_VALUE.SMALL_MUL PARAM_VALUE.SMALL_MUL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SMALL_MUL}] ${MODELPARAM_VALUE.SMALL_MUL}
}

proc update_MODELPARAM_VALUE.BE8 { MODELPARAM_VALUE.BE8 PARAM_VALUE.BE8 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BE8}] ${MODELPARAM_VALUE.BE8}
}

proc update_MODELPARAM_VALUE.ITCM_SIZE { MODELPARAM_VALUE.ITCM_SIZE PARAM_VALUE.ITCM_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ITCM_SIZE}] ${MODELPARAM_VALUE.ITCM_SIZE}
}

proc update_MODELPARAM_VALUE.DTCM_SIZE { MODELPARAM_VALUE.DTCM_SIZE PARAM_VALUE.DTCM_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DTCM_SIZE}] ${MODELPARAM_VALUE.DTCM_SIZE}
}

proc update_MODELPARAM_VALUE.SMALL_DEBUG { MODELPARAM_VALUE.SMALL_DEBUG PARAM_VALUE.SMALL_DEBUG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SMALL_DEBUG}] ${MODELPARAM_VALUE.SMALL_DEBUG}
}

proc update_MODELPARAM_VALUE.ITCM_INIT_RAM { MODELPARAM_VALUE.ITCM_INIT_RAM PARAM_VALUE.ITCM_INIT_RAM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ITCM_INIT_RAM}] ${MODELPARAM_VALUE.ITCM_INIT_RAM}
}

proc update_MODELPARAM_VALUE.DTCM_INIT_RAM { MODELPARAM_VALUE.DTCM_INIT_RAM PARAM_VALUE.DTCM_INIT_RAM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DTCM_INIT_RAM}] ${MODELPARAM_VALUE.DTCM_INIT_RAM}
}

proc update_MODELPARAM_VALUE.ITCM_INIT_FILE { MODELPARAM_VALUE.ITCM_INIT_FILE PARAM_VALUE.ITCM_INIT_FILE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ITCM_INIT_FILE}] ${MODELPARAM_VALUE.ITCM_INIT_FILE}
}

proc update_MODELPARAM_VALUE.DTCM_INIT_FILE { MODELPARAM_VALUE.DTCM_INIT_FILE PARAM_VALUE.DTCM_INIT_FILE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DTCM_INIT_FILE}] ${MODELPARAM_VALUE.DTCM_INIT_FILE}
}

proc update_MODELPARAM_VALUE.DEBUG_SEL { MODELPARAM_VALUE.DEBUG_SEL PARAM_VALUE.DEBUG_SEL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEBUG_SEL}] ${MODELPARAM_VALUE.DEBUG_SEL}
}

proc update_MODELPARAM_VALUE.AUSER_MAX { MODELPARAM_VALUE.AUSER_MAX PARAM_VALUE.AUSER_MAX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUSER_MAX}] ${MODELPARAM_VALUE.AUSER_MAX}
}

proc update_MODELPARAM_VALUE.STRB_MAX { MODELPARAM_VALUE.STRB_MAX PARAM_VALUE.STRB_MAX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STRB_MAX}] ${MODELPARAM_VALUE.STRB_MAX}
}

proc update_MODELPARAM_VALUE.AUSER_WIDTH { MODELPARAM_VALUE.AUSER_WIDTH PARAM_VALUE.AUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AUSER_WIDTH}] ${MODELPARAM_VALUE.AUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.STRB_WIDTH { MODELPARAM_VALUE.STRB_WIDTH PARAM_VALUE.STRB_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STRB_WIDTH}] ${MODELPARAM_VALUE.STRB_WIDTH}
}

