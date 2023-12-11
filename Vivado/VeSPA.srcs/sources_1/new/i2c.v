`timescale 1ns / 1ps

module i2c(
    input i_Clk,
    input i_Rst,
    input i_BaseClk,
    input i_EnW,
    input [7:0] i_TxByte,
    output reg o_EnQ,
    output reg o_SCL,
    output reg o_SDA
);

parameter ST_IDLE       = 3'b000,
          ST_START      = 3'b001,
          ST_REP_START  = 3'b010,
          ST_ADDR       = 3'b011,
          ST_RUNNING    = 3'b100,
          ST_STOP       = 3'b101;

reg [2:0] _CurrentState;

reg [7:0] _TxBuffer[7:0];
reg [7:0] _RxBuffer[7:0];
reg [2:0]_TxWrIndex;
reg [2:0]_TxRdIndex;
reg [2:0]_RxWrIndex;
reg [2:0]_RxRdIndex;


reg [3:0]_CurrentBit;

reg [7:0] _DevAddr;
reg [15:0] _ClkCfg;
reg [15:0] _ClkCounter;
reg [1:0] _PClkCounter;
reg _SClk;

always @(posedge i_BaseClk) begin
    if (i_Rst) begin
        _ClkCfg <= 300;
        _PClkCounter <= 0;
        _ClkCounter <= 0;
        _SClk <= 0;
        _CurrentState <= ST_IDLE;
        _DevAddr <= 8'hFA;
        _CurrentBit <= 0;
    end
    else begin
        if (_ClkCounter == _ClkCfg) begin
            if (_PClkCounter == 2'b11) begin
                _SClk <= _SClk ^ 1;
                _PClkCounter <= 0;
            end
            else begin
                _PClkCounter <= _PClkCounter + 1;
                _SClk <= _SClk;
            end

            _ClkCounter <= 0;
        end
        else begin
            _ClkCounter <= _ClkCounter + 1;
            _SClk <= _SClk;
        end
    end


end

always @(_PClkCounter == 2'b00) begin
    case (_CurrentState)
        ST_IDLE: begin
            o_SCL <= 1;
            o_SDA <= 1;
            _CurrentBit <= 0;
        end

        ST_ADDR: begin
            o_SCL <= 0;
            o_SDA = _DevAddr[_CurrentBit];
            _CurrentBit = _CurrentBit + 1;
        end
    endcase
end

always @(_PClkCounter == 2'b01) begin
    case (_CurrentState)
        ST_START: begin
            o_SDA <= 0;
        end
    endcase
end

always @(_PClkCounter == 2'b10) begin
    case (_CurrentState)
        ST_START: begin
            o_SCL <= 0;
        end
        ST_ADDR: begin
           o_SCL <= 1;
        end
    endcase
end


always @(_PClkCounter == 2'b11) begin
    case (_CurrentState)
        ST_IDLE: _CurrentState <= ST_START;
        ST_START: _CurrentState <= ST_ADDR;
        ST_ADDR: begin
            if (_CurrentBit > 3'b111) begin
                _CurrentState <= ST_IDLE;
            end
            else begin
                _CurrentState <= ST_ADDR;
            end
        end
    endcase
end


endmodule