`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 04:37:47 PM
// Design Name: 
// Module Name: SPI_Master_tb
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


module SPI_Master_tb(

    );
    parameter clk_cycle=10;
    reg clk,reset_n,tx_start;
    reg [7:0] data_in_master,data_in_slave;
	wire [7:0] data_out_master,data_out_slave;
	wire master_tx_done,master_rx_done,slave_tx_done,slave_rx_done;
    always begin
        clk=0;
        #(clk_cycle/2);
        clk=1;
        #(clk_cycle/2);
    end
    SPI sm(
    .clk(clk),
    .reset_n(reset_n),
    .tx_start(tx_start),
    .master_data_in(data_in_master),
    .slave_data_in(data_in_slave),
	.master_data_out(data_out_master),
	.slave_data_out(data_out_slave),
	.master_tx_done(master_tx_done),
	.master_rx_done(master_rx_done),
	.slave_tx_done(slave_tx_done),
    .slave_rx_done(slave_rx_done)
    );
    initial begin
        data_in_master = 8'b10101011;
        data_in_slave = 8'b10110111;
        reset_n=0;
        #(clk_cycle);
        reset_n =1;
        tx_start=1;
        #(clk_cycle);
        tx_start=0;
        #(60*clk_cycle);
        data_in_master = 8'b11100111;
        data_in_slave = 8'b11100101;
        tx_start=1;
        #(clk_cycle);
        tx_start=0;
    end
endmodule
