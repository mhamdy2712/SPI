`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 02:46:57 PM
// Design Name: 
// Module Name: SClk_generator
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


module SClk_generator #(parameter mode=2'b11)(
    input clk,
    input start,
    output SCLK,
    input reset_n
    );
    reg [3:0] count;
    reg clk_in;
    wire CPOL = mode==2'b11 || mode==2'b10;
    always @(posedge clk,negedge reset_n) begin
        if(~reset_n) begin
            count <= 0;
            clk_in <= CPOL ;
        end
        else begin
            count <= count +1;
            if(count == 7) begin
                clk_in <= ~clk_in;
            end
            if(count ==15) begin
                clk_in <= ~clk_in;
            end
        end    
    end
    assign SCLK = start ? clk_in : CPOL;
endmodule
