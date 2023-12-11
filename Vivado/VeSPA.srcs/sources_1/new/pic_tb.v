`timescale 1ns / 1ps

module pic_tb();

reg _Clk, _Rst;
reg [7:0] _intCfg;
reg [3:0] _intLines;
wire _intPending;
wire [7:0] _intFlags;
wire [31:0] _jumpTo;

pic _dut
(
       .i_Clk(_Clk),
       .i_Rst(_Rst),
       .i_intLines(_intLines),
       .o_intPending(_intPending),
       .o_jumpTo(_jumpTo)
);

always #1 _Clk <= _Clk ^ 1;

initial begin
    _Clk = 0;
    _Rst = 1;
    #2;
    _Rst = 0;
    _intLines = 4'b0010;
end

endmodule
