`timescale 1ns / 1ps

module top_level_tb();

reg _Rst, _Clk;
reg [3:0] _IntLines;

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
    #50;
    _IntLines <= 4'b0001;
    #300;
    $finish;
end

endmodule
