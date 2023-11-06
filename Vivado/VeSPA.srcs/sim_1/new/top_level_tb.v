`timescale 1ns / 1ps

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
