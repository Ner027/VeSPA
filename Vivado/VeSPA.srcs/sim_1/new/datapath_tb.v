`timescale 1ns / 1ps

module datapath_tb();

//Inputs
reg _Clk, _Rst, _PCLoad, _IRLoad, _RnW, _RfW, _EnB, _OpSel;
reg [1:0] _PCSel, _RFSel, _MSel;
reg [2:0] _Operation;
reg [3:0] _DLen;

//Outputs
wire _SelBit;
wire [3:0] _Cond, _CCodes;
wire [4:0] _OpCode;

datapath _dut(
    .i_Rst(_Rst),
    .i_Clk(_Clk),
    .i_PCLoad(_PCLoad),
    .i_IRLoad(_IRLoad),
    .i_RnW(_RnW),
    .i_RfW(_RfW),
    .i_EnB(_EnB),
    .i_OpSel(_OpSel),
    .i_PCSel(_PCSel),
    .i_RFSel(_RFSel),
    .i_MSel(_MSel),
    .i_Operation(_Operation),
    .i_DLen(_DLen),
    .o_SelBit(_SelBit),
    .o_Cond(_Cond),
    .o_CCodes(_CCodes),
    .o_OpCode(_OpCode)
);

always #1 _Clk = _Clk ^ 1;

initial begin
    _Clk        = 0;
    _PCLoad     = 0;
    _IRLoad     = 0;
    _RnW        = 0;
    _RfW        = 0;
    _EnB        = 0;
    _OpSel      = 0;
    _PCSel      = 0;
    _MSel       = 0;
    _Operation  = 0;
    _DLen       = 4'b1111;
    _Rst        = 1;
    #4;
    _Rst        = 0;
    _PCLoad     = 1;
    _RnW        = 1;
    _IRLoad     = 1;
    #4;

    #30;
    $finish;
end
endmodule
