`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 06:52:47 PM
// Design Name: 
// Module Name: SPI
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


module SPI#(parameter mode=2'b00,bits_size=8)(
    input clk,reset_n,
    input [bits_size-1:0] master_data_in,
    input [bits_size-1:0] slave_data_in,
    output [bits_size-1:0] master_data_out,
    output [bits_size-1:0] slave_data_out,
    input tx_start,
    output master_tx_done,
    output master_rx_done,
    output slave_tx_done,
    output slave_rx_done
    );
    wire MISO,MOSI,ss,SCLK;
    SPI_Master #(.mode(mode) , .bits_size(bits_size)) SpiM1(
    .clk(clk),
    .reset_n(reset_n),
    .data_in(master_data_in),
    .data_out(master_data_out),
    .tx_done(master_tx_done),
    .rx_done(master_rx_done),
    .tx_start(tx_start),
    .MOSI(MOSI),
    .MISO(MISO),
    .ss(ss),
    .SCLK(SCLK)
    );
    SPI_Slave #(.mode(mode) , .bits_size(bits_size)) SpiS1(
    .clk(clk),
    .reset_n(reset_n),
    .MOSI(MOSI),
    .MISO(MISO),
    .tx_done(slave_tx_done),
    .rx_done(slave_rx_done),
    .data_in(slave_data_in),
    .data_out(slave_data_out),
    .ss(ss),
    .SCLK(SCLK)
    );
endmodule
