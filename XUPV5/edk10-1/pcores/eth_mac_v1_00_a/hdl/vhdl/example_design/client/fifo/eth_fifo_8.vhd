-------------------------------------------------------------------------------
-- Title      : 10/100/1G Ethernet FIFO for 8-bit client I/F
-- Project    : Virtex-5 Ethernet MAC Wrappers
-------------------------------------------------------------------------------
-- File       : eth_fifo_8.vhd
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
-------------------------------------------------------------------------------
-- Description: This is the top level wrapper for the 10/100/1G Ethernet FIFO.
--              The top level wrapper consists of individual fifos on the 
--              transmitter path and on the receiver path.
--
--              Each path consists of an 8 bit local link to 8 bit client
--              interface FIFO.
-------------------------------------------------------------------------------


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity eth_fifo_8 is
   generic (
        FULL_DUPLEX_ONLY    : boolean := false);      -- If fifo is to be used only in full
                                             -- duplex set to true for optimised implementation

   port (
        -- Transmit FIFO MAC TX Interface
        tx_clk              : in  std_logic;  -- MAC transmit clock
        tx_reset            : in  std_logic;  -- Synchronous reset (tx_clk)
        tx_enable           : in  std_logic;  -- Clock enable for tx_clk
        tx_data             : out std_logic_vector(7 downto 0);  -- Data to MAC transmitter
        tx_data_valid       : out std_logic;  -- Valid signal to MAC transmitter
        tx_ack              : in  std_logic;  -- Ack signal from MAC transmitter
        tx_underrun         : out std_logic;  -- Underrun signal to MAC transmitter
        tx_collision        : in  std_logic;  -- Collsion signal from MAC transmitter
        tx_retransmit       : in  std_logic;  -- Retransmit signal from MAC transmitter
        
        -- Transmit FIFO Local-link Interface
        tx_ll_clock         : in  std_logic;  -- Local link write clock
        tx_ll_reset         : in  std_logic;  -- synchronous reset (tx_ll_clock)
        tx_ll_data_in       : in  std_logic_vector(7 downto 0);  -- Data to Tx FIFO
        tx_ll_sof_in_n      : in  std_logic;  -- sof indicator to FIFO
        tx_ll_eof_in_n      : in  std_logic;  -- eof indicator to FIFO
        tx_ll_src_rdy_in_n  : in  std_logic;  -- src ready indicator to FIFO
        tx_ll_dst_rdy_out_n : out std_logic;  -- dst ready indicator from FIFO
        tx_fifo_status      : out std_logic_vector(3 downto 0);  -- FIFO memory status
        tx_overflow         : out std_logic;  -- FIFO overflow indicator from FIFO
        
        -- Receive FIFO MAC RX Interface
        rx_clk              : in  std_logic;  -- MAC receive clock 
        rx_reset            : in  std_logic;  -- Synchronous reset (rx_clk)
        rx_enable           : in  std_logic;  -- Clock enable for rx_clk
        rx_data             : in  std_logic_vector(7 downto 0);  -- Data from MAC receiver
        rx_data_valid       : in  std_logic;  -- Valid signal from MAC receiver
        rx_good_frame       : in  std_logic;  -- Good frame indicator from MAC receiver
        rx_bad_frame        : in  std_logic;  -- Bad frame indicator from MAC receiver
        rx_overflow         : out std_logic;  -- FIFO overflow indicator from FIFO
     
        -- Receive FIFO Local-link Interface
        rx_ll_clock         : in  std_logic;  -- Local link read clock
        rx_ll_reset         : in  std_logic;  -- synchronous reset (rx_ll_clock)
        rx_ll_data_out      : out std_logic_vector(7 downto 0);  -- Data from Rx FIFO
        rx_ll_sof_out_n     : out std_logic;  -- sof indicator from FIFO
        rx_ll_eof_out_n     : out std_logic;  -- eof indicator from FIFO
        rx_ll_src_rdy_out_n : out std_logic;  -- src ready indicator from FIFO
        rx_ll_dst_rdy_in_n  : in  std_logic;  -- dst ready indicator to FIFO
        rx_fifo_status      : out std_logic_vector(3 downto 0)  -- FIFO memory status
        );
   
