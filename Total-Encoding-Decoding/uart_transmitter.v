`include "baud_controller_trans.v"
`include "dataInsertion.v"
`include "transmission.v"
`include "outputBitSequence.v"

`timescale 1ns / 1ps

module uart_transmitter(reset, clock, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);
  input clock, reset;
  input [7:0] Tx_DATA;
  input [2:0] baud_select;
  input Tx_EN;
  input Tx_WR;
  output wire TxD;
  output wire Tx_BUSY;
    
  wire Tx_sample_ENABLE;
  wire [7:0] data;
  wire parityBit;
  wire [10:0] finalBitSequence;
  
  
  baud_controller_trans baud_controller_Tx_instance(
    .reset(reset), .clock(clock),          
    .baud_select(baud_select), .sample_ENABLE(Tx_sample_ENABLE));
      
  dataInsertion data_Insertion_instance(
    .Tx_EN(Tx_EN), .Tx_Data(Tx_DATA),                         
    .Tx_WR(Tx_WR), .data(data));

  outputBitSequence output_Bit_Sequence_instance(.data(data), .finalBitSequence(finalBitSequence));

  transmission transmission_instance(
    .finalBitSequence(finalBitSequence),           
    .Tx_sample_ENABLE(Tx_sample_ENABLE), 
    .TxD(TxD), .Tx_WR(Tx_WR), 
    .Tx_BUSY(Tx_BUSY));

  
  
endmodule