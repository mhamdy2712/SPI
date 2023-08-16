`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2023 02:42:13 PM
// Design Name: 
// Module Name: MUX
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



module MUX3X1
    (
    input In1,
    input In2,
    input In3,
    input In4,
    input [0:3] sel,
    output reg out
    );
    always @(*) begin
        case(sel)
            4'b0111: out=In1;
            4'b1011: out=In2;
            4'b1101: out=In3;
            4'b1110: out=In4;
            default: out = 0;
        endcase
    end
endmodule
