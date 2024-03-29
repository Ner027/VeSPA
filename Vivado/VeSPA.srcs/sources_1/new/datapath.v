`timescale 1ns / 1ps

/// \brief This module contains the CPU datapath
/// \input i_Rst Reset Signal
/// \input i_Clk Clock Signal
/// \input i_PCLoad Choose whether or not Program Counter should load a new value
/// \input i_IRLoad Choose whether or not Instruction Register should load a new value
/// \input i_RnW Memory Read/!Write Signal
/// \input i_RfW Enable/Disable writing to the Register File
/// \input i_EnB Enable/Disable the Register File B Port
/// \input i_OpSel Choose whether the ALU Left Operand comes from the Register File B Port or a 16-bit immediate
/// \input i_CCLoad Choose if the Condition Codes should be updated or not
module datapath(
    input i_Rst,
    input i_Clk,
    input i_PCLoad,
    input i_IRLoad,
    input i_RnW,
    input i_RfW,
    input i_EnB,
    input i_OpSel,
    input i_CCload,
    input [1:0] i_PCSel,
    input [1:0] i_RFSel,
    input [1:0] i_MSel,
    input [2:0] i_Operation,
    input [3:0] i_DLen,
    input [31:0] i_PDataIn,
    output o_MemRdy,
    output o_SelBit,
    output [3:0] o_Cond,
    output [3:0] o_CCodes,
    output [3:0] o_PAddr,
    output [4:0] o_OpCode,
    output [7:0] o_PControl,
    output [31:0] o_PDataOut
);

//Internal Variables
wire [3:0]_CCodes;
wire [4:0] _AddrA, _AddrB, _AddrW;
wire [31:0] _MemAddr;
wire [31:0] _MemIn, _MemOut, _OpR, _OpL, _AluOut, _RegIn, _RfA, _RfB;

regfile _RegFile(
    .i_Clk(i_Clk),
    .i_Rst(i_Rst),
    .i_AddrA(_AddrA),
    .i_AddrB(_AddrB),
    .i_AddrW(_AddrW),
    .i_RfW(i_RfW),
    .i_EnB(i_EnB),
    .i_Input(_RegIn),
    .o_OutA(_RfA),
    .o_OutB(_RfB)
);

memory_wrapper _Mem(
    .i_Clk(i_Clk),
    .i_Rst(i_Rst),
    .i_Addr(_MemAddr),
    .i_EnW(~i_RnW),
    .i_PDataIn(i_PDataIn),
    .i_DIn(_MemIn),
    .o_MemReady(o_MemRdy),
    .o_DOut(_MemOut),
    .o_PDataOut(o_PDataOut),
    .o_PControl(o_PControl),
    .o_PDevAddr(o_PAddr)
);

alu _Alu(
    .i_Rst(i_Rst),
    .i_OpR(_OpR),
    .i_OpL(_OpL),
    .i_Operation(i_Operation),
    .o_CCodes(_CCodes),
    .o_Output(_AluOut)
);

//Program Counter Support
reg [31:0] _IReg;
reg [22:0] _PCounter;

//Intruction Register Decode
wire [4:0]  _RegDst, _RegS1, _RegS2, _Idx;
wire [15:0] _Imm16;
wire [16:0] _Imm17;
wire [21:0] _Imm22;
wire [22:0] _Imm23;

//Memory input
assign _MemIn = _RfA;

//Register file input
assign _RegIn = (i_RFSel == 2'b00) ? _AluOut :
                (i_RFSel == 2'b01) ? _MemOut :
                (i_RFSel == 2'b10) ? _PCounter :
                (i_RFSel == 2'b11) ? _Imm22 : 0;

assign o_CCodes = (i_CCload == 1'b1) ? _CCodes : o_CCodes;

//Left operand is allways aquired from the register file
assign _OpL = _RfA;

//Right operand is either provided by the register file, or its a 16bit immediate decoded from the IR
assign _OpR = (i_OpSel) ? {({16{_Imm16[15]}}), _Imm16} : _RfB;

//The memmory address can either come from the Program Counter, from a 16bit immediate decoded from the IR
//Or calculated from a 17bit immediate + a value provided by the register file
assign _MemAddr = (i_MSel == 2'b00) ? _PCounter :
                  (i_MSel == 2'b01) ? _Imm16:
                  (i_MSel == 2'b10) ? ({{16{_Imm16[15]}}, _Imm16} + _RfA) :
                  (i_MSel == 2'b11) ? (_Imm23) : _MemAddr;

//Register file addresses
assign _AddrW = _RegDst;
assign _AddrA = _RegS1;
assign _AddrB = _RegS2;

//IR Decode
assign o_SelBit = _IReg[16];
assign o_Cond   = _IReg[26:23];
assign o_OpCode = _IReg[31:27];
assign _RegDst  = _IReg[26:22];
assign _RegS1   = _IReg[21:17];
assign _RegS2   = _IReg[15:11];
assign _Idx     = _IReg[21:17];
assign _Imm16   = _IReg[15:0];
assign _Imm17   = _IReg[16:0];
assign _Imm22   = _IReg[21:0];
assign _Imm23   = _IReg[22:0];

always @(posedge i_Clk) begin
    if (i_Rst) begin
        _PCounter <= 0;
    end
    else begin
        if (i_PCLoad) begin
            //Normal Execution
            if (i_PCSel == 2'b00) begin
                _PCounter <= _PCounter + 4;
            end
            //Branch
            else if (i_PCSel == 2'b01) begin
                _PCounter <= _Imm23;
            end
            //JMP
            else if (i_PCSel == 2'b10) begin
                _PCounter <= ({({16{_Imm16[15]}}), _Imm16} + _RfA);
                $display(_PCounter);
            end
            //Interrupt
            else if (i_PCSel == 2'b11) begin
                _PCounter <= _PCounter;
            end
            //Invalid Condition
            else begin
                _PCounter <= _PCounter;
            end
        end
        else begin
            _PCounter <= _PCounter;
        end
    end
end 

always @(posedge i_Clk) begin
    if (i_Rst) begin
        _IReg <= 0;
    end
    else begin
        if (i_IRLoad) begin
            _IReg <= _MemOut;
        end
        else begin
            _IReg <= _IReg;
        end
    end
end

endmodule
