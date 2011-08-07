-------------------------------------------------------------------------------
-- Title      : Virtex-5 Ethernet MAC Wrapper
-------------------------------------------------------------------------------
-- File       : v5_emac_v1_5.v
-- Author     : Xilinx
-------------------------------------------------------------------------------
-- Copyright (c) 2004-2008 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 2004-2008 Xilinx, Inc.
-- All rights reserved.

--------------------------------------------------------------------------------
-- Description:  This wrapper file instantiates the full Virtex-5 Ethernet 
--               MAC (EMAC) primitive.  For one or both of the two Ethernet MACs
--               (EMAC0/EMAC1):
--
--               * all unused input ports on the primitive will be tied to the
--                 appropriate logic level;
--
--               * all unused output ports on the primitive will be left 
--                 unconnected;
--
--               * the Tie-off Vector will be connected based on the options 
--                 selected from CORE Generator;
--
--               * only used ports will be connected to the ports of this 
--                 wrapper file.
--
--               This simplified wrapper should therefore be used as the 
--               instantiation template for the EMAC in customer designs.
--------------------------------------------------------------------------------

library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------------------------------------
-- The entity declaration for the Virtex-5 Embedded Ethernet MAC wrapper.
--------------------------------------------------------------------------------

entity v5_emac_v1_5 is
    port(
        -- Client Receiver Interface - EMAC0
        EMAC0CLIENTRXCLIENTCLKOUT       : out std_logic;
        CLIENTEMAC0RXCLIENTCLKIN        : in  std_logic;
        EMAC0CLIENTRXD                  : out std_logic_vector(7 downto 0);
        EMAC0CLIENTRXDVLD               : out std_logic;
        EMAC0CLIENTRXDVLDMSW            : out std_logic;
        EMAC0CLIENTRXGOODFRAME          : out std_logic;
        EMAC0CLIENTRXBADFRAME           : out std_logic;
        EMAC0CLIENTRXFRAMEDROP          : out std_logic;
        EMAC0CLIENTRXSTATS              : out std_logic_vector(6 downto 0);
        EMAC0CLIENTRXSTATSVLD           : out std_logic;
        EMAC0CLIENTRXSTATSBYTEVLD       : out std_logic;

        -- Client Transmitter Interface - EMAC0
        EMAC0CLIENTTXCLIENTCLKOUT       : out std_logic;
        CLIENTEMAC0TXCLIENTCLKIN        : in  std_logic;
        CLIENTEMAC0TXD                  : in  std_logic_vector(7 downto 0);
        CLIENTEMAC0TXDVLD               : in  std_logic;
        CLIENTEMAC0TXDVLDMSW            : in  std_logic;
        EMAC0CLIENTTXACK                : out std_logic;
        CLIENTEMAC0TXFIRSTBYTE          : in  std_logic;
        CLIENTEMAC0TXUNDERRUN           : in  std_logic;
        EMAC0CLIENTTXCOLLISION          : out std_logic;
        EMAC0CLIENTTXRETRANSMIT         : out std_logic;
        CLIENTEMAC0TXIFGDELAY           : in  std_logic_vector(7 downto 0);
        EMAC0CLIENTTXSTATS              : out std_logic;
        EMAC0CLIENTTXSTATSVLD           : out std_logic;
        EMAC0CLIENTTXSTATSBYTEVLD       : out std_logic;

        -- MAC Control Interface - EMAC0
        CLIENTEMAC0PAUSEREQ             : in  std_logic;
        CLIENTEMAC0PAUSEVAL             : in  std_logic_vector(15 downto 0);

        -- Clock Signal - EMAC0
        GTX_CLK_0                       : in  std_logic;
        PHYEMAC0TXGMIIMIICLKIN          : in  std_logic;
        EMAC0PHYTXGMIIMIICLKOUT         : out std_logic;

        -- SGMII Interface - EMAC0
        RXDATA_0                        : in  std_logic_vector(7 downto 0);
        TXDATA_0                        : out std_logic_vector(7 downto 0);
        DCM_LOCKED_0                    : in  std_logic;
        AN_INTERRUPT_0                  : out std_logic;
        SIGNAL_DETECT_0                 : in  std_logic;
        PHYAD_0                         : in  std_logic_vector(4 downto 0);
        ENCOMMAALIGN_0                  : out std_logic;
        LOOPBACKMSB_0                   : out std_logic;
        MGTRXRESET_0                    : out std_logic;
        MGTTXRESET_0                    : out std_logic;
        POWERDOWN_0                     : out std_logic;
        SYNCACQSTATUS_0                 : out std_logic;
        RXCLKCORCNT_0                   : in  std_logic_vector(2 downto 0);
        RXBUFSTATUS_0                   : in  std_logic_vector(1 downto 0);
        RXCHARISCOMMA_0                 : in  std_logic;
        RXCHARISK_0                     : in  std_logic;
        RXDISPERR_0                     : in  std_logic;
        RXNOTINTABLE_0                  : in  std_logic;
        RXREALIGN_0                     : in  std_logic;
        RXRUNDISP_0                     : in  std_logic;
        TXBUFERR_0                      : in  std_logic;
        TXCHARDISPMODE_0                : out std_logic;
        TXCHARDISPVAL_0                 : out std_logic;
        TXCHARISK_0                     : out std_logic;
        TXRUNDISP_0                     : in  std_logic;






        -- Asynchronous Reset
        RESET                           : in  std_logic
        );
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of v5_emac_v1_5 : entity is "v5_emac_v1_5, Coregen 10.1i_ip3";

