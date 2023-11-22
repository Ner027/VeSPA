`timescale 1ns / 1ps

module top_level(
    input i_Rst,
    input i_Clk,
    output [3:0] o_Output
 );

/***********************************************************************************************************************
* Internal Variables
**********************************************************************************************************************/
wire _PCLoad, _IRLoad, _RnW, _RfW, _EnB, _OpSel, _SelBit, _IntPendning, _CCLoad;
wire [1:0] _PCSel, _RFSel, _MSel;
wire [2:0] _Operation;
wire [3:0] _DLen, _Cond, _CCodes;
wire [4:0] _OpCode;
wire [31:0] _IntJumpTo;

assign o_Output = _OpCode;

 datapath _Datapath(
     .i_Rst(i_Rst),
     .i_Clk(i_Clk),
     .i_PCLoad(_PCLoad),
     .i_IRLoad(_IRLoad),
     .i_RnW(_RnW),
     .i_RfW(_RfW),
     .i_EnB(_EnB),
     .i_CCload(_CCLoad),
     .i_OpSel(_OpSel),
     .i_PCSel(_PCSel),
     .i_RFSel(_RFSel),
     .i_MSel(_MSel),
     .i_Operation(_Operation),
     .i_DLen(_DLen),
     .i_IntJmpTo(_IntJumpTo),
     .o_SelBit(_SelBit),
     .o_Cond(_Cond),
     .o_CCodes(_CCodes),
     .o_OpCode(_OpCode)
 );

 control_unit _ControlUnit(
    .i_Rst(i_Rst),
    .i_Clk(i_Clk),
    .i_SelBit(_SelBit),
    .i_Cond(_Cond),
    .i_CCodes(_CCodes),
    .i_OpCode(_OpCode),
    .i_IntPending(_IntPendning),
    .o_PCLoad(_PCLoad),
    .o_IRLoad(_IRLoad),
    .o_RnW(_RnW),
    .o_RfW(_RfW),
    .o_EnB(_EnB),
    .o_CCload(_CCLoad),
    .o_OpSel(_OpSel),
    .o_PcSel(_PCSel),
    .o_RfSel(_RFSel),
    .o_MSel(_MSel),
    .o_Operation(_Operation),
    .o_DLen(_DLen)
 );
endmodule
