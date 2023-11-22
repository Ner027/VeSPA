`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2023 11:46:32 PM
// Design Name: 
// Module Name: memory_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module memory_tb();

reg rst,clk,read;
reg [3:0] dlen;
reg [22:0] addr;
reg [31:0] dataIn;
wire [31:0] out;

memory _Memtb(
        .i_Read(read),
        .i_Rst(rst),
        .i_Clk(clk),
        .i_DLen(dlen),
        .i_Addr(addr),
        .i_Input(dataIn),
        .o_Output(out)
);


always #1 clk = clk ^ 1;



initial begin
    rst = 1;
    clk = 0;
    read = 1;
    dlen = 4'b1111;
    addr = 0;
    dataIn = 32'hFFFFFFFF;
    #2;
    rst = 0;
    #2
    addr = 4;
    #2
    addr = 8;
    #2
    read = 0;
    #2;
    read = 1;
    #2
    dlen = 4'b0011;
    #10;
    $finish;
end


endmodule