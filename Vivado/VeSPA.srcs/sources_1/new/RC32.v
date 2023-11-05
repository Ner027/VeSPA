`timescale 1ns / 1ps

module RC32(
    input [31:0] i_InputA,
    input [31:0] i_InputB,
    input i_carry,
    output [31:0] o_Res,
    output o_carry
);
    
    wire[30:0] carry;
    
    FullAdder FA0(i_InputA[0],i_InputB[0],i_carry,o_Res[0],carry[0]);
    FullAdder FA1(i_InputA[1],i_InputB[1],carry[0],o_Res[1],carry[1]);
    FullAdder FA2(i_InputA[2],i_InputB[2],carry[1],o_Res[2],carry[2]);
    FullAdder FA3(i_InputA[3],i_InputB[3],carry[2],o_Res[3],carry[3]);
    FullAdder FA4(i_InputA[4],i_InputB[4],carry[3],o_Res[4],carry[4]);
    FullAdder FA5(i_InputA[5],i_InputB[5],carry[4],o_Res[5],carry[5]);
    FullAdder FA6(i_InputA[6],i_InputB[6],carry[5],o_Res[6],carry[6]);
    FullAdder FA7(i_InputA[7],i_InputB[7],carry[6],o_Res[7],carry[7]);
    FullAdder FA8(i_InputA[8],i_InputB[8],carry[7],o_Res[8],carry[8]);
    FullAdder FA9(i_InputA[9],i_InputB[9],carry[8],o_Res[9],carry[9]);
    FullAdder FA10(i_InputA[10],i_InputB[10],carry[9],o_Res[10],carry[10]);
    FullAdder FA11(i_InputA[11],i_InputB[11],carry[10],o_Res[11],carry[11]);
    FullAdder FA12(i_InputA[12],i_InputB[12],carry[11],o_Res[12],carry[12]);
    FullAdder FA13(i_InputA[13],i_InputB[13],carry[12],o_Res[13],carry[13]);
    FullAdder FA14(i_InputA[14],i_InputB[14],carry[13],o_Res[14],carry[14]);
    FullAdder FA15(i_InputA[15],i_InputB[15],carry[14],o_Res[15],carry[15]);
    FullAdder FA16(i_InputA[16],i_InputB[16],carry[15],o_Res[16],carry[16]);
    FullAdder FA17(i_InputA[17],i_InputB[17],carry[16],o_Res[17],carry[17]);
    FullAdder FA18(i_InputA[18],i_InputB[18],carry[17],o_Res[18],carry[18]);
    FullAdder FA19(i_InputA[19],i_InputB[19],carry[18],o_Res[19],carry[19]);
    FullAdder FA20(i_InputA[20],i_InputB[20],carry[19],o_Res[20],carry[20]);
    FullAdder FA21(i_InputA[21],i_InputB[21],carry[20],o_Res[21],carry[21]);
    FullAdder FA22(i_InputA[22],i_InputB[22],carry[21],o_Res[22],carry[22]);
    FullAdder FA23(i_InputA[23],i_InputB[23],carry[22],o_Res[23],carry[23]);
    FullAdder FA24(i_InputA[24],i_InputB[24],carry[23],o_Res[24],carry[24]);
    FullAdder FA25(i_InputA[25],i_InputB[25],carry[24],o_Res[25],carry[25]);
    FullAdder FA26(i_InputA[26],i_InputB[26],carry[25],o_Res[26],carry[26]);
    FullAdder FA27(i_InputA[27],i_InputB[27],carry[26],o_Res[27],carry[27]);
    FullAdder FA28(i_InputA[28],i_InputB[28],carry[27],o_Res[28],carry[28]);
    FullAdder FA29(i_InputA[29],i_InputB[29],carry[28],o_Res[29],carry[29]);
    FullAdder FA30(i_InputA[30],i_InputB[30],carry[29],o_Res[30],carry[30]);
    FullAdder FA31(i_InputA[31],i_InputB[31],carry[30],o_Res[31],o_carry);
    
endmodule