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
    reg [9:0] data_in_master,data_in_slave1;
    reg [9:0] data_in_slave4;
    reg [9:0] data_in_slave2;
    reg [9:0] data_in_slave3;
	wire [9:0] data_out_master,data_out_slave1,data_out_slave2,data_out_slave3,data_out_slave4;
	wire master_tx_done,master_rx_done,slave_tx_done1,slave_rx_done1;
	wire slave_tx_done2,slave_rx_done2;
	wire slave_tx_done3,slave_rx_done3;
	wire slave_tx_done4,slave_rx_done4;
    always begin
        clk=0;
        #(clk_cycle/2);
        clk=1;
        #(clk_cycle/2);
    end
    SPI_4Slaves sm11(
    .clk(clk),
    .reset_n(reset_n),
    .tx_start(tx_start),
    .master_data_in(data_in_master),
    .slave_data_in1(data_in_slave1),
    .slave_data_in2(data_in_slave2),
    .slave_data_in3(data_in_slave3),
    .slave_data_in4(data_in_slave4),
	.master_data_out(data_out_master),
	.slave_data_out1(data_out_slave1),
	.slave_data_out2(data_out_slave2),
	.slave_data_out3(data_out_slave3),
	.slave_data_out4(data_out_slave4),
	.master_tx_done(master_tx_done),
	.master_rx_done(master_rx_done),
	.slave_tx_done1(slave_tx_done1),
    .slave_rx_done1(slave_rx_done1),
    .slave_tx_done2(slave_tx_done2),
    .slave_rx_done2(slave_rx_done2),
    .slave_tx_done3(slave_tx_done3),
    .slave_rx_done3(slave_rx_done3),
    .slave_tx_done4(slave_tx_done4),
    .slave_rx_done4(slave_rx_done4)
    );
    initial begin
        data_in_master = 10'b1010101100;
        data_in_slave1 = 10'b0011011010;
        data_in_slave2 = 10'b1011011001;
        data_in_slave3 = 10'b1010110111;
        data_in_slave4 = 10'b0001101110;
        tx_start=0;
        reset_n=0;
        #(clk_cycle);
        reset_n =1;
        tx_start=1;
        #(clk_cycle);
        tx_start=0;
        #(250*clk_cycle);
        tx_start=1;
        #(clk_cycle);
        tx_start=0;
        #(250*clk_cycle);
        tx_start=1;
        #(clk_cycle);
        tx_start=0;
        #(250*clk_cycle);
        tx_start=1;
        #(clk_cycle);
        tx_start=0;
    end
endmodule
