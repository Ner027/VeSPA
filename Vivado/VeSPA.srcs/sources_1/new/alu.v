`timescale 1ns / 1ps

module alu(
    input i_Rst,
    input [2:0] i_Operation,
    input [31:0] i_OpL,
    input [31:0] i_OpR,
    output [3:0] o_CCodes,
    output [31:0] o_Output
);

parameter OP_ADD = 4'b0001,
          OP_SUB = 4'b0010,
          OP_ORL = 4'b0011,
          OP_AND = 4'b0100,
          OP_NOT = 4'b0101,
          OP_XOR = 4'b0110,
          OP_CMP = 4'b0111;

assign o_Output = (i_Operation == OP_ADD) ? (i_OpL + i_OpR) :
                  (i_Operation == OP_SUB) ? (i_OpR - i_OpL) :
                  (i_Operation == OP_ORL) ? (i_OpL | i_OpR) :
                  (i_Operation == OP_AND) ? (i_OpL & i_OpR) :
                  (i_Operation == OP_XOR) ? (i_OpL ^ i_OpR) :
                  (i_Operation == OP_NOT) ? (~i_OpL) :
                  (i_Operation == OP_CMP) ? o_Output : o_Output;

//Zero
assign o_CCodes[0] = ~(|o_Output);
//Neg
assign o_CCodes[1] = o_Output[31];
//Overflow
assign o_CCodes[2] = 0;
//Carry Out
assign o_CCodes[3] = 0;

endmodule
