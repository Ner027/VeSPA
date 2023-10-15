`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2023 11:14:20 PM
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit();
    
    
//Decode Condition Codes
//parameter Z = _CCodes[0],
//          N = _CCodes[1],
//          O = _CCodes[2],
//          C = _CCodes[3];

//assign _TakeJump = ((_Cond == COND_BRA) ? 1 : 0)            |
//                   ((_Cond == COND_BNV) ? 0 : 1)            |
//                   (((_Cond == COND_BCC) & (~C)) ? 1 : 0)   |
//                   (((_Cond == COND_BCS) & (C)) ? 1 : 0)    |
//                   (((_Cond == COND_BVC) & (~O)) ? 1 : 0)   |
//                   (((_Cond == COND_BVS) & (O)) ? 1 : 0)    |
//                   (((_Cond == COND_BEQ) & (Z)) ? 1 : 0)    |
//                   (((_Cond == COND_BNE) & (~Z)) ? 1 : 0)   |
//                   (((_Cond == COND_BGE) & ((~N & ~O) | (N & O))) ? 1 : 0)       |
//                   (((_Cond == COND_BLT) & ((N & ~O) | (~N & O))) ? 1 : 0)       |
//                   (((_Cond == COND_BGT) & (~Z & ((~N & ~O)|(N & O)))) ? 1 : 0)  |
//                   (((_Cond == COND_BLE) & (Z | ((N & ~O)|(~N & O)))) ? 1 : 0)   |
//                   (((_Cond == COND_BPL) & (~N)) ? 1 : 0)   |
//                   (((_Cond == COND_BMI) & (N)) ? 1 : 0);

endmodule
