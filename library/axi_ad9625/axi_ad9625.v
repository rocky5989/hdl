// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module axi_ad9625 #(

  parameter ID = 0,
  parameter FPGA_TECHNOLOGY = 0,
  parameter FPGA_FAMILY = 0,
  parameter SPEED_GRADE = 0,
  parameter DEV_PACKAGE = 0) (

  // jesd interface
  // rx_clk is (line-rate/40)

  input                   rx_clk,
  input       [  3:0]     rx_sof,
  input                   rx_valid,
  input       [255:0]     rx_data,
  output                  rx_ready,

  // dma interface

  output                  adc_clk,
  output                  adc_valid,
  output                  adc_enable,
  output      [255:0]     adc_data,
  input                   adc_dovf,

  // axi interface

  input                   s_axi_aclk,
  input                   s_axi_aresetn,
  input                   s_axi_awvalid,
  input       [ 15:0]     s_axi_awaddr,
  output                  s_axi_awready,
  input                   s_axi_wvalid,
  input       [ 31:0]     s_axi_wdata,
  input       [  3:0]     s_axi_wstrb,
  output                  s_axi_wready,
  output                  s_axi_bvalid,
  output      [  1:0]     s_axi_bresp,
  input                   s_axi_bready,
  input                   s_axi_arvalid,
  input       [ 15:0]     s_axi_araddr,
  output                  s_axi_arready,
  output                  s_axi_rvalid,
  output      [  1:0]     s_axi_rresp,
  output      [ 31:0]     s_axi_rdata,
  input                   s_axi_rready,
  input       [  2:0]     s_axi_awprot,
  input       [  2:0]     s_axi_arprot);

  assign adc_clk = rx_clk;

  ad_ip_jesd204_tpl_adc #(
     .ID (ID),
     .NUM_CHANNELS (1),
     .CHANNEL_WIDTH (12),
     .NUM_LANES (8),
     .TWOS_COMPLEMENT (1)
   ) i_adc_jesd204 (
     .link_clk (rx_clk),

     .link_sof (rx_sof),
     .link_valid (rx_valid),
     .link_data (rx_data),
     .link_ready (rx_ready),

     .enable (adc_enable),
     .adc_valid (adc_valid),
     .adc_data (adc_data),
     .adc_dovf (adc_dovf),

     .s_axi_aclk (s_axi_aclk),
     .s_axi_aresetn (s_axi_aresetn),
     .s_axi_awvalid (s_axi_awvalid),
     .s_axi_awready (s_axi_awready),
     .s_axi_awaddr (s_axi_awaddr),
     .s_axi_awprot (s_axi_awprot),
     .s_axi_wvalid (s_axi_wvalid),
     .s_axi_wready (s_axi_wready),
     .s_axi_wdata (s_axi_wdata),
     .s_axi_wstrb (s_axi_wstrb),
     .s_axi_bvalid (s_axi_bvalid),
     .s_axi_bready (s_axi_bready),
     .s_axi_bresp (s_axi_bresp),
     .s_axi_arvalid (s_axi_arvalid),
     .s_axi_arready (s_axi_arready),
     .s_axi_araddr (s_axi_araddr),
     .s_axi_arprot (s_axi_arprot),
     .s_axi_rvalid (s_axi_rvalid),
     .s_axi_rready (s_axi_rready),
     .s_axi_rresp (s_axi_rresp),
     .s_axi_rdata (s_axi_rdata)
  );
endmodule

// ***************************************************************************
// ***************************************************************************

