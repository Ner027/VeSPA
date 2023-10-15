`timescale 1ns / 1ps

module memory_tb();

reg _Read, _Rst, _Clk;
reg [3:0]_DLen;
reg [22:0] _Addr;
reg [31:0] _Input;
wire [31:0] _Output;

memory _dut(
    .i_Read(_Read),
    .i_Rst(_Rst),
    .i_Clk(_Clk),
    .i_DLen(_DLen),
    .i_Addr(_Addr),
    .i_Input(_Input),
    .o_Output(_Output)
);

always #1 _Clk = _Clk ^ 1;

integer i;
initial begin
    _Read = 0;
    _Rst = 0;
    _Clk = 0;
    _DLen = 0;
    _Addr = 0;
    #2;
    _Rst = 1;
    #2;
    _Read = 1;
    _Rst = 0;
    _DLen = 4'b1111;

    for (i = 0; i < 32; i = i + 1) begin
        _Addr = i;
        #4;
    end

    _Read = 0;
    #4;

    for (i = 32; i < 64; i = i + 1) begin
        _Addr = i;
        _Input = i;
        #4;
    end
    
    $finish;

end

endmodule
