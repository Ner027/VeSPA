`timescale 1ns / 1ps

module memory_wrapper(
    input i_Clk,
    input i_Rst,
    input i_EnW,
    input [14:0] i_Addr,
    input [31:0] i_DIn,
    input [31:0] i_PDataIn,
    output o_MemReady,
    output [3:0] o_PDevAddr,
    output [7:0] o_PControl,
    output [31:0] o_DOut,
    output [31:0] o_PDataOut
);

parameter PIC_NOF_REGS = 2;
parameter I2C_NOF_REGS = 4;

parameter MEM_SIZE = 8192;
parameter PIC_START_ADDR = MEM_SIZE;
parameter I2C_START_ADDR = PIC_START_ADDR + PIC_NOF_REGS;

parameter PIC_ADDR = 4'b1010;
parameter I2C_ADDR = 4'b0101;

wire _EnA;
wire _EnB;
wire _RstABusy;
wire _RstBBusy;
wire _RegionMem;
wire _RegionPic;
wire _RegionI2C;
wire [1:0] _Offset;
wire [3:0] _WEnA;
wire [3:0] _WEnB;
wire [5:0] _PRegAddr;
wire [7:0] _PControlInternal;
wire [12:0] _AddrA;
wire [12:0] _AddrB;
wire [31:0] _DInA;
wire [31:0] _DInB;
wire [31:0] _DOutA;
wire [31:0] _DOutB;
wire [31:0] _DOutInternal;

assign _EnA = 1;
assign _EnB = 1;

assign o_MemReady = ~(_RstABusy & _RstBBusy);

assign _AddrA = i_Addr[14:2];
assign _AddrB = _AddrA + 1;
assign _Offset = i_Addr[1:0];

assign _RegionMem = (i_Addr < MEM_SIZE);
assign _RegionPic = ((i_Addr >= MEM_SIZE) && (i_Addr < (MEM_SIZE + 2)));
assign _RegionI2C = 0;

assign o_PDevAddr = _RegionPic ? PIC_ADDR : _RegionI2C ? I2C_ADDR : 4'bZZZZ;
assign _PRegAddr = _RegionPic ? (i_Addr - PIC_START_ADDR) : _RegionI2C ? (i_Addr - I2C_START_ADDR) : 6'bZZZZZZ;
assign _PControlInternal = {_PRegAddr, ~i_EnW, i_EnW};
assign o_PControl = (_RegionPic || _RegionI2C) ? _PControlInternal : 7'bZZZZZZZZ;
assign o_PDataOut = (_RegionPic || _RegionI2C) ? i_DIn : 32'bZ;

assign _DOutInternal = (_Offset == 0) ? _DOutA :
                (_Offset == 1) ? {_DOutA[23:0], _DOutB[31:24]} :
                (_Offset == 2) ? {_DOutA[15:0], _DOutB[31:16]} :
                (_Offset == 3) ? {_DOutA[7:0], _DOutB[31:8]} : _DOutA;

assign _WEnA = i_EnW ? ((_Offset == 0) ? 4'b1111 :
               (_Offset == 1) ? 4'b0111 :
               (_Offset == 2) ? 4'b0011 :
               (_Offset == 3) ? 4'b0001 : 0) : 0;

assign _WEnB = i_EnW ? ((_Offset == 0) ? 4'b0000 :
               (_Offset == 1) ? 4'b0001 :
               (_Offset == 2) ? 4'b0011 :
               (_Offset == 3) ? 4'b0111 : 0) : 0;

assign _DInA = (_Offset == 0) ? i_DIn :
               (_Offset == 1) ? {8'b0, i_DIn} :
               (_Offset == 2) ? {16'b0, i_DIn} :
               (_Offset == 3) ? {24'b0, i_DIn} : 0;

assign _DInB = (_Offset == 3) ? i_DIn :
               (_Offset == 2) ? {8'b0, i_DIn} :
               (_Offset == 1) ? {16'b0, i_DIn} :
               (_Offset == 0) ? {24'b0, i_DIn} : 0;

assign o_DOut = _RegionMem ? _DOutInternal : i_PDataIn;

mem_ip _IPMem(
    .i_Rst(i_Rst),
    .i_Clk(i_Clk),
    .i_EnA(_EnA),
    .i_EnB(_EnB),
    .i_WEnA(_WEnA),
    .i_WEnB(_WEnB),
    .i_AddrA(_AddrA),
    .i_AddrB(_AddrB),
    .i_DInA(_DInA),
    .i_DInB(_DInB),
    .o_DOutA(_DOutA),
    .o_DOutB(_DOutB),
    .o_RstABusy(_RstABusy),
    .o_RstBBusy(_RstBBusy)
);

endmodule
