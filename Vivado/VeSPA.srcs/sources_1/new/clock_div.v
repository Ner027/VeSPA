`timescale 1ns / 1ps

module clock_divider(
    input i_Rst,
    input i_Clk,
    output o_Clk
);

parameter divide_by = 1250000;

reg [31:0] _Counter;
reg _Clk;

assign o_Clk = _Clk;

always @(posedge i_Clk) begin
    if (i_Rst == 1'b1) begin
        _Counter <= 0;
        _Clk <= 0;
    end
    else begin
        _Counter = _Counter + 1;
        
        if (_Counter >= divide_by) begin
            _Counter <= 0;
            
            _Clk <= _Clk ^ 1;
        end
    end    
end

endmodule