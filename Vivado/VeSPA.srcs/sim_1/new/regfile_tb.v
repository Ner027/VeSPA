`timescale 1ns / 1ps

module regfile_tb();

reg _Clk, _Rst, _RnW, _EnB;
reg [4:0] _AddrA, _AddrB;
reg [31:0] _Input;
wire [31:0] _OutA, _OutB;

regfile _dut(
    .i_Clk(_Clk),
    .i_Rst(_Rst),
    .i_RnW(_RnW),
    .i_EnB(_EnB),
    .i_AddrA(_AddrA),
    .i_AddrB(_AddrB),
    .i_Input(_Input),
    .o_OutA(_OutA),
    .o_OutB(_OutB)
);

always #1 _Clk = _Clk ^ 1;

integer i;
initial begin
    _Clk = 0;
    _Rst = 0;
    _RnW = 0;
    _EnB = 0;
    _AddrA = 0;
    _AddrB = 0;
    _Input = 0;
    #2;
    _Rst = 1;
    #2;
    _Rst = 0;
    _RnW = 0;
    #2;

    for (i = 0; i < 32; i = i + 1) begin
        _AddrA = i;
        _Input = i;
        #2;
    end

    _RnW = 1;
    _EnB = 1;
    #2;

    for (i = 0; i < 16; i = i + 1) begin
        _AddrA = i;
        _AddrB = 32 - i;
        #2;
    end
    $finish;
end

endmodule
