`timescale 1ns / 1ps

module pic_tb();

reg _Clk, _Rst, _RfW, _RfR;
reg [5:0] _BusAddr;
reg [3:0] _intLines;
reg [3:0] _devAddr;
reg [31:0] _PDataIn;
reg [7:0] _PControl;
wire [31:0] _jumpTo;
wire [31:0] _PDataOut;

parameter PIC_ADDR = 4'b1010;
parameter PIC_CFG_REG = 1'b0;
parameter PIC_INT_REG = 1'b1;

parameter BUS_RFW   = 7'b00;
parameter BUS_RFR   = 7'b01;
parameter BUS_ADDR  = 7'b10;


pic _dut
(
       .i_Clk(_Clk),
       .i_Rst(_Rst),
       .i_intLines(_intLines),
       .i_PControl(_PControl),
       .i_PAddr(_devAddr),
       .i_PDataIn(_PDataIn),
       .o_PDataOut(_PDataOut),
       .o_jumpTo(_jumpTo)
);

always #1 _Clk <= _Clk ^ 1;

initial begin
    _Clk = 0;
    _Rst = 1;
    #2;
    _Rst = 0;
    #2;
     _PDataIn = 32'h000B00B5;
    _devAddr = PIC_ADDR;
    _BusAddr = PIC_CFG_REG;
    _RfW = 1;
    _RfR = 0;
    _PControl = {_BusAddr, _RfR, _RfW};
    #5;
    _BusAddr = PIC_INT_REG;
    _PDataIn = 32'hFAFEDEAD;
    _PControl = {_BusAddr, _RfR, _RfW};
    #5;
    $finish;

end

endmodule
