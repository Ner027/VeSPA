`timescale 1ns / 1ps

module memory(
    input i_Read,
    input i_Rst,
    input i_Clk,
    input [3:0] i_DLen,
    input [22:0] i_Addr,
    input [31:0] i_Input,
    input [31:0] i_PDataIn,
    output [3:0] o_PAddr,
    output [7:0] o_PControl,
    output [31:0] o_PDataOut,
    output reg [31:0] o_Output
);

parameter MEM_DEPTH = 127;
//Internal Variables
reg [7:0] _Memory [MEM_DEPTH:0];

always @(posedge i_Clk) begin
    if (i_Rst) begin
        _Memory[0] = 01011000;
        _Memory[1] = 00000000;
        _Memory[2] = 11111010;
        _Memory[3] = 11111110;

        _Memory[4] = 01011000;
        _Memory[5] = 01000000;
        _Memory[6] = 11011110;
        _Memory[7] = 10101101;

        _Memory[8] = 01101000;
        _Memory[9] = 00000000;
        _Memory[10] = 00000000;
        _Memory[11] = 01000000;
        
        _Memory[12] = 01001000;
        _Memory[13] = 00000000;
        _Memory[14] = 00000000;
        _Memory[15] = 00000000;

        _Memory[16] = 01001000;
        _Memory[17] = 00000000;
        _Memory[18] = 00000000;
        _Memory[19] = 00000000;

        _Memory[20] = 11111000;
        _Memory[21] = 00000000;
        _Memory[22] = 00000000;
        _Memory[23] = 00000000;



        o_Output <= 0;
    end
    else begin
        if (i_Read) begin
            if (i_Addr > MEM_DEPTH) begin

            end
            else begin
                o_Output <=
                {
                    (_Memory[i_Addr + 0] & ({8{i_DLen[0]}})),
                    (_Memory[i_Addr + 1] & ({8{i_DLen[1]}})),
                    (_Memory[i_Addr + 2] & ({8{i_DLen[2]}})),
                    (_Memory[i_Addr + 3] & ({8{i_DLen[3]}}))
                };
            end
        end
        else begin
            {_Memory[i_Addr + 0], _Memory[i_Addr + 1], _Memory[i_Addr + 2], _Memory[i_Addr + 3]} <=
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

/*
initial begin
    $readmemb("mem_file.mem", _Memory);
end
*/

endmodule
