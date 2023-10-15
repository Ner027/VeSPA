`timescale 1ns / 1ps

module datapath_tb();

reg _Clk, _Rst, _Branch, _Jmp, _PCLoad, _IRLoad;

datapath _dut(
    .i_Rst(_Rst),
    .i_Clk(_Clk),
    .i_Branch(_Branch),
    .i_Jmp(_Jmp),
    .i_PCLoad(_PCLoad),
    .i_IRLoad(_IRLoad)
);

endmodule
