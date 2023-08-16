`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 02:53:07 PM
// Design Name: 
// Module Name: SPI_Master
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


module SPI_Slave #(parameter mode=2'b00,bits_size=8)(
    input clk,reset_n,
    input [bits_size-1:0] data_in,
    output [bits_size-1:0] data_out,
    output tx_done,
    input MOSI,
    output reg MISO,
    input ss,
    input SCLK,
    output rx_done
    );
    wire Trailling_edge,Leading_edge,pe,ne;
    wire CPOL = mode==2'b10 || mode==2'b11;
    reg [bits_size-1:0] data_out1;
    reg sig;
    reg tx_done1,rx_done1,ignore_first_edge;
    wire CPHA = mode==2'b01 || mode==2'b11;
    reg [$clog2(bits_size)-1:0] bit_number,rx_bit_number;
    reg last_bit;
    reg state;
    always @(posedge clk) begin
        sig <= SCLK;
    end
    assign pe = ~sig & SCLK;
    assign ne = sig & ~SCLK;
    assign Trailling_edge = CPOL ? pe :ne;
    assign Leading_edge = CPOL ? ne : pe;
    //Transmitter
    always @(posedge clk,negedge reset_n) begin
        if(~reset_n) begin
            MISO <=0;
            data_out1 <= 0;
            last_bit <=0;
            tx_done1 <=0;
            rx_done1 <= 0;
            ignore_first_edge <=0;
            bit_number <= bits_size-1;
            rx_bit_number <= bits_size-1;
            state <= 0;
        end
        else begin
            case(state)
                0: begin
                    last_bit <=0;
                    bit_number <= bits_size-1;
                    rx_bit_number <= bits_size-1;
                    ignore_first_edge <=0;
                    if(~ss) begin
                        tx_done1 <=0;
                        data_out1 <= 0;
                        rx_done1 <= 0;
                        state <=1;
                        MISO <= data_in[bit_number];
                        bit_number <= bit_number-1;
                    end
                    else MISO <= data_in[bits_size-1];
                end
                1: begin
                    if((~CPHA && Trailling_edge) || (CPHA && Leading_edge) ) begin
                        if(CPHA && ~ignore_first_edge)
                            ignore_first_edge <=1;
                        else begin
                            MISO <= data_in[bit_number];
                            if(bit_number == 0) begin
                                if(last_bit) begin
                                    state <=0;
                                    tx_done1 <=1;
                                    rx_done1 <= 1;
                                end
                                last_bit <=1;
                        end
                        else bit_number <= bit_number-1;
                        end
                    end
                    if( (~CPHA && Leading_edge) || (CPHA && Trailling_edge) ) begin
                        data_out1[rx_bit_number] <= MOSI;
                        rx_bit_number <= rx_bit_number-1;
                    end
                end
            endcase
        end
    end
    assign tx_done = (state==0 && tx_done1);
    assign rx_done = (state==0 && rx_done1);
    assign data_out = state==0 ? data_out1 : 0;
endmodule