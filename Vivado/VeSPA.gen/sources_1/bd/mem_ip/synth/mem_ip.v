//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
//Date        : Mon Dec 11 10:14:09 2023
//Host        : FranciscoLenovo running 64-bit Ubuntu 22.04.3 LTS
//Command     : generate_target mem_ip.bd
//Design      : mem_ip
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "mem_ip,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=mem_ip,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "mem_ip.hwdef" *) 
module mem_ip
   (i_AddrA,
    i_AddrB,
    i_Clk,
    i_DInA,
    i_DInB,
    i_EnA,
    i_EnB,
    i_Rst,
    i_WEnA,
    i_WEnB,
    o_DOutA,
    o_DOutB,
    o_RstABusy,
    o_RstBBusy);
  input [12:0]i_AddrA;
  input [12:0]i_AddrB;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.I_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.I_CLK, CLK_DOMAIN mem_ip_i_Clk, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input i_Clk;
  input [31:0]i_DInA;
  input [31:0]i_DInB;
  input i_EnA;
  input i_EnB;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.I_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.I_RST, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input i_Rst;
  input [3:0]i_WEnA;
  input [3:0]i_WEnB;
  output [31:0]o_DOutA;
  output [31:0]o_DOutB;
  output o_RstABusy;
  output o_RstBBusy;

  wire [31:0]blk_mem_gen_0_douta;
  wire [31:0]blk_mem_gen_0_doutb;
  wire blk_mem_gen_0_rsta_busy;
  wire blk_mem_gen_0_rstb_busy;
  wire [12:0]i_AddrA_1;
  wire [12:0]i_AddrB_1;
  wire i_Clk_1;
  wire [31:0]i_DInA_1;
  wire [31:0]i_DInB_1;
  wire i_EnA_1;
  wire i_EnB_1;
  wire i_Rst_1;
  wire [3:0]i_WEnA_1;
  wire [3:0]i_WEnB_1;

  assign i_AddrA_1 = i_AddrA[12:0];
  assign i_AddrB_1 = i_AddrB[12:0];
  assign i_Clk_1 = i_Clk;
  assign i_DInA_1 = i_DInA[31:0];
  assign i_DInB_1 = i_DInB[31:0];
  assign i_EnA_1 = i_EnA;
  assign i_EnB_1 = i_EnB;
  assign i_Rst_1 = i_Rst;
  assign i_WEnA_1 = i_WEnA[3:0];
  assign i_WEnB_1 = i_WEnB[3:0];
  assign o_DOutA[31:0] = blk_mem_gen_0_douta;
  assign o_DOutB[31:0] = blk_mem_gen_0_doutb;
  assign o_RstABusy = blk_mem_gen_0_rsta_busy;
  assign o_RstBBusy = blk_mem_gen_0_rstb_busy;
  mem_ip_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(i_AddrA_1),
        .addrb(i_AddrB_1),
        .clka(i_Clk_1),
        .clkb(i_Clk_1),
        .dina(i_DInA_1),
        .dinb(i_DInB_1),
        .douta(blk_mem_gen_0_douta),
        .doutb(blk_mem_gen_0_doutb),
        .ena(i_EnA_1),
        .enb(i_EnB_1),
        .rsta(i_Rst_1),
        .rsta_busy(blk_mem_gen_0_rsta_busy),
        .rstb(i_Rst_1),
        .rstb_busy(blk_mem_gen_0_rstb_busy),
        .wea(i_WEnA_1),
        .web(i_WEnB_1));
endmodule
