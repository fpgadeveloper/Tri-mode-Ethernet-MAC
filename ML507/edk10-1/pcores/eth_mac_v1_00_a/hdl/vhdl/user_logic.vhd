------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2008 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              Thu Nov 27 10:26:16 2008 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v2_00_a;
use proc_common_v2_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--   C_NUM_REG                    -- Number of software accessible registers
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_SLV_DWIDTH                   : integer              := 32;
    C_NUM_REG                      : integer              := 1
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    REFCLK_N_IN              : in std_logic;
    REFCLK_P_IN              : in std_logic;
	 GTP_READY                : out std_logic;
	 PHY_RESET_0              : out std_logic;
    RXP_IN                   : in std_logic;
    RXN_IN                   : in std_logic;
    TXP_OUT                  : out std_logic;
    TXN_OUT                  : out std_logic;
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(0 to C_SLV_DWIDTH-1);
    Bus2IP_BE                      : in  std_logic_vector(0 to C_SLV_DWIDTH/8-1);
    Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    IP2Bus_Data                    : out std_logic_vector(0 to C_SLV_DWIDTH-1);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Reset  : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic
  -- Component Declaration for the TEMAC wrapper with 
  -- Local Link FIFO.
  component v5_emac_v1_5_locallink is
   port(
      -- EMAC0 Clocking
      -- 125MHz clock output from transceiver
      CLK125_OUT                       : out std_logic;
      -- 125MHz clock input from BUFG
      CLK125                           : in  std_logic;
      -- 62.5MHz clock input from BUFG
      CLK62_5                          : in  std_logic;
      -- Tri-speed clock output from EMAC0
      CLIENT_CLK_OUT_0                 : out std_logic;
      -- EMAC0 Tri-speed clock input from BUFG
      client_clk_0                     : in  std_logic;

      -- Local link Receiver Interface - EMAC0
      RX_LL_CLOCK_0                   : in  std_logic; 
      RX_LL_RESET_0                   : in  std_logic;
      RX_LL_DATA_0                    : out std_logic_vector(7 downto 0);
      RX_LL_SOF_N_0                   : out std_logic;
      RX_LL_EOF_N_0                   : out std_logic;
      RX_LL_SRC_RDY_N_0               : out std_logic;
      RX_LL_DST_RDY_N_0               : in  std_logic;
      RX_LL_FIFO_STATUS_0             : out std_logic_vector(3 downto 0);

      -- Local link Transmitter Interface - EMAC0
      TX_LL_CLOCK_0                   : in  std_logic;
      TX_LL_RESET_0                   : in  std_logic;
      TX_LL_DATA_0                    : in  std_logic_vector(7 downto 0);
      TX_LL_SOF_N_0                   : in  std_logic;
      TX_LL_EOF_N_0                   : in  std_logic;
      TX_LL_SRC_RDY_N_0               : in  std_logic;
      TX_LL_DST_RDY_N_0               : out std_logic;

      -- Client Receiver Interface - EMAC0
      EMAC0CLIENTRXDVLD               : out std_logic;
      EMAC0CLIENTRXFRAMEDROP          : out std_logic;
      EMAC0CLIENTRXSTATS              : out std_logic_vector(6 downto 0);
      EMAC0CLIENTRXSTATSVLD           : out std_logic;
      EMAC0CLIENTRXSTATSBYTEVLD       : out std_logic;

      -- Client Transmitter Interface - EMAC0
      CLIENTEMAC0TXIFGDELAY           : in  std_logic_vector(7 downto 0);
      EMAC0CLIENTTXSTATS              : out std_logic;
      EMAC0CLIENTTXSTATSVLD           : out std_logic;
      EMAC0CLIENTTXSTATSBYTEVLD       : out std_logic;

      -- MAC Control Interface - EMAC0
      CLIENTEMAC0PAUSEREQ             : in  std_logic;
      CLIENTEMAC0PAUSEVAL             : in  std_logic_vector(15 downto 0);

      --EMAC-MGT link status
      EMAC0CLIENTSYNCACQSTATUS        : out std_logic;
      -- EMAC0 Interrupt
      EMAC0ANINTERRUPT                : out std_logic;

 
      -- Clock Signals - EMAC0

      -- SGMII Interface - EMAC0
      TXP_0                           : out std_logic;
      TXN_0                           : out std_logic;
      RXP_0                           : in  std_logic;
      RXN_0                           : in  std_logic;
      PHYAD_0                         : in  std_logic_vector(4 downto 0);
      RESETDONE_0                     : out std_logic;

      -- unused transceiver
      TXN_1_UNUSED                    : out std_logic;
      TXP_1_UNUSED                    : out std_logic;
      RXN_1_UNUSED                    : in  std_logic;
      RXP_1_UNUSED                    : in  std_logic;

      -- SGMII RocketIO Reference Clock buffer inputs 
      CLK_DS                          : in  std_logic;
        
      -- Asynchronous Reset
      RESET                           : in  std_logic
   );
  end component;
 
   ---------------------------------------------------------------------
   --  Component Declaration for 8-bit address swapping module
   ---------------------------------------------------------------------
   component address_swap_module_8
   port (
      rx_ll_clock         : in  std_logic;                     -- Input CLK from MAC Reciever
      rx_ll_reset         : in  std_logic;                     -- Synchronous reset signal
      rx_ll_data_in       : in  std_logic_vector(7 downto 0);  -- Input data
      rx_ll_sof_in_n      : in  std_logic;                     -- Input start of frame
      rx_ll_eof_in_n      : in  std_logic;                     -- Input end of frame
      rx_ll_src_rdy_in_n  : in  std_logic;                     -- Input source ready
      rx_ll_data_out      : out std_logic_vector(7 downto 0);  -- Modified output data
      rx_ll_sof_out_n     : out std_logic;                     -- Output start of frame
      rx_ll_eof_out_n     : out std_logic;                     -- Output end of frame
      rx_ll_src_rdy_out_n : out std_logic;                     -- Output source ready
      rx_ll_dst_rdy_in_n  : in  std_logic                      -- Input destination ready
      );
   end component;

