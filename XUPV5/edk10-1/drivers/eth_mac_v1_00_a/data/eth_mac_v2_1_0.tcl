##############################################################################
## Filename:          C:\ML505\Tutorials\EthernetMAC/drivers/eth_mac_v1_00_a/data/eth_mac_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Thu Nov 27 10:26:32 2008 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "eth_mac" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
