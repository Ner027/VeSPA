`timescale 1ns / 1ps

module FullAdder(
    input i_A,
    input i_B,
    input i_Cin,
    output o_Sum,
    output o_Cout
    );

    assign o_Sum = i_A ^ i_B ^ i_Cin;
    assign o_Cout = (i_A & i_B) | (i_A & i_Cin) | (i_B & i_Cin);
    
endmodule