-----------------------------------------------------------------------
-- Signal Declarations
-----------------------------------------------------------------------

    -- address swap transmitter connections - EMAC0
    signal tx_ll_data_0_i      : std_logic_vector(7 downto 0);
    signal tx_ll_sof_n_0_i     : std_logic;
    signal tx_ll_eof_n_0_i     : std_logic;
    signal tx_ll_src_rdy_n_0_i : std_logic;
    signal tx_ll_dst_rdy_n_0_i : std_logic;

   -- address swap receiver connections - EMAC0
    signal rx_ll_data_0_i      : std_logic_vector(7 downto 0);
    signal rx_ll_sof_n_0_i     : std_logic;
    signal rx_ll_eof_n_0_i     : std_logic;
    signal rx_ll_src_rdy_n_0_i : std_logic;
    signal rx_ll_dst_rdy_n_0_i : std_logic;

    -- create a synchronous reset in the transmitter clock domain
    signal ll_pre_reset_0_i    : std_logic_vector(5 downto 0);
    signal ll_reset_0_i        : std_logic;

    attribute async_reg : string;
    attribute async_reg of ll_pre_reset_0_i : signal is "true";

    signal resetdone_0_i       : std_logic;


    -- EMAC0 Clocking signals

    -- Transceiver output clock (REFCLKOUT at 125MHz)
    signal user_clk_out              : std_logic;
    -- 125MHz clock input to wrappers
    signal user_clk                  : std_logic;
    signal clk62_5                   : std_logic;
    signal clk62_5_pre_bufg          : std_logic;
    signal clk125_fb                 : std_logic;
    -- Input 125MHz differential clock for transceiver
    signal ref_clk                   : std_logic;

    -- 1.25/12.5/125MHz clock signals for tri-speed SGMII
    signal client_clk_0_o            : std_logic;
    signal client_clk_0              : std_logic;


