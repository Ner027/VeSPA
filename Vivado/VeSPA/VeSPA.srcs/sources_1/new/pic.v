`timescale 1ns / 1ps

module pic
(
    input i_Clk,
    input i_Rst,
    input [3:0] i_PAddr,
    input [7:0] i_PControl,
    input [31:0] i_PDataIn,
    input [3:0] i_intLines,
    output reg o_intPending,
    output reg [31:0] o_jumpTo,
    output reg [31:0] o_PDataOut
);

parameter PIC_ADDR = 4'b1010;
parameter NOF_REGS = 2;

wire _RfW, _RfR, _Addr;
assign _RfW     = i_PControl[0];
assign _RfR     = i_PControl[1];
assign _Addr    = i_PControl[2];

reg [31:0] _PicRegisterFile[(NOF_REGS - 1):0];
integer i;

always @(posedge i_Clk) begin
    if (i_Rst) begin
        for (i = 0; i < NOF_REGS; i = i + 1) begin
            _PicRegisterFile[i] <= 0;
        end
    end
    else begin
        if (i_PAddr == PIC_ADDR) begin
            if (_RfW) begin
                _PicRegisterFile[_Addr] <= i_PDataIn;
            end
            else begin
                if (_RfR) begin
                    o_PDataOut[_Addr] <= _PicRegisterFile[_Addr];
                end
                else begin
                    o_PDataOut <= o_PDataOut;
                end
            end
        end
        else begin
            //Do nothing
        end
    end
end

endmodule