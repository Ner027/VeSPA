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
          OP_SUB = 3'b010, // na operação de subtração é feito i_OpL - i_OpR
          OP_ORL = 3'b011,
          OP_AND = 3'b100,
          OP_NOT = 3'b101,
          OP_XOR = 3'b110,
          OP_CMP = 3'b111;
          
          
wire[31:0] addOp;
wire[31:0] OpR;
wire[31:0] OpR_CP2;
wire carryCP2;
wire carryAdder;
wire subSignal;
wire CCodesUpdate;

// saídas das operações lógicas
wire [31:0]o_ORL;
wire [31:0]o_AND;
wire [31:0]o_NOT;
wire [31:0]o_XOR;

// operações lógicas
genvar i;
for(i = 0;i<32;i = i+1)
    begin 
        or(o_ORL[i],i_OpL[i],i_OpR[i]);
        and(o_AND[i],i_OpL[i],i_OpR[i]);
        not(o_NOT[i],i_OpL[i]);
        xor(o_XOR[i],i_OpL[i],i_OpR[i]);
    end


// sinal que indica se será feita uma opreação de subtração
assign subSignal = (i_Operation == OP_SUB || i_Operation == OP_CMP) ? 1'b1 : 1'b0;


// Ripple carry adder para operação de soma
RC32 _RC32(
    .i_InputA(i_OpL),
    .i_InputB(OpR),
    .i_carry(1'b0),
    .o_Res(addOp),
    .o_carry(carryAdder)
    );
   
// Ripple carry adder que faz operando R + 1 para o complemento para 2.
RC32 _RC32CP2(
    .i_InputA(~i_OpR),
    .i_InputB(32'h00000001),
    .i_carry(1'b0),
    .o_Res(OpR_CP2),
    .o_carry(carryCP2)
    );
    
    
// escolhe qual o operando que é dado ao ADDER
assign OpR =  (i_Operation == OP_ADD) ? i_OpR:
              (i_Operation == OP_SUB || i_Operation == OP_CMP) ? OpR_CP2 : OpR;

       
// escolhe qual é a saída da ALU
assign o_Output = (i_Operation == OP_ADD) ? (addOp) :                   // para as operações de adição e subtração a saída é a mesma
                  (i_Operation == OP_SUB) ? (addOp) :                   // apenas muda a entrada do FullAdder
                  (i_Operation == OP_ORL) ? (o_ORL) :
                  (i_Operation == OP_AND) ? (o_AND) :
                  (i_Operation == OP_NOT) ? (o_NOT) :
                  (i_Operation == OP_XOR) ? (o_XOR) :
                  (i_Operation == OP_CMP) ? (addOp) :  o_Output;                 

                  
                  
assign CCodesUpdate =   i_Operation == OP_ADD || i_Operation == OP_SUB;

/*----------------------------------- condition codes --------------------------------------------------------
->[0] Zero 
->[1] Negativo 
->[2] Overflow
->[3] Carry out
*/ 
assign o_CCodes[0] = ~(|o_Output[31:0]);
assign o_CCodes[1] = (o_Output[31]);
assign o_CCodes[2] = (CCodesUpdate) ? ((~subSignal & ~addOp[31]) & (i_OpR[31] | i_OpL[31])) | ((subSignal & addOp[31]) & (~i_OpL[31] | i_OpR[31])) : o_CCodes[2];
assign o_CCodes[3] = (CCodesUpdate) ? (carryAdder) : o_CCodes[3];


endmodule