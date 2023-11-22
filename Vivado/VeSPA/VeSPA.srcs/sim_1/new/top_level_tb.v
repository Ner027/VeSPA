`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2023 09:52:22 PM
// Design Name: 
// Module Name: top_level_tb
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


module top_level_tb();

reg _Rst, _Clk;

top_level _dut(
    .i_Clk(_Clk),
    .i_Rst(_Rst)
);


always #1 _Clk = _Clk ^ 1;

initial begin
    _Rst = 1;
    _Clk = 0;
    #4;
    _Rst = 0;
    #300;
    $finish;
end

endmodule