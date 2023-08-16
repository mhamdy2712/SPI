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


module SPI_4Slaves #(parameter mode=2'b00,bits_size=8)(
    input clk,reset_n,
    input [bits_size-1:0] master_data_in,
    input [bits_size-1:0] slave_data_in1,
    input [bits_size-1:0] slave_data_in2,
    input [bits_size-1:0] slave_data_in3,
    input [bits_size-1:0] slave_data_in4,
    output [bits_size-1:0] master_data_out,
    output [bits_size-1:0] slave_data_out1,
    output [bits_size-1:0] slave_data_out2,
    output [bits_size-1:0] slave_data_out3,
    output [bits_size-1:0] slave_data_out4,
    input tx_start,
    output master_tx_done,
    output master_rx_done,
    output slave_tx_done1,
    output slave_rx_done1,
    output slave_tx_done2,
    output slave_rx_done2,
    output slave_tx_done3,
    output slave_rx_done3,
    output slave_tx_done4,
    output slave_rx_done4
    );
    wire MISO,MISO1,MISO2,MISO3,MISO4,MOSI,SCLK;
    wire [0:3] ss;
    MUX3X1 mux
    (
    .In1(MISO1),
    .In2(MISO2),
    .In3(MISO3),
    .In4(MISO4),
    .sel(ss),
    .out(MISO)
    );
    SPI_Master #(.mode(mode) , .bits_size(bits_size) , .slave_num(4) ) SpiM1(
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
    .MISO(MISO1),
    .tx_done(slave_tx_done1),
    .rx_done(slave_rx_done1),
    .data_in(slave_data_in1),
    .data_out(slave_data_out1),
    .ss(ss[0]),
    .SCLK(SCLK)
    );
    SPI_Slave #(.mode(mode) , .bits_size(bits_size)) SpiS2(
    .clk(clk),
    .reset_n(reset_n),
    .MOSI(MOSI),
    .MISO(MISO2),
    .tx_done(slave_tx_done2),
    .rx_done(slave_rx_done2),
    .data_in(slave_data_in2),
    .data_out(slave_data_out2),
    .ss(ss[1]),
    .SCLK(SCLK)
    );
    SPI_Slave #(.mode(mode) , .bits_size(bits_size)) SpiS3(
    .clk(clk),
    .reset_n(reset_n),
    .MOSI(MOSI),
    .MISO(MISO3),
    .tx_done(slave_tx_done3),
    .rx_done(slave_rx_done3),
    .data_in(slave_data_in3),
    .data_out(slave_data_out3),
    .ss(ss[2]),
    .SCLK(SCLK)
    );
    SPI_Slave #(.mode(mode) , .bits_size(bits_size)) SpiS4(
    .clk(clk),
    .reset_n(reset_n),
    .MOSI(MOSI),
    .MISO(MISO4),
    .tx_done(slave_tx_done4),
    .rx_done(slave_rx_done4),
    .data_in(slave_data_in4),
    .data_out(slave_data_out4),
    .ss(ss[3]),
    .SCLK(SCLK)
    );
endmodule
