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
