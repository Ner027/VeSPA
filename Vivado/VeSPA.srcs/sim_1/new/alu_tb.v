`timescale 1ns / 1ps

module alu_tb();

reg _Rst;
reg [2:0] _Operation;
reg [31:0] _OpR, _OpL;
wire [3:0] _CCodes;
wire [31:0] _Output;

wire C,N,V,Z;

integer i;

alu _dut(
    .i_Rst(_Rst),
    .i_Operation(_Operation),
    .i_OpL(_OpL),
    .i_OpR(_OpR),
    .o_CCodes(_CCodes),
    .o_Output(_Output)
);

assign Z = _CCodes[0];
assign N = _CCodes[1];
assign V = _CCodes[2];
assign C = _CCodes[3];

initial begin
    _Rst <= 1;
    _Operation <= 0;
    _OpR <= 0;
    _OpL <= 0;
    #2;
    _Rst <= 0;

    _OpL = 32'hFFFFFFFF;
    _OpR = 32'h00000AAA;

    for (i = 0; i < 8; i = i + 1) begin
        _Operation = i;
        #1;
    end

    $finish;
end

endmodule
