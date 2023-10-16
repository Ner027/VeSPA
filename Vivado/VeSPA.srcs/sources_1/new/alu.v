`timescale 1ns / 1ps

module alu(
    input i_Rst,
    input [2:0] i_Operation,
    input [31:0] i_OpL,
    input [31:0] i_OpR,
    output [3:0] o_CCodes,
    output [31:0] o_Output
);

parameter OP_ADD = 3'b001,
          OP_SUB = 3'b010,
          OP_ORL = 3'b011,
          OP_AND = 3'b100,
          OP_NOT = 3'b101,
          OP_XOR = 3'b110,
          OP_CMP = 3'b111;

assign o_Output = (i_Operation == OP_ADD) ? (i_OpL + i_OpR) :
                  (i_Operation == OP_SUB) ? (i_OpR - i_OpL) :
                  (i_Operation == OP_ORL) ? (i_OpL | i_OpR) :
                  (i_Operation == OP_AND) ? (i_OpL & i_OpR) :
                  (i_Operation == OP_XOR) ? (i_OpL ^ i_OpR) :
                  (i_Operation == OP_CMP) ? (i_OpR - i_OpL) :
                  (i_Operation == OP_NOT) ? (~i_OpL) : o_Output;

//Zero
assign o_CCodes[0] = ~(|o_Output);
//Neg
assign o_CCodes[1] = o_Output[31];
//Overflow
assign o_CCodes[2] = 0;
//Carry Out
assign o_CCodes[3] = 0;

endmodule