begin

  --USER logic implementation added here
  -- PHY Reset logic
  PHY_RESET_0 <= not Bus2IP_Reset;

  -- EMAC0 Clocking

  -- Generate the clock input to the GTP
  -- clk_ds can be shared between multiple MAC instances.
  clkingen : IBUFDS port map (
    I  => REFCLK_P_IN,
    IB => REFCLK_N_IN,
    O  => ref_clk);

  -- 125MHz from transceiver is routed through a BUFG and 
  -- input to the MAC wrappers.
  -- This clock can be shared between multiple MAC instances.
  bufg_clk125 : BUFG port map (I => clk125_fb, O => user_clk);
	
  -- Divide 125MHz reference clock down by 2 to get
  -- 62.5MHz clock for 2 byte GTX internal datapath.
  clk62_5_dcm : DCM_BASE 
  port map 
  (CLKIN      => user_clk_out,
   CLK0       => clk125_fb,
   CLK180     => open,
   CLK270     => open,
   CLK2X      => open,
   CLK2X180   => open,
   CLK90      => open,
   CLKDV      => clk62_5_pre_bufg,
   CLKFX      => open,
   CLKFX180   => open,
   LOCKED     => open,
   CLKFB      => user_clk,
   RST        => Bus2IP_Reset);

  clk62_5_bufg : BUFG port map(I => clk62_5_pre_bufg, O => clk62_5);


  -- 1.25/12.5/125MHz clock from the MAC is routed through a BUFG and  
  -- input to the MAC wrappers to clock the client interface.
  bufg_client_0 : BUFG port map (I => client_clk_0_o, O => client_clk_0);


  ------------------------------------------------------------------------
  -- Instantiate the EMAC Wrapper with LL FIFO 
  -- (v5_emac_v1_5_locallink.v)
  ------------------------------------------------------------------------
  v5_emac_ll : v5_emac_v1_5_locallink
  port map (
    -- EMAC0 Clocking
    -- 125MHz clock output from transceiver
    CLK125_OUT                      => user_clk_out,
    -- 125MHz clock input from BUFG
    CLK125                          => user_clk,
    -- 62.5MHz clock input from BUFG
    CLK62_5                         => clk62_5,
    -- Tri-speed clock output from EMAC0
    CLIENT_CLK_OUT_0                => client_clk_0_o,
    -- EMAC0 Tri-speed clock input from BUFG
    CLIENT_CLK_0                    => client_clk_0,
    -- Local link Receiver Interface - EMAC0
    RX_LL_CLOCK_0                   => user_clk,
    RX_LL_RESET_0                   => ll_reset_0_i,
    RX_LL_DATA_0                    => rx_ll_data_0_i,
    RX_LL_SOF_N_0                   => rx_ll_sof_n_0_i,
    RX_LL_EOF_N_0                   => rx_ll_eof_n_0_i,
    RX_LL_SRC_RDY_N_0               => rx_ll_src_rdy_n_0_i,
    RX_LL_DST_RDY_N_0               => rx_ll_dst_rdy_n_0_i,
    RX_LL_FIFO_STATUS_0             => open,

    -- Unused Receiver signals - EMAC0
    EMAC0CLIENTRXDVLD               => open,
    EMAC0CLIENTRXFRAMEDROP          => open,
    EMAC0CLIENTRXSTATS              => open,
    EMAC0CLIENTRXSTATSVLD           => open,
    EMAC0CLIENTRXSTATSBYTEVLD       => open,

    -- Local link Transmitter Interface - EMAC0
    TX_LL_CLOCK_0                   => user_clk,
    TX_LL_RESET_0                   => ll_reset_0_i,
    TX_LL_DATA_0                    => tx_ll_data_0_i,
    TX_LL_SOF_N_0                   => tx_ll_sof_n_0_i,
    TX_LL_EOF_N_0                   => tx_ll_eof_n_0_i,
    TX_LL_SRC_RDY_N_0               => tx_ll_src_rdy_n_0_i,
    TX_LL_DST_RDY_N_0               => tx_ll_dst_rdy_n_0_i,

    -- Unused Transmitter signals - EMAC0
    CLIENTEMAC0TXIFGDELAY           => "00000000",
    EMAC0CLIENTTXSTATS              => open,
    EMAC0CLIENTTXSTATSVLD           => open,
    EMAC0CLIENTTXSTATSBYTEVLD       => open,

    -- MAC Control Interface - EMAC0
    CLIENTEMAC0PAUSEREQ             => '0',
    CLIENTEMAC0PAUSEVAL             => "0000000000000000",

    --EMAC-MGT link status
    EMAC0CLIENTSYNCACQSTATUS        => GTP_READY,
    -- EMAC0 Interrupt
    EMAC0ANINTERRUPT                => open,

 
    -- Clock Signals - EMAC0
    -- SGMII Interface - EMAC0
    TXP_0                           => TXP_OUT,
    TXN_0                           => TXN_OUT,
    RXP_0                           => RXP_IN,
    RXN_0                           => RXN_IN,
    PHYAD_0                         => "00010",
    RESETDONE_0                     => resetdone_0_i,

    -- unused transceiver
    TXN_1_UNUSED                    => open,
    TXP_1_UNUSED                    => open,
    RXN_1_UNUSED                    => '1',
    RXP_1_UNUSED                    => '0',

    -- SGMII RocketIO Reference Clock buffer inputs 
    CLK_DS                          => ref_clk,

    -- Asynchronous Reset
    RESET                           => Bus2IP_Reset
  );

  ---------------------------------------------------------------------
  --  Instatiate the address swapping module
  ---------------------------------------------------------------------
  client_side_asm_emac0 : address_swap_module_8
    port map (
      rx_ll_clock         => user_clk,
      rx_ll_reset         => ll_reset_0_i,
      rx_ll_data_in       => rx_ll_data_0_i,
      rx_ll_sof_in_n      => rx_ll_sof_n_0_i,
      rx_ll_eof_in_n      => rx_ll_eof_n_0_i,
      rx_ll_src_rdy_in_n  => rx_ll_src_rdy_n_0_i,
      rx_ll_data_out      => tx_ll_data_0_i,
      rx_ll_sof_out_n     => tx_ll_sof_n_0_i,
      rx_ll_eof_out_n     => tx_ll_eof_n_0_i,
      rx_ll_src_rdy_out_n => tx_ll_src_rdy_n_0_i,
      rx_ll_dst_rdy_in_n  => tx_ll_dst_rdy_n_0_i
  );

  rx_ll_dst_rdy_n_0_i     <= tx_ll_dst_rdy_n_0_i;


  -- Create synchronous reset in the transmitter clock domain.
  gen_ll_reset_emac0 : process (user_clk, Bus2IP_Reset)
  begin
    if Bus2IP_Reset = '1' then
      ll_pre_reset_0_i <= (others => '1');
      ll_reset_0_i     <= '1';
    elsif user_clk'event and user_clk = '1' then
    if resetdone_0_i = '1' then
      ll_pre_reset_0_i(0)          <= '0';
      ll_pre_reset_0_i(5 downto 1) <= ll_pre_reset_0_i(4 downto 0);
      ll_reset_0_i                 <= ll_pre_reset_0_i(5);
    end if;
    end if;
  end process gen_ll_reset_emac0;
 

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data  <= (others => '0');

  IP2Bus_WrAck <= '0';
  IP2Bus_RdAck <= '0';
  IP2Bus_Error <= '0';

end IMP;
