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

always @(posedge i_Clk) begin
    if (i_Rst) begin
        for (i = 0; i < REG_COUNT; i = i + 1) begin
            _RegisterFile[i] <= 0;
        end
    end
    else begin
        if (i_RfW) begin
            _RegisterFile[i_AddrW] <= i_Input;
        end
        else begin
            _RegisterFile[i_AddrW] <= _RegisterFile[i_AddrW];
        end
    end
end

always @(i_AddrA or i_AddrB or i_Rst or i_Clk) begin
    if (i_Rst) begin
        o_OutA <= 0;
        o_OutB <= 0;
    end
    else begin
       o_OutA <= _RegisterFile[i_AddrA];
       if (i_EnB) begin
           o_OutB <= _RegisterFile[i_AddrB];
       end
       else begin
           o_OutB <= 0;
       end
    end
end

endmodule
