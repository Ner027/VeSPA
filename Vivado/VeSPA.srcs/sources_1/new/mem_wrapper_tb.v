`timescale 1ns / 1ps

module mem_wrapper_tb();

reg _Clk, _Rst, _EnW;
reg [14:0] _Addr;
reg [31:0] _DIn, _PDataIn;
wire _MemRdy;
wire [3:0] _PDevAddr;
wire [7:0] _PControl;
wire [31:0] _DOut, _PDataOut;

memory_wrapper _dut
(
    .i_Clk(_Clk),
    .i_Rst(_Rst),
    .i_Addr(_Addr),
    .i_DIn(_DIn),
    .i_EnW(_EnW),
    .i_PDataIn(_PDataIn),
    .o_DOut(_DOut),
    .o_PDevAddr(_PDevAddr),
    .o_PControl(_PControl),
    .o_MemReady(_MemRdy),
    .o_PDataOut(_PDataOut)
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

    #4;

    _PDataIn = 32'hFAFEDEAD;
    _EnW <= 0;
    _Addr <= 8192;
    
    #4;
    _PDataIn = 32'hDEADBEEF;
    _EnW <= 0;
    _Addr <= 8193;
    
    
    #300;
    $finish;
end

endmodule
