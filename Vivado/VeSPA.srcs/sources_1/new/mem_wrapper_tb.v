`timescale 1ns / 1ps

module mem_wrapper_tb();

reg _Clk, _Rst, _EnW;
reg [14:0] _Addr;
reg [31:0] _DIn;
wire [31:0] _DOut;
wire _MemRdy;

memory_wrapper _dut
(
    .i_Clk(_Clk),
    .i_Rst(_Rst),
    .i_Addr(_Addr),
    .i_DIn(_DIn),
    .i_EnW(_EnW),
    .o_DOut(_DOut),
    .o_MemReady(_MemRdy)
);

always #1 _Clk = _Clk ^ 1;
integer i;
initial begin
    _Clk <= 0;
    _Rst <= 1;
    _EnW <= 0;
    #5;
    _Rst <= 0;
    #30;

    for (i = 0; i < 32; i = i + 1) begin
        _Addr <= i;
        #2;
    end

    #300;
    $finish;
end

endmodule
