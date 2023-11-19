`timescale 1ns / 1ps

module pic
(
    input i_Clk,
    input i_Rst,
    input [3:0] i_intLines,
    input [7:0] i_intCfg,
    output reg o_intPending,
    output reg [7:0] o_intFlags,
    output reg [31:0] o_jumpTo
);

integer i;

always @(i_intLines) begin
    if (!o_intPending) begin
        for (i = 0; i < 4; i = i + 1) begin
            if (i_intLines[i]) begin
                o_intFlags[i] <= 1;
                o_intPending <= 1;
                o_jumpTo <= ((i + 1) << 3);
            end
        end
    end
    else begin
        o_intFlags <= o_intFlags;
        o_jumpTo <= o_jumpTo;
    end
end

endmodule
