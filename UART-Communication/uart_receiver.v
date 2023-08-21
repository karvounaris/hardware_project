`include "baud_controller_rec.v"
`include "parityBitCalculator_RX.v"
`include "reception.v"
`include "inputBitSequence.v"
`include "PErrorDetection.v"
`include "dataOutput.v"

`timescale 1ns / 1ps

module uart_receiver(reset, clock, Rx_DATA, baud_select, Rx_EN, RxD, Rx_FERROR, Rx_PERROR, Rx_VALID);
input clock, reset;
input [2:0] baud_select;
input Rx_EN;
input RxD;
output [7:0] Rx_DATA;
output Rx_FERROR; // Framing Error //
output Rx_PERROR; // Parity Error //
output Rx_VALID; // Rx_DATA is Valid //
    
  wire Rx_sample_ENABLE;
  wire [10:0] finalReceivedBitSequence;
  wire Rx_valid;
  wire [7:0] data;
  wire inputParityBit;
  wire parityBit;
    
  baud_controller baud_controller_rx_instance(.reset(reset), .clock(clock),          	.baud_select(baud_select), .sample_ENABLE(Rx_sample_ENABLE));
  
  reception receprion_instance(.Rx_EN(Rx_EN), .RxD(RxD), .Rx_sample_ENABLE(Rx_sample_ENABLE), .finalReceivedBitSequence(finalReceivedBitSequence), .Rx_valid(Rx_valid), .Rx_FERROR(Rx_FERROR));
  
  inputBitSequence input_Bit_Sequence_instance(.finalReceivedBitSequence(finalReceivedBitSequence), .data(data), .inputParityBit(inputParityBit));
  
  parityBitCalculator_RX parity_Bit_Calculator_RX_instance(.data(data), .parityBit(parityBit));
  
  PErrorDetection PErrorDetection_instance(.inputParityBit(inputParityBit), .parityBit(parityBit), .Rx_PERROR(Rx_PERROR));
  
  dataOutput dataOutput_instance (
    .Rx_PERROR(Rx_PERROR), .Rx_FERROR(Rx_FERROR), 
    .data(data), .Rx_valid(Rx_valid), .Rx_DATA(Rx_DATA), .Rx_VALID(Rx_VALID));
 
  
endmodule