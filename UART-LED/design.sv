`include "SevenSegmentDisplayDriver.v"
`include "uart_communication.v"
`include "dataToDigit.v"

`timescale 1ns / 1ps

module uart_led(reset, clock, baud_select, Tx_DATA,Tx_WR, Tx_EN, Rx_EN, anode, LEDOutput, Tx_BUSY);
  input clock, reset;
  input [7:0] Tx_DATA;  
  input [2:0] baud_select;
  input Tx_EN, Tx_WR;
  input Rx_EN;
  
  output wire Tx_BUSY;
  output wire [6:0] LEDOutput; 
  output wire[3:0] anode;
  
  wire [7:0] Rx_DATA;
  wire Rx_FERROR;
  wire Rx_PERROR;
  wire Rx_VALID;

  wire [3:0] digit0;
  wire [3:0] digit1;
  wire [3:0] digit2;
  wire [3:0] digit3;

  uart_communication uart_communication_instance(.reset(reset),.clock(clock),      .Rx_DATA(Rx_DATA), 
    .baud_select(baud_select), .Tx_DATA(Tx_DATA), .Tx_WR(Tx_WR), 
                     .Tx_EN(Tx_EN), .Rx_EN(Rx_EN), .Rx_FERROR(Rx_FERROR), .Rx_PERROR(Rx_PERROR), .Rx_VALID(Rx_VALID), .Tx_BUSY(Tx_BUSY));
  
  dataToDigit dataToDigit_instance(.Rx_DATA(Rx_DATA), .Rx_VALID(Rx_VALID), .Rx_FERROR(Rx_FERROR), .Rx_PERROR(Rx_PERROR), .digit0(digit0), .digit1(digit1), 
    .digit2(digit2), .digit3(digit3));
  
  SevenSegmentDisplayDriver SevenSegmentDisplayDriver_instance(
    .clock(clock), .reset(reset), .digit0(digit0), 
    .digit1(digit1), .digit2(digit2), 
    .digit3(digit3), .anode(anode), 
    .LEDOutput(LEDOutput));
 endmodule