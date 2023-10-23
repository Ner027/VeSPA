`timescale 1ns / 1ps

module memory(
    input i_Read,
    input i_Rst,
    input i_Clk,
    input [3:0]i_DLen,
    input [22:0] i_Addr,
    input [31:0] i_Input,
    output reg [31:0] o_Output
);

//Internal Variables
reg [7:0] _Memory [15:0];

always @(posedge i_Clk) begin

    if (i_Rst) begin
        o_Output <= 0;
    end
    else begin
        if (i_Read) begin
            o_Output <=
            {
                (_Memory[i_Addr + 0] & ({8{i_DLen[0]}})),
                (_Memory[i_Addr + 1] & ({8{i_DLen[1]}})),
                (_Memory[i_Addr + 2] & ({8{i_DLen[2]}})),
                (_Memory[i_Addr + 3] & ({8{i_DLen[3]}}))
            };
        end
        else begin
            {_Memory[i_Addr + 3], _Memory[i_Addr + 2], _Memory[i_Addr + 1], _Memory[i_Addr + 0]} <=
            {
                i_DLen[0] ? i_Input[31:24]  : _Memory[i_Addr + 0],
                i_DLen[1] ? i_Input[23:16]  : _Memory[i_Addr + 1],
                i_DLen[2] ? i_Input[15:8]   : _Memory[i_Addr + 2],
                i_DLen[3] ? i_Input[7:0]    : _Memory[i_Addr + 3]
            };

            o_Output <= o_Output;
        end
    end
end

initial begin
    $readmemb("mem_file.mem", _Memory);
end

endmodule
