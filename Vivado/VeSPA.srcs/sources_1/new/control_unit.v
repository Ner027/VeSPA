`timescale 1ns / 1ps

module control_unit(
    input i_Rst,
    input i_Clk,
    input i_SelBit,
    input [3:0] i_Cond,
    input [3:0] i_CCodes,
    input [4:0] i_OpCode,
    output o_PCLoad,
    output o_IRLoad,
    output o_RnW,
    output o_RfW,
    output o_EnB,
    output o_OpSel,
    output [1:0] o_PcSel,
    output [1:0] o_RfSel,
    output [1:0] o_MSel,
    output [2:0] o_Operation,
    output [3:0] o_DLen
);

/***********************************************************************************************************************
 * Constants
 **********************************************************************************************************************/
 /*
  * Branch Conditions
  */
parameter COND_BRA = 4'b0000,
          COND_BNV = 4'b0001,
          COND_BCC = 4'b0010,
          COND_BCS = 4'b0011,
          COND_BVC = 4'b0100,
          COND_BVS = 4'b0101,
          COND_BEQ = 4'b0110,
          COND_BNE = 4'b0111,
          COND_BGE = 4'b1000,
          COND_BLT = 4'b1001,
          COND_BGT = 4'b1010,
          COND_BLE = 4'b1011,
          COND_BPL = 4'b1100,
          COND_BMI = 4'b1101;

 /*
  * Control Unit States
  */
parameter STATE_INIT    = 6'b100000,
          STATE_FETCH   = 6'b100001,
          STATE_DECODE  = 6'b100010;

 /*
  * OP Codes
  */
parameter OP_ADD    = 5'b00001,
          OP_SUB    = 5'b00010,
          OP_ORL    = 5'b00011,
          OP_AND    = 5'b00100,
          OP_NOT    = 5'b00101,
          OP_XOR    = 5'b00110,
          OP_CMP    = 5'b00111,
          OP_BXX    = 5'b01000,
          OP_JMP    = 5'b01001,
          OP_LD     = 5'b01010,
          OP_LDI    = 5'b01011,
          OP_LDX    = 5'b01100,
          OP_ST     = 5'b01101,
          OP_STX    = 5'b01110,
          OP_HLT    = 5'b11111,
          OP_NOP    = 5'b00000;

/***********************************************************************************************************************
 * Internal Variables
 **********************************************************************************************************************/
wire _TakeJump, _LinkJump, _Z, _N, _O, _C, _RfWAux;
reg [5:0] _CurrentState, _PrevState;

/***********************************************************************************************************************
 * Condition Code Decoding
 **********************************************************************************************************************/
assign _Z = i_CCodes[0];
assign _N = i_CCodes[1];
assign _O = i_CCodes[2];
assign _C = i_CCodes[3];

/***********************************************************************************************************************
 * Output Assignment
 **********************************************************************************************************************/
assign o_DLen = 4'b1111;

assign _RfWAux = ((_CurrentState == STATE_INIT) && (_PrevState == OP_LD)) ? 1 : 0;

assign _LinkJump = ((_CurrentState == OP_JMP) && (i_SelBit)) ? 1 : 0;

assign o_Operation = _CurrentState[2:0];

assign o_PCLoad = (((_CurrentState == OP_BXX) && _TakeJump) ||
                    (_CurrentState == OP_JMP) ||
                    (_CurrentState == STATE_FETCH)) ? 1 : 0;

assign o_IRLoad = (_CurrentState == STATE_FETCH) ? 1 : 0;

assign o_RnW = ((_CurrentState == OP_ST) || (_CurrentState == OP_STX)) ? 0 : 1;

assign o_RfW = ((_CurrentState == OP_CMP) || (_CurrentState == OP_BXX) || (_CurrentState == OP_JMP) ||
                (_CurrentState == OP_ST) || (_CurrentState == OP_STX) || (_CurrentState > OP_HLT) ||
                (_CurrentState == OP_LD)) ? (_RfWAux ? 1 : 0 ) : 1;

//assign o_EnB = (~i_SelBit) & ((_CurrentState < OP_BXX) ? 1 : 0);
assign o_EnB = 1;

assign o_OpSel = i_SelBit;

assign o_PcSel = (_CurrentState == STATE_FETCH) ? 2'b00 :
                 (_CurrentState == STATE_INIT) ? 2'b00 :
                 (_CurrentState == OP_BXX) ? (_TakeJump ? 2'b01 : 2'b00) :
                 (_CurrentState == OP_JMP) ? 2'b10 : 0;

assign o_RfSel = (_CurrentState < OP_CMP)   ? 0 :
                 (_CurrentState == OP_CMP)  ? 2'b01 :
                 (_LinkJump)                ? 2'b10 :
                 (_CurrentState == OP_LD)   ? 2'b01 :
                 (_CurrentState == OP_LDI)  ? 2'b11 : 2'b01;

assign o_MSel = (_CurrentState == OP_BXX) ? 2'b01 :
                (_CurrentState == OP_LD)  ? 2'b11 :
                (_CurrentState == OP_LD)  ? 2'b11 :
                (_CurrentState == OP_ST)  ? 2'b11 :
                ((_CurrentState == STATE_FETCH) || (_CurrentState == STATE_INIT)) ? 2'b00 :  2'b10;

//Decide wether or not the jump should be taken, refer to spec for more details


assign _TakeJump = ((i_Cond == COND_BRA) ? 1 : 0)               |
                   ((i_Cond == COND_BNV) ? 0 : 0)               |
                   (((i_Cond == COND_BCC) & (~_C)) ? 1 : 0)     |
                   (((i_Cond == COND_BCS) & (_C)) ? 1 : 0)      |
                   (((i_Cond == COND_BVC) & (~_O)) ? 1 : 0)     |
                   (((i_Cond == COND_BVS) & (_O)) ? 1 : 0)      |
                   (((i_Cond == COND_BEQ) & (_Z)) ? 1 : 0)      |
                   (((i_Cond == COND_BNE) & (~_Z)) ? 1 : 0)     |
                   (((i_Cond == COND_BGE) & ((~_N & ~_O) | (_N & _O))) ? 1 : 0)        |
                   (((i_Cond == COND_BLT) & ((_N & ~_O) | (~_N & _O))) ? 1 : 0)        |
                   (((i_Cond == COND_BGT) & (~_Z & ((~_N & ~_O)|(_N & _O)))) ? 1 : 0)  |
                   (((i_Cond == COND_BLE) & (_Z | ((_N & ~_O)|(~_N & _O)))) ? 1 : 0)   |
                   (((i_Cond == COND_BPL) & (~_N)) ? 1 : 0)     |
                   (((i_Cond == COND_BMI) & (_N)) ? 1 : 0);


                    
/***********************************************************************************************************************
 * Control Unit FSM
 **********************************************************************************************************************/
always @(posedge i_Clk) begin
    if (i_Rst) begin
        _CurrentState <= STATE_INIT;
    end
    else begin
        _PrevState = _CurrentState;

        case (_CurrentState)
            STATE_INIT: _CurrentState <= STATE_FETCH;
            STATE_FETCH: _CurrentState <= STATE_DECODE;
            STATE_DECODE: _CurrentState <= i_OpCode;
            OP_HLT: _CurrentState <= OP_HLT;
            default: _CurrentState <= STATE_INIT;
        endcase
    end
end

endmodule