end v5_emac_v1_5;



architecture WRAPPER of v5_emac_v1_5 is

    ----------------------------------------------------------------------------
    -- Attribute declarations
    ----------------------------------------------------------------------------
    --------
    -- EMAC0
    --------
    -- Configure the PCS/PMA logic
    -- PCS/PMA Reset not asserted (normal operating mode)
    constant EMAC0_PHYRESET : boolean := FALSE;  
    -- PCS/PMA Auto-Negotiation Enable (not enabled)
    constant EMAC0_PHYINITAUTONEG_ENABLE : boolean := FALSE;  
    -- PCS/PMA Isolate (not enabled)
    constant EMAC0_PHYISOLATE : boolean := FALSE;  
    -- PCS/PMA Powerdown (not in power down: normal operating mode)
    constant EMAC0_PHYPOWERDOWN : boolean := FALSE;  
    -- PCS/PMA Loopback (not enabled)
    constant EMAC0_PHYLOOPBACKMSB : boolean := FALSE;  
    -- Do not allow over/underflow in the GTP during auto-negotiation
    constant EMAC0_CONFIGVEC_79 : boolean := TRUE; 
    -- GT loopback (not enabled)
    constant EMAC0_GTLOOPBACK : boolean := FALSE; 
    -- Do not allow TX without having established a valid link
    constant EMAC0_UNIDIRECTION_ENABLE : boolean := FALSE; 
    constant EMAC0_LINKTIMERVAL : bit_vector := x"032";

    -- Configure the MAC operating mode
    -- MDIO is enabled
    constant EMAC0_MDIO_ENABLE : boolean := TRUE;  
    -- Speed is defaulted to 1000Mb/s
    constant EMAC0_SPEED_LSB : boolean := FALSE;
    constant EMAC0_SPEED_MSB : boolean := TRUE; 
    constant EMAC0_USECLKEN : boolean := FALSE;
    constant EMAC0_BYTEPHY : boolean := FALSE;
   
    constant EMAC0_RGMII_ENABLE : boolean := FALSE;
    -- SGMII is used to connect to PHY
    constant EMAC0_SGMII_ENABLE : boolean := TRUE;  
    constant EMAC0_1000BASEX_ENABLE : boolean := FALSE;
    -- The Host I/F is not  in use
    constant EMAC0_HOST_ENABLE : boolean := FALSE;  
    -- 8-bit interface for Tx client
    constant EMAC0_TX16BITCLIENT_ENABLE : boolean := FALSE;
    -- 8-bit interface for Rx client  
    constant EMAC0_RX16BITCLIENT_ENABLE : boolean := FALSE;  
    -- The Address Filter (not enabled)
    constant EMAC0_ADDRFILTER_ENABLE : boolean := FALSE;  

    -- MAC configuration defaults
    -- Rx Length/Type checking enabled (standard IEEE operation)
    constant EMAC0_LTCHECK_DISABLE : boolean := FALSE;  
    -- Rx Flow Control (enabled)
    constant EMAC0_RXFLOWCTRL_ENABLE : boolean := TRUE;  
    -- Tx Flow Control (enabled)
    constant EMAC0_TXFLOWCTRL_ENABLE : boolean := TRUE;  
    -- Transmitter is not held in reset not asserted (normal operating mode)
    constant EMAC0_TXRESET : boolean := FALSE;  
    -- Transmitter Jumbo Frames (not enabled)
    constant EMAC0_TXJUMBOFRAME_ENABLE : boolean := FALSE;  
    -- Transmitter In-band FCS (not enabled)
    constant EMAC0_TXINBANDFCS_ENABLE : boolean := FALSE;  
    -- Transmitter Enabled
    constant EMAC0_TX_ENABLE : boolean := TRUE;  
    -- Transmitter VLAN mode (not enabled)
    constant EMAC0_TXVLAN_ENABLE : boolean := FALSE;  
    -- Transmitter Half Duplex mode (not enabled)
    constant EMAC0_TXHALFDUPLEX : boolean := FALSE;  
    -- Transmitter IFG Adjust (not enabled)
    constant EMAC0_TXIFGADJUST_ENABLE : boolean := FALSE;  
    -- Receiver is not held in reset not asserted (normal operating mode)
    constant EMAC0_RXRESET : boolean := FALSE;  
    -- Receiver Jumbo Frames (not enabled)
    constant EMAC0_RXJUMBOFRAME_ENABLE : boolean := FALSE;  
    -- Receiver In-band FCS (not enabled)
    constant EMAC0_RXINBANDFCS_ENABLE : boolean := FALSE;  
    -- Receiver Enabled
    constant EMAC0_RX_ENABLE : boolean := TRUE;  
    -- Receiver VLAN mode (not enabled)
    constant EMAC0_RXVLAN_ENABLE : boolean := FALSE;  
    -- Receiver Half Duplex mode (not enabled)
    constant EMAC0_RXHALFDUPLEX : boolean := FALSE;  

    -- Set the Pause Address Default
    constant EMAC0_PAUSEADDR : bit_vector := x"FFEEDDCCBBAA";

    constant EMAC0_UNICASTADDR : bit_vector := x"000000000000";
 
    constant EMAC0_DCRBASEADDR : bit_vector := X"00";
 

    ----------------------------------------------------------------------------
    -- Signals Declarations
    ----------------------------------------------------------------------------


    signal gnd_v48_i                      : std_logic_vector(47 downto 0);

    signal client_rx_data_0_i             : std_logic_vector(15 downto 0);
    signal client_tx_data_0_i             : std_logic_vector(15 downto 0);
    signal client_tx_data_valid_0_i       : std_logic;
    signal client_tx_data_valid_msb_0_i   : std_logic;


begin


    ----------------------------------------------------------------------------
    -- Main Body of Code
    ----------------------------------------------------------------------------


    gnd_v48_i <= "000000000000000000000000000000000000000000000000";

    -- 8-bit client data on EMAC0
    EMAC0CLIENTRXD <= client_rx_data_0_i(7 downto 0);
    client_tx_data_0_i <= "00000000" & CLIENTEMAC0TXD after 4 ns;
    client_tx_data_valid_0_i <= CLIENTEMAC0TXDVLD after 4 ns;
    client_tx_data_valid_msb_0_i <= '0';






    ----------------------------------------------------------------------------
    -- Instantiate the Virtex-5 Embedded Ethernet EMAC
    ----------------------------------------------------------------------------
    v5_emac : TEMAC
    generic map (
		EMAC0_1000BASEX_ENABLE      => EMAC0_1000BASEX_ENABLE,
		EMAC0_ADDRFILTER_ENABLE     => EMAC0_ADDRFILTER_ENABLE,
		EMAC0_BYTEPHY               => EMAC0_BYTEPHY,
		EMAC0_CONFIGVEC_79          => EMAC0_CONFIGVEC_79,
		EMAC0_DCRBASEADDR           => EMAC0_DCRBASEADDR,
		EMAC0_GTLOOPBACK            => EMAC0_GTLOOPBACK,
		EMAC0_HOST_ENABLE           => EMAC0_HOST_ENABLE,
		EMAC0_LINKTIMERVAL          => EMAC0_LINKTIMERVAL(3 to 11),
		EMAC0_LTCHECK_DISABLE       => EMAC0_LTCHECK_DISABLE,
		EMAC0_MDIO_ENABLE           => EMAC0_MDIO_ENABLE,
		EMAC0_PAUSEADDR             => EMAC0_PAUSEADDR,
		EMAC0_PHYINITAUTONEG_ENABLE => EMAC0_PHYINITAUTONEG_ENABLE,
		EMAC0_PHYISOLATE            => EMAC0_PHYISOLATE,
		EMAC0_PHYLOOPBACKMSB        => EMAC0_PHYLOOPBACKMSB,
		EMAC0_PHYPOWERDOWN          => EMAC0_PHYPOWERDOWN,
		EMAC0_PHYRESET              => EMAC0_PHYRESET,
		EMAC0_RGMII_ENABLE          => EMAC0_RGMII_ENABLE,
		EMAC0_RX16BITCLIENT_ENABLE  => EMAC0_RX16BITCLIENT_ENABLE,
		EMAC0_RXFLOWCTRL_ENABLE     => EMAC0_RXFLOWCTRL_ENABLE,
		EMAC0_RXHALFDUPLEX          => EMAC0_RXHALFDUPLEX,
		EMAC0_RXINBANDFCS_ENABLE    => EMAC0_RXINBANDFCS_ENABLE,
		EMAC0_RXJUMBOFRAME_ENABLE   => EMAC0_RXJUMBOFRAME_ENABLE,
		EMAC0_RXRESET               => EMAC0_RXRESET,
		EMAC0_RXVLAN_ENABLE         => EMAC0_RXVLAN_ENABLE,
		EMAC0_RX_ENABLE             => EMAC0_RX_ENABLE,
		EMAC0_SGMII_ENABLE          => EMAC0_SGMII_ENABLE,
		EMAC0_SPEED_LSB             => EMAC0_SPEED_LSB,
		EMAC0_SPEED_MSB             => EMAC0_SPEED_MSB,
		EMAC0_TX16BITCLIENT_ENABLE  => EMAC0_TX16BITCLIENT_ENABLE,
		EMAC0_TXFLOWCTRL_ENABLE     => EMAC0_TXFLOWCTRL_ENABLE,
		EMAC0_TXHALFDUPLEX          => EMAC0_TXHALFDUPLEX,
		EMAC0_TXIFGADJUST_ENABLE    => EMAC0_TXIFGADJUST_ENABLE,
		EMAC0_TXINBANDFCS_ENABLE    => EMAC0_TXINBANDFCS_ENABLE,
		EMAC0_TXJUMBOFRAME_ENABLE   => EMAC0_TXJUMBOFRAME_ENABLE,
		EMAC0_TXRESET               => EMAC0_TXRESET,
		EMAC0_TXVLAN_ENABLE         => EMAC0_TXVLAN_ENABLE,
		EMAC0_TX_ENABLE             => EMAC0_TX_ENABLE,
		EMAC0_UNICASTADDR           => EMAC0_UNICASTADDR,
		EMAC0_UNIDIRECTION_ENABLE   => EMAC0_UNIDIRECTION_ENABLE,
		EMAC0_USECLKEN              => EMAC0_USECLKEN,
                EMAC1_LINKTIMERVAL          => "000000000"
)
    port map (
        RESET                           => RESET,

        -- EMAC0
        EMAC0CLIENTRXCLIENTCLKOUT       => EMAC0CLIENTRXCLIENTCLKOUT,
        CLIENTEMAC0RXCLIENTCLKIN        => CLIENTEMAC0RXCLIENTCLKIN,
        EMAC0CLIENTRXD                  => client_rx_data_0_i,
        EMAC0CLIENTRXDVLD               => EMAC0CLIENTRXDVLD,
        EMAC0CLIENTRXDVLDMSW            => EMAC0CLIENTRXDVLDMSW,
        EMAC0CLIENTRXGOODFRAME          => EMAC0CLIENTRXGOODFRAME,
        EMAC0CLIENTRXBADFRAME           => EMAC0CLIENTRXBADFRAME,
        EMAC0CLIENTRXFRAMEDROP          => EMAC0CLIENTRXFRAMEDROP,
        EMAC0CLIENTRXSTATS              => EMAC0CLIENTRXSTATS,
        EMAC0CLIENTRXSTATSVLD           => EMAC0CLIENTRXSTATSVLD,
        EMAC0CLIENTRXSTATSBYTEVLD       => EMAC0CLIENTRXSTATSBYTEVLD,

        EMAC0CLIENTTXCLIENTCLKOUT       => EMAC0CLIENTTXCLIENTCLKOUT,
        CLIENTEMAC0TXCLIENTCLKIN        => CLIENTEMAC0TXCLIENTCLKIN,
        CLIENTEMAC0TXD                  => client_tx_data_0_i,
        CLIENTEMAC0TXDVLD               => client_tx_data_valid_0_i,
        CLIENTEMAC0TXDVLDMSW            => client_tx_data_valid_msb_0_i,
        EMAC0CLIENTTXACK                => EMAC0CLIENTTXACK,
        CLIENTEMAC0TXFIRSTBYTE          => CLIENTEMAC0TXFIRSTBYTE,
        CLIENTEMAC0TXUNDERRUN           => CLIENTEMAC0TXUNDERRUN,
        EMAC0CLIENTTXCOLLISION          => EMAC0CLIENTTXCOLLISION,
        EMAC0CLIENTTXRETRANSMIT         => EMAC0CLIENTTXRETRANSMIT,
        CLIENTEMAC0TXIFGDELAY           => CLIENTEMAC0TXIFGDELAY,
        EMAC0CLIENTTXSTATS              => EMAC0CLIENTTXSTATS,
        EMAC0CLIENTTXSTATSVLD           => EMAC0CLIENTTXSTATSVLD,
        EMAC0CLIENTTXSTATSBYTEVLD       => EMAC0CLIENTTXSTATSBYTEVLD,

        CLIENTEMAC0PAUSEREQ             => CLIENTEMAC0PAUSEREQ,
        CLIENTEMAC0PAUSEVAL             => CLIENTEMAC0PAUSEVAL,

        PHYEMAC0GTXCLK                  => GTX_CLK_0,
        PHYEMAC0TXGMIIMIICLKIN          => PHYEMAC0TXGMIIMIICLKIN,
        EMAC0PHYTXGMIIMIICLKOUT         => EMAC0PHYTXGMIIMIICLKOUT,
        PHYEMAC0RXCLK                   => '0',
        PHYEMAC0MIITXCLK                => '0',
        PHYEMAC0RXD                     => RXDATA_0,
        PHYEMAC0RXDV                    => RXREALIGN_0,
        PHYEMAC0RXER                    => '0',
        EMAC0PHYTXCLK                   => open,
        EMAC0PHYTXD                     => TXDATA_0,
        EMAC0PHYTXEN                    => open,
        EMAC0PHYTXER                    => open,
        PHYEMAC0COL                     => TXRUNDISP_0,
        PHYEMAC0CRS                     => '0',
        CLIENTEMAC0DCMLOCKED            => DCM_LOCKED_0,
        EMAC0CLIENTANINTERRUPT          => AN_INTERRUPT_0,
        PHYEMAC0SIGNALDET               => SIGNAL_DETECT_0,
        PHYEMAC0PHYAD                   => PHYAD_0,
        EMAC0PHYENCOMMAALIGN            => ENCOMMAALIGN_0,
        EMAC0PHYLOOPBACKMSB             => LOOPBACKMSB_0,
        EMAC0PHYMGTRXRESET              => MGTRXRESET_0,
        EMAC0PHYMGTTXRESET              => MGTTXRESET_0,
        EMAC0PHYPOWERDOWN               => POWERDOWN_0,
        EMAC0PHYSYNCACQSTATUS           => SYNCACQSTATUS_0,
        PHYEMAC0RXCLKCORCNT             => RXCLKCORCNT_0,
        PHYEMAC0RXBUFSTATUS             => RXBUFSTATUS_0,
        PHYEMAC0RXBUFERR                => '0',
        PHYEMAC0RXCHARISCOMMA           => RXCHARISCOMMA_0,
        PHYEMAC0RXCHARISK               => RXCHARISK_0,
        PHYEMAC0RXCHECKINGCRC           => '0',
        PHYEMAC0RXCOMMADET              => '0',
        PHYEMAC0RXDISPERR               => RXDISPERR_0,
        PHYEMAC0RXLOSSOFSYNC            => gnd_v48_i(1 downto 0),
        PHYEMAC0RXNOTINTABLE            => RXNOTINTABLE_0,
        PHYEMAC0RXRUNDISP               => RXRUNDISP_0,
        PHYEMAC0TXBUFERR                => TXBUFERR_0,
        EMAC0PHYTXCHARDISPMODE          => TXCHARDISPMODE_0,
        EMAC0PHYTXCHARDISPVAL           => TXCHARDISPVAL_0,
        EMAC0PHYTXCHARISK               => TXCHARISK_0,

        EMAC0PHYMCLKOUT                 => open,
        PHYEMAC0MCLKIN                  => '0',
        PHYEMAC0MDIN                    => '1',
        EMAC0PHYMDOUT                   => open,
        EMAC0PHYMDTRI                   => open,
        EMAC0SPEEDIS10100               => open,

        -- EMAC1
        EMAC1CLIENTRXCLIENTCLKOUT       => open,
        CLIENTEMAC1RXCLIENTCLKIN        => '0',
        EMAC1CLIENTRXD                  => open,
        EMAC1CLIENTRXDVLD               => open,
        EMAC1CLIENTRXDVLDMSW            => open,
        EMAC1CLIENTRXGOODFRAME          => open,
        EMAC1CLIENTRXBADFRAME           => open,
        EMAC1CLIENTRXFRAMEDROP          => open,
        EMAC1CLIENTRXSTATS              => open,
        EMAC1CLIENTRXSTATSVLD           => open,
        EMAC1CLIENTRXSTATSBYTEVLD       => open,

        EMAC1CLIENTTXCLIENTCLKOUT       => open,
        CLIENTEMAC1TXCLIENTCLKIN        => '0',
        CLIENTEMAC1TXD                  => gnd_v48_i(15 downto 0),
        CLIENTEMAC1TXDVLD               => '0',
        CLIENTEMAC1TXDVLDMSW            => '0',
        EMAC1CLIENTTXACK                => open,
        CLIENTEMAC1TXFIRSTBYTE          => '0',
        CLIENTEMAC1TXUNDERRUN           => '0',
        EMAC1CLIENTTXCOLLISION          => open,
        EMAC1CLIENTTXRETRANSMIT         => open,
        CLIENTEMAC1TXIFGDELAY           => gnd_v48_i(7 downto 0),
        EMAC1CLIENTTXSTATS              => open,
        EMAC1CLIENTTXSTATSVLD           => open,
        EMAC1CLIENTTXSTATSBYTEVLD       => open,

        CLIENTEMAC1PAUSEREQ             => '0',
        CLIENTEMAC1PAUSEVAL             => gnd_v48_i(15 downto 0),

        PHYEMAC1GTXCLK                  => '0',
        PHYEMAC1TXGMIIMIICLKIN          => '0',
        EMAC1PHYTXGMIIMIICLKOUT         => open,

        PHYEMAC1RXCLK                   => '0',
        PHYEMAC1RXD                     => gnd_v48_i(7 downto 0),
        PHYEMAC1RXDV                    => '0',
        PHYEMAC1RXER                    => '0',
        PHYEMAC1MIITXCLK                => '0',
        EMAC1PHYTXCLK                   => open,
        EMAC1PHYTXD                     => open,
        EMAC1PHYTXEN                    => open,
        EMAC1PHYTXER                    => open,
        PHYEMAC1COL                     => '0',
        PHYEMAC1CRS                     => '0',

        CLIENTEMAC1DCMLOCKED            => '1',
        EMAC1CLIENTANINTERRUPT          => open,

        PHYEMAC1SIGNALDET               => '0',
        PHYEMAC1PHYAD                   => gnd_v48_i(4 downto 0),
        EMAC1PHYENCOMMAALIGN            => open,
        EMAC1PHYLOOPBACKMSB             => open,
        EMAC1PHYMGTRXRESET              => open,
        EMAC1PHYMGTTXRESET              => open,
        EMAC1PHYPOWERDOWN               => open,
        EMAC1PHYSYNCACQSTATUS           => open,
        PHYEMAC1RXCLKCORCNT             => gnd_v48_i(2 downto 0),
        PHYEMAC1RXBUFSTATUS             => gnd_v48_i(1 downto 0),
        PHYEMAC1RXBUFERR                => '0',
        PHYEMAC1RXCHARISCOMMA           => '0',
        PHYEMAC1RXCHARISK               => '0',
        PHYEMAC1RXCHECKINGCRC           => '0',
        PHYEMAC1RXCOMMADET              => '0',
        PHYEMAC1RXDISPERR               => '0',
        PHYEMAC1RXLOSSOFSYNC            => gnd_v48_i(1 downto 0),
        PHYEMAC1RXNOTINTABLE            => '0',
        PHYEMAC1RXRUNDISP               => '0',
        PHYEMAC1TXBUFERR                => '0',
        EMAC1PHYTXCHARDISPMODE          => open,
        EMAC1PHYTXCHARDISPVAL           => open,
        EMAC1PHYTXCHARISK               => open,

        EMAC1PHYMCLKOUT                 => open,
        PHYEMAC1MCLKIN                  => '0',
        PHYEMAC1MDIN                    => '0',
        EMAC1PHYMDOUT                   => open,
        EMAC1PHYMDTRI                   => open,

        EMAC1SPEEDIS10100               => open,

        -- Host Interface 
        HOSTCLK                         => '0',
 
        HOSTOPCODE                      => gnd_v48_i(1 downto 0),
        HOSTREQ                         => '0',
        HOSTMIIMSEL                     => '0',
        HOSTADDR                        => gnd_v48_i(9 downto 0),
        HOSTWRDATA                      => gnd_v48_i(31 downto 0), 
        HOSTMIIMRDY                     => open,
        HOSTRDDATA                      => open,
        HOSTEMAC1SEL                    => '0',

        -- DCR Interface
        DCREMACCLK                      => '0',
        DCREMACABUS                     => gnd_v48_i(9 downto 0),
        DCREMACREAD                     => '0',
        DCREMACWRITE                    => '0',
        DCREMACDBUS                     => gnd_v48_i(31 downto 0),
        EMACDCRACK                      => open,
        EMACDCRDBUS                     => open,
        DCREMACENABLE                   => '0',
        DCRHOSTDONEIR                   => open
        );

end WRAPPER;
