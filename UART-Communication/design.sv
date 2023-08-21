`include "uart_receiver.v"
`include "uart_transmitter.v"
`include "channel.v"


`timescale 1ns / 1ps

module uart_communication(reset, clock, Rx_DATA, baud_select, Tx_DATA,Tx_WR, Tx_EN, Rx_EN, Rx_FERROR, Rx_PERROR, Rx_VALID, Tx_BUSY);
input clock, reset;
input [7:0] Tx_DATA;  
input [2:0] baud_select;
input Tx_EN, Tx_WR;
input Rx_EN;
output [7:0] Rx_DATA;
output Rx_FERROR; // Framing Error //
output Rx_PERROR; // Parity Error //
output Rx_VALID; // Rx_DATA is Valid //
output Tx_BUSY;
  
  wire TxD;
  wire RxD;
    
    
  uart_transmitter uart_transmitter_instance (.reset(reset), .clock(clock), .Tx_DATA(Tx_DATA), .baud_select(baud_select), .Tx_WR(Tx_WR), .Tx_EN(Tx_EN), .TxD(TxD), .Tx_BUSY(Tx_BUSY));
  
  channel channel_instance(.TxD(TxD), .RxD(RxD));
  
  uart_receiver uart_receiver_instance(.reset(reset), .clock(clock), .Rx_DATA(Rx_DATA), .baud_select(baud_select), .Rx_EN(Rx_EN), .RxD(RxD), .Rx_FERROR(Rx_FERROR), .Rx_PERROR(Rx_PERROR), .Rx_VALID(Rx_VALID));
  
endmodule