end eth_fifo_8;


architecture RTL of eth_fifo_8 is

   component tx_client_fifo_8
     generic (
        FULL_DUPLEX_ONLY : boolean);
     port (
        -- MAC Interface
        rd_clk          : in  std_logic;  
        rd_sreset       : in  std_logic;
        rd_enable       : in  std_logic;
        tx_data         : out std_logic_vector(7 downto 0);
        tx_data_valid   : out std_logic;
        tx_ack          : in  std_logic;
        tx_collision    : in  std_logic;
        tx_retransmit   : in  std_logic;
        overflow        : out std_logic;
        -- Local-link Interface
        wr_clk          : in  std_logic;
        wr_sreset       : in  std_logic;  -- synchronous reset (write_clock)
        wr_data         : in  std_logic_vector(7 downto 0);
        wr_sof_n        : in  std_logic;
        wr_eof_n        : in  std_logic;
        wr_src_rdy_n    : in  std_logic;
        wr_dst_rdy_n    : out std_logic;
        wr_fifo_status  : out std_logic_vector(3 downto 0)

        );
   end component tx_client_fifo_8;

   component rx_client_fifo_8
     port (
        -- Local-link Interface
        rd_clk          : in  std_logic;
        rd_sreset       : in  std_logic;
        rd_data_out     : out std_logic_vector(7 downto 0);
        rd_sof_n        : out std_logic;
        rd_eof_n        : out std_logic;
        rd_src_rdy_n    : out std_logic;
        rd_dst_rdy_n    : in  std_logic;
        rx_fifo_status  : out std_logic_vector(3 downto 0);
         -- Client Interface
        wr_sreset       : in  std_logic;
        wr_clk          : in  std_logic;
        wr_enable       : in  std_logic;
        rx_data         : in  std_logic_vector(7 downto 0);
        rx_data_valid   : in  std_logic;
        rx_good_frame   : in  std_logic;
        rx_bad_frame    : in  std_logic;
        overflow        : out std_logic
        );
   end component rx_client_fifo_8;

   
begin 

   tx_underrun <= '0';
   
   -- Transmitter FIFO
   tx_fifo_i : tx_client_fifo_8
      generic map (
         FULL_DUPLEX_ONLY => FULL_DUPLEX_ONLY)
       port map (
        rd_clk           => tx_clk,
        rd_sreset        => tx_reset,
        rd_enable        => tx_enable,
        tx_data          => tx_data,
        tx_data_valid    => tx_data_valid,
        tx_ack           => tx_ack,
        tx_collision     => tx_collision,
        tx_retransmit    => tx_retransmit,
        overflow         => tx_overflow,
        wr_clk           => tx_ll_clock,
        wr_sreset        => tx_ll_reset,
        wr_data          => tx_ll_data_in,
        wr_sof_n         => tx_ll_sof_in_n,
        wr_eof_n         => tx_ll_eof_in_n,
        wr_src_rdy_n     => tx_ll_src_rdy_in_n,
        wr_dst_rdy_n     => tx_ll_dst_rdy_out_n,
        wr_fifo_status   => tx_fifo_status
        );
  

   -- Receiver FIFO
   rx_fifo_i : rx_client_fifo_8
      port map (
        wr_clk          => rx_clk,
        wr_enable       => rx_enable,
        wr_sreset       => rx_reset,
        rx_data         => rx_data,
        rx_data_valid   => rx_data_valid,
        rx_good_frame   => rx_good_frame,
        rx_bad_frame    => rx_bad_frame,
        overflow        => rx_overflow,
        rd_clk          => rx_ll_clock,
        rd_sreset       => rx_ll_reset,
        rd_data_out     => rx_ll_data_out,
        rd_sof_n        => rx_ll_sof_out_n,
        rd_eof_n        => rx_ll_eof_out_n,
        rd_src_rdy_n    => rx_ll_src_rdy_out_n,
        rd_dst_rdy_n    => rx_ll_dst_rdy_in_n,
        rx_fifo_status  => rx_fifo_status
        );

end RTL;
