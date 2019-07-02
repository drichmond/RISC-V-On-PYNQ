# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_DELAY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_USE_LOOKAHEAD" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_ADDR_WIDTH { PARAM_VALUE.C_ADDR_WIDTH } {
	# Procedure called to update C_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_ADDR_WIDTH { PARAM_VALUE.C_ADDR_WIDTH } {
	# Procedure called to validate C_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_DELAY { PARAM_VALUE.C_DELAY } {
	# Procedure called to update C_DELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_DELAY { PARAM_VALUE.C_DELAY } {
	# Procedure called to validate C_DELAY
	return true
}

proc update_PARAM_VALUE.C_USE_LOOKAHEAD { PARAM_VALUE.C_USE_LOOKAHEAD } {
	# Procedure called to update C_USE_LOOKAHEAD when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_USE_LOOKAHEAD { PARAM_VALUE.C_USE_LOOKAHEAD } {
	# Procedure called to validate C_USE_LOOKAHEAD
	return true
}


proc update_MODELPARAM_VALUE.C_DELAY { MODELPARAM_VALUE.C_DELAY PARAM_VALUE.C_DELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_DELAY}] ${MODELPARAM_VALUE.C_DELAY}
}

proc update_MODELPARAM_VALUE.C_USE_LOOKAHEAD { MODELPARAM_VALUE.C_USE_LOOKAHEAD PARAM_VALUE.C_USE_LOOKAHEAD } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_USE_LOOKAHEAD}] ${MODELPARAM_VALUE.C_USE_LOOKAHEAD}
}

proc update_MODELPARAM_VALUE.C_ADDR_WIDTH { MODELPARAM_VALUE.C_ADDR_WIDTH PARAM_VALUE.C_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_ADDR_WIDTH}
}

