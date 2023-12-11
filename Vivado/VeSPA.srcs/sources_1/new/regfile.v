/*`timescale 1ns / 1ps

module regfile(
    input i_Clk,
    input i_Rst,
    input i_RfW,
    input i_EnB,
    input[4:0] i_AddrW,
    input[4:0] i_AddrA,
    input[4:0] i_AddrB,
    input[31:0] i_Input,
    output o_RegfileReady,
    output [31:0] o_OutA,
    output [31:0] o_OutB
);

reg _MemUpdate;
wire _RstABusy, _RstBBusy, _Clk;
reg _RegWrite;
reg [31:0] _ShadowReg;
reg [5:0] _TempAddr;
wire [5:0] _AddrA;

assign _Clk = _MemUpdate ? ~_Clk : _Clk;
assign o_RegfileReady = ~(_RstABusy & _RstBBusy);
assign _AddrA = _MemUpdate ? i_AddrW : i_AddrA;

regfile_ip _RegFile (
   .i_Clk(_Clk),
   .i_Rst(i_Rst),
   .i_AddrA(_AddrA),
   .i_EnA(1),
   .i_WEnA(_MemUpdate),
   .i_AddrB(i_AddrB),
   .i_EnB(i_EnB),
   .i_WEnB(0),
   .i_DIn(_ShadowReg),
   .o_OutA(o_OutA),
   .o_OutB(o_OutB),
   .o_RstABusy(_RstABusy),
   .o_RstBBusy(_RstBBusy)
);

always @(posedge i_Clk) begin
    if (_MemUpdate) begin
        _MemUpdate <= 0;
    end
end

always @(posedge i_Clk) begin
    if (i_Rst) begin
        _MemUpdate <= 0;
        _ShadowReg <= 0;
        _RegWrite <= 0;
        _TempAddr <= 0;
    end
    else begin
        if (i_RfW) begin
            _MemUpdate <= 1;
            _ShadowReg <= i_Input;
            _TempAddr <= i_AddrW;
        end
        else begin
            _MemUpdate <= 0;
            _ShadowReg <= _ShadowReg;
            _TempAddr <= _TempAddr;
        end
    end
end

endmodule*/

`timescale 1ns / 1ps

module regfile(
    input i_Clk,
    input i_Rst,
    input i_RfW,
    input i_EnB,
    input[4:0] i_AddrW,
    input[4:0] i_AddrA,
    input[4:0] i_AddrB,
    input[31:0] i_Input,
    output reg[31:0] o_OutA,
    output reg[31:0] o_OutB
);

parameter REG_COUNT = 32;
integer i;

reg [31:0] _RegisterFile [REG_COUNT-1:0];
reg _MemUpdate;
reg [31:0] _TempReg, _TempAddr;

always @(posedge i_Clk) begin
    if (i_Rst) begin
        o_OutA <= 0;
        o_OutB <= 0;
        _MemUpdate <= 0;
        _TempReg <= 0;
        _TempAddr <= 0;

        for(i = 0; i < REG_COUNT; i = i + 1) begin
            _RegisterFile[i] <= 0;
        end
    end
    else begin
        o_OutA <= _RegisterFile[i_AddrA];

        if (i_EnB) begin
            o_OutB <= _RegisterFile[i_AddrB];
        end
        else begin
            o_OutB <= o_OutB;
        end

        if (i_RfW) begin
            _TempReg <= i_Input;
            _TempAddr <= i_AddrW;
            _MemUpdate <= 1;
        end
        else begin
            _MemUpdate <= 0;
            _TempReg <= _TempReg;
            _TempAddr <= _TempAddr;
        end
    end
end

always @(negedge i_Clk) begin
    if (_MemUpdate) begin
        _MemUpdate <= 0;
        _RegisterFile[_TempAddr] <= _TempReg;
    end
    else begin
        _MemUpdate <= _MemUpdate;
        _TempReg <= _TempReg;
        _TempAddr <= _TempAddr;
    end
end

endmodule
