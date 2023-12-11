//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
//Date        : Mon Dec 11 10:14:09 2023
//Host        : FranciscoLenovo running 64-bit Ubuntu 22.04.3 LTS
//Command     : generate_target mem_ip_wrapper.bd
//Design      : mem_ip_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mem_ip_wrapper
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
  input i_Clk;
  input [31:0]i_DInA;
  input [31:0]i_DInB;
  input i_EnA;
  input i_EnB;
  input i_Rst;
  input [3:0]i_WEnA;
  input [3:0]i_WEnB;
  output [31:0]o_DOutA;
  output [31:0]o_DOutB;
  output o_RstABusy;
  output o_RstBBusy;

  wire [12:0]i_AddrA;
  wire [12:0]i_AddrB;
  wire i_Clk;
  wire [31:0]i_DInA;
  wire [31:0]i_DInB;
  wire i_EnA;
  wire i_EnB;
  wire i_Rst;
  wire [3:0]i_WEnA;
  wire [3:0]i_WEnB;
  wire [31:0]o_DOutA;
  wire [31:0]o_DOutB;
  wire o_RstABusy;
  wire o_RstBBusy;

  mem_ip mem_ip_i
       (.i_AddrA(i_AddrA),
        .i_AddrB(i_AddrB),
        .i_Clk(i_Clk),
        .i_DInA(i_DInA),
        .i_DInB(i_DInB),
        .i_EnA(i_EnA),
        .i_EnB(i_EnB),
        .i_Rst(i_Rst),
        .i_WEnA(i_WEnA),
        .i_WEnB(i_WEnB),
        .o_DOutA(o_DOutA),
        .o_DOutB(o_DOutB),
        .o_RstABusy(o_RstABusy),
        .o_RstBBusy(o_RstBBusy));
endmodule
