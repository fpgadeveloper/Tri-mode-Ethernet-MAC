-------------------------------------------------------------------------------
-- Title      : Virtex-5 Ethernet MAC Local Link Wrapper
-- Project    : Virtex-5 Ethernet MAC Wrappers
-------------------------------------------------------------------------------
-- File       : v5_emac_v1_5_locallink.vhd
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

-------------------------------------------------------------------------------
-- Description:  This level:
--
--               * instantiates the TEMAC top level file (the TEMAC
--                 wrapper with the clocking and physical interface
--				   logic;
--               
--               * instantiates TX and RX reference design FIFO's with 
--                 a local link interface.
--               
--               Please refer to the Datasheet, Getting Started Guide, and
--               the Virtex-5 Embedded Tri-Mode Ethernet MAC User Gude for
--               further information.
-------------------------------------------------------------------------------


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;


-------------------------------------------------------------------------------
-- The entity declaration for the local link design.
-------------------------------------------------------------------------------
entity v5_emac_v1_5_locallink is
   port(
      -- EMAC0 Clocking
      -- 125MHz clock output from transceiver
      CLK125_OUT                      : out std_logic;
      -- 125MHz clock input from BUFG
      CLK125                          : in  std_logic;
      -- Tri-speed clock output from EMAC0
      CLIENT_CLK_OUT_0                : out std_logic;
      -- EMAC0 Tri-speed clock input from BUFG
      CLIENT_CLK_0                    : in  std_logic;

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
end v5_emac_v1_5_locallink;


architecture TOP_LEVEL of v5_emac_v1_5_locallink is

-------------------------------------------------------------------------------
-- Component Declarations for lower hierarchial level entities
-------------------------------------------------------------------------------
  -- Component Declaration for the main EMAC wrapper
  component v5_emac_v1_5_block is
   port(
      -- EMAC0 Clocking
      -- 125MHz clock output from transceiver
      CLK125_OUT                      : out std_logic;
      -- 125MHz clock input from BUFG
      CLK125                          : in  std_logic;
      -- Tri-speed clock output from EMAC0
      CLIENT_CLK_OUT_0                : out std_logic;
      -- EMAC0 Tri-speed clock input from BUFG
      CLIENT_CLK_0                    : in  std_logic;

      -- Client Receiver Interface - EMAC0
      EMAC0CLIENTRXD                  : out std_logic_vector(7 downto 0);
      EMAC0CLIENTRXDVLD               : out std_logic;
      EMAC0CLIENTRXGOODFRAME          : out std_logic;
      EMAC0CLIENTRXBADFRAME           : out std_logic;
      EMAC0CLIENTRXFRAMEDROP          : out std_logic;
      EMAC0CLIENTRXSTATS              : out std_logic_vector(6 downto 0);
      EMAC0CLIENTRXSTATSVLD           : out std_logic;
      EMAC0CLIENTRXSTATSBYTEVLD       : out std_logic;

      -- Client Transmitter Interface - EMAC0
      CLIENTEMAC0TXD                  : in  std_logic_vector(7 downto 0);
      CLIENTEMAC0TXDVLD               : in  std_logic;
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
   -- Component Declaration for the 8-bit client side FIFO
   ---------------------------------------------------------------------
   component eth_fifo_8
   generic (
        FULL_DUPLEX_ONLY    : boolean);
   port (
        -- Transmit FIFO MAC TX Interface
        tx_clk              : in  std_logic;
        tx_reset            : in  std_logic;
        tx_enable           : in  std_logic;
        tx_data             : out std_logic_vector(7 downto 0);
        tx_data_valid       : out std_logic;
        tx_ack              : in  std_logic;
        tx_underrun         : out std_logic;
        tx_collision        : in  std_logic;
        tx_retransmit       : in  std_logic;

        -- Transmit FIFO Local-link Interface
        tx_ll_clock         : in  std_logic;
        tx_ll_reset         : in  std_logic;
        tx_ll_data_in       : in  std_logic_vector(7 downto 0);
        tx_ll_sof_in_n      : in  std_logic;
        tx_ll_eof_in_n      : in  std_logic;
        tx_ll_src_rdy_in_n  : in  std_logic;
        tx_ll_dst_rdy_out_n : out std_logic;
        tx_fifo_status      : out std_logic_vector(3 downto 0);
        tx_overflow         : out std_logic;

        -- Receive FIFO MAC RX Interface
        rx_clk              : in  std_logic;
        rx_reset            : in  std_logic;
        rx_enable           : in  std_logic;
        rx_data             : in  std_logic_vector(7 downto 0);
        rx_data_valid       : in  std_logic;
        rx_good_frame       : in  std_logic;
        rx_bad_frame        : in  std_logic;
        rx_overflow         : out std_logic;

        -- Receive FIFO Local-link Interface
        rx_ll_clock         : in  std_logic;
        rx_ll_reset         : in  std_logic;
        rx_ll_data_out      : out std_logic_vector(7 downto 0);
        rx_ll_sof_out_n     : out std_logic;
        rx_ll_eof_out_n     : out std_logic;
        rx_ll_src_rdy_out_n : out std_logic;
        rx_ll_dst_rdy_in_n  : in  std_logic;
        rx_fifo_status      : out std_logic_vector(3 downto 0)
        );
   end component;

-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------

    -- Global asynchronous reset
    signal reset_i               : std_logic;

    -- client interface clocking signals - EMAC0
    signal tx_clk_0_i            : std_logic;
    signal rx_clk_0_i            : std_logic;

    -- internal client interface connections - EMAC0
    -- transmitter interface
    signal tx_data_0_i           : std_logic_vector(7 downto 0);
    signal tx_data_valid_0_i     : std_logic;
    signal tx_underrun_0_i       : std_logic;
    signal tx_ack_0_i            : std_logic;
    signal tx_collision_0_i      : std_logic;
    signal tx_retransmit_0_i     : std_logic;
    -- receiver interface
    signal rx_data_0_i           : std_logic_vector(7 downto 0);
    signal rx_data_valid_0_i     : std_logic;
    signal rx_good_frame_0_i     : std_logic;
    signal rx_bad_frame_0_i      : std_logic;
    -- registers for the MAC receiver output
    signal rx_data_0_r           : std_logic_vector(7 downto 0);
    signal rx_data_valid_0_r     : std_logic;
    signal rx_good_frame_0_r     : std_logic;
    signal rx_bad_frame_0_r      : std_logic;

    -- create a synchronous reset in the transmitter clock domain
    signal tx_pre_reset_0_i      : std_logic_vector(5 downto 0);
    signal tx_reset_0_i          : std_logic;

    -- create a synchronous reset in the receiver clock domain
    signal rx_pre_reset_0_i      : std_logic_vector(5 downto 0);
    signal rx_reset_0_i          : std_logic;    

    attribute async_reg : string;
    attribute async_reg of rx_pre_reset_0_i : signal is "true";
    attribute async_reg of tx_pre_reset_0_i : signal is "true";

    signal resetdone_0_i         : std_logic;


    attribute keep : string;
    attribute keep of tx_data_0_i : signal is "true";
    attribute keep of tx_data_valid_0_i : signal is "true";
    attribute keep of tx_ack_0_i : signal is "true";
    attribute keep of rx_data_0_i : signal is "true";
    attribute keep of rx_data_valid_0_i : signal is "true";

-------------------------------------------------------------------------------
-- Main Body of Code
-------------------------------------------------------------------------------
begin

    ---------------------------------------------------------------------------
    -- Asynchronous Reset Input
    ---------------------------------------------------------------------------
    reset_i <= RESET;

    --------------------------------------------------------------------------
    -- Instantiate the EMAC Wrapper (v5_emac_v1_5_block.vhd)
    --------------------------------------------------------------------------
    v5_emac_block : v5_emac_v1_5_block
    port map (
          -- EMAC0 Clocking
      -- 125MHz clock output from transceiver
      CLK125_OUT                      => CLK125_OUT,
      -- 125MHz clock input from BUFG
      CLK125                          => CLK125,
      -- Tri-speed clock output from EMAC0
      CLIENT_CLK_OUT_0                => CLIENT_CLK_OUT_0,
      -- EMAC0 Tri-speed clock input from BUFG
      CLIENT_CLK_0                    => CLIENT_CLK_0,

      -- Client Receiver Interface - EMAC0
      EMAC0CLIENTRXD                  => rx_data_0_i,
      EMAC0CLIENTRXDVLD               => rx_data_valid_0_i,
      EMAC0CLIENTRXGOODFRAME          => rx_good_frame_0_i,
      EMAC0CLIENTRXBADFRAME           => rx_bad_frame_0_i,
      EMAC0CLIENTRXFRAMEDROP          => EMAC0CLIENTRXFRAMEDROP,
      EMAC0CLIENTRXSTATS              => EMAC0CLIENTRXSTATS,
      EMAC0CLIENTRXSTATSVLD           => EMAC0CLIENTRXSTATSVLD,
      EMAC0CLIENTRXSTATSBYTEVLD       => EMAC0CLIENTRXSTATSBYTEVLD,

      -- Client Transmitter Interface - EMAC0
      CLIENTEMAC0TXD                  => tx_data_0_i,
      CLIENTEMAC0TXDVLD               => tx_data_valid_0_i,
      EMAC0CLIENTTXACK                => tx_ack_0_i,
      CLIENTEMAC0TXFIRSTBYTE          => '0',
      CLIENTEMAC0TXUNDERRUN           => tx_underrun_0_i,
      EMAC0CLIENTTXCOLLISION          => tx_collision_0_i,
      EMAC0CLIENTTXRETRANSMIT         => tx_retransmit_0_i,
      CLIENTEMAC0TXIFGDELAY           => CLIENTEMAC0TXIFGDELAY,
      EMAC0CLIENTTXSTATS              => EMAC0CLIENTTXSTATS,
      EMAC0CLIENTTXSTATSVLD           => EMAC0CLIENTTXSTATSVLD,
      EMAC0CLIENTTXSTATSBYTEVLD       => EMAC0CLIENTTXSTATSBYTEVLD,

      -- MAC Control Interface - EMAC0
      CLIENTEMAC0PAUSEREQ             => CLIENTEMAC0PAUSEREQ,
      CLIENTEMAC0PAUSEVAL             => CLIENTEMAC0PAUSEVAL,

      --EMAC-MGT link status
      EMAC0CLIENTSYNCACQSTATUS        => EMAC0CLIENTSYNCACQSTATUS,
      -- EMAC0 Interrupt
      EMAC0ANINTERRUPT                => EMAC0ANINTERRUPT,

 
      -- Clock Signals - EMAC0
      -- SGMII Interface - EMAC0
      TXP_0                           => TXP_0,
      TXN_0                           => TXN_0,
      RXP_0                           => RXP_0,
      RXN_0                           => RXN_0,
      PHYAD_0                         => PHYAD_0,
      RESETDONE_0                     => resetdone_0_i,

      -- unused transceiver
      TXN_1_UNUSED                    => TXN_1_UNUSED,
      TXP_1_UNUSED                    => TXP_1_UNUSED,
      RXN_1_UNUSED                    => RXN_1_UNUSED,
      RXP_1_UNUSED                    => RXP_1_UNUSED,

      -- SGMII RocketIO Reference Clock buffer inputs 
      CLK_DS                          => CLK_DS,

        
        
      -- Asynchronous Reset
      RESET                           => reset_i
   );

   ----------------------------------------------------------------------
   -- Instantiate the client side FIFO for EMAC0
   ----------------------------------------------------------------------
   client_side_FIFO_emac0 : eth_fifo_8
     generic map (
       FULL_DUPLEX_ONLY     => false)
     port map (
       -- Transmitter MAC Client Interface
       tx_clk               => tx_clk_0_i,
       tx_reset             => tx_reset_0_i,
       tx_enable            => '1',
       tx_data              => tx_data_0_i,
       tx_data_valid        => tx_data_valid_0_i,
       tx_ack               => tx_ack_0_i,
       tx_underrun          => tx_underrun_0_i,
       tx_collision         => tx_collision_0_i,
       tx_retransmit        => tx_retransmit_0_i,

       -- Transmitter Local Link Interface
       tx_ll_clock          => TX_LL_CLOCK_0,
       tx_ll_reset          => TX_LL_RESET_0,
       tx_ll_data_in        => TX_LL_DATA_0,
       tx_ll_sof_in_n       => TX_LL_SOF_N_0,
       tx_ll_eof_in_n       => TX_LL_EOF_N_0,
       tx_ll_src_rdy_in_n   => TX_LL_SRC_RDY_N_0,
       tx_ll_dst_rdy_out_n  => TX_LL_DST_RDY_N_0,
       tx_fifo_status       => open,
       tx_overflow          => open,

       -- Receiver MAC Client Interface
       rx_clk               => rx_clk_0_i,
       rx_reset             => rx_reset_0_i,
       rx_enable            => '1',
       rx_data              => rx_data_0_r,
       rx_data_valid        => rx_data_valid_0_r,
       rx_good_frame        => rx_good_frame_0_r,
       rx_bad_frame         => rx_bad_frame_0_r,
       rx_overflow          => open,

       -- Receiver Local Link Interface
       rx_ll_clock          => RX_LL_CLOCK_0,
       rx_ll_reset          => RX_LL_RESET_0,
       rx_ll_data_out       => RX_LL_DATA_0,
       rx_ll_sof_out_n      => RX_LL_SOF_N_0,
       rx_ll_eof_out_n      => RX_LL_EOF_N_0,
       rx_ll_src_rdy_out_n  => RX_LL_SRC_RDY_N_0,
       rx_ll_dst_rdy_in_n   => RX_LL_DST_RDY_N_0,
       rx_fifo_status       => RX_LL_FIFO_STATUS_0
       );


   -- Create synchronous reset in the transmitter clock domain.
   gen_tx_reset_emac0 : process (tx_clk_0_i, reset_i)
   begin
     if reset_i = '1' then
       tx_pre_reset_0_i <= (others => '1');
       tx_reset_0_i     <= '1';
     elsif tx_clk_0_i'event and tx_clk_0_i = '1' then
       if resetdone_0_i = '1' then
         tx_pre_reset_0_i(0)          <= '0';
         tx_pre_reset_0_i(5 downto 1) <= tx_pre_reset_0_i(4 downto 0);
         tx_reset_0_i                 <= tx_pre_reset_0_i(5);
       end if;
     end if;
   end process gen_tx_reset_emac0;

   -- Create synchronous reset in the receiver clock domain.
   gen_rx_reset_emac0 : process (rx_clk_0_i, reset_i)
   begin
     if reset_i = '1' then
       rx_pre_reset_0_i <= (others => '1');
       rx_reset_0_i     <= '1';
     elsif rx_clk_0_i'event and rx_clk_0_i = '1' then
       if resetdone_0_i = '1' then
         rx_pre_reset_0_i(0)          <= '0';
         rx_pre_reset_0_i(5 downto 1) <= rx_pre_reset_0_i(4 downto 0);
         rx_reset_0_i                 <= rx_pre_reset_0_i(5);
       end if;
     end if;
   end process gen_rx_reset_emac0;


   ----------------------------------------------------------------------
   -- Register the receiver outputs from EMAC0 before routing 
   -- to the FIFO
   ----------------------------------------------------------------------
   regipgen_emac0 : process(rx_clk_0_i, reset_i)
   begin
     if reset_i = '1' then
       rx_data_0_r       <= (others => '0');
       rx_data_valid_0_r <= '0';
       rx_good_frame_0_r <= '0';
       rx_bad_frame_0_r  <= '0';
     elsif rx_clk_0_i'event and rx_clk_0_i = '1' then
       if resetdone_0_i = '1' then
         rx_data_0_r       <= rx_data_0_i;
         rx_data_valid_0_r <= rx_data_valid_0_i;
         rx_good_frame_0_r <= rx_good_frame_0_i;
         rx_bad_frame_0_r  <= rx_bad_frame_0_i;
       end if;
     end if;
   end process regipgen_emac0;
 
   EMAC0CLIENTRXDVLD <= rx_data_valid_0_i;

   -- EMAC0 Clocking
   tx_clk_0_i  <= CLIENT_CLK_0;
   rx_clk_0_i  <= CLIENT_CLK_0;
   RESETDONE_0 <= resetdone_0_i;
 
end TOP_LEVEL;
