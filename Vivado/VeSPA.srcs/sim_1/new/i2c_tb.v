`timescale 1ns / 1ps

module i2c_tb();

reg _Clk, _Rst, _EnW;
reg [7:0] _TxByte;
wire _EnQ;

i2c _Dut(
    .i_Clk(_Clk),
    .i_Rst(_Rst),
    .i_BaseClk(_Clk),
    .i_TxByte(_TxByte),
    .i_EnW(_EnW),
    .o_EnQ(_EnQ)
);

//8ns = 125MHz (PS CLK)
always #8 _Clk <= _Clk ^ 1;

initial begin
    _Rst <= 1;
    _Clk <= 0;
    #10;
    _Rst <= 0;

end

endmodule
