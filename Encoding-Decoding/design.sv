`include "encoder.v"
`include "decoder.v"
`timescale 1ns / 1ps

module encoding_decoding(unencodedData, decodedData);
  input [15:0] unencodedData;
  output [15:0] decodedData;
  
  wire [15:0] encodedData;
  
  encoder encoder_instance(.unencodedData(unencodedData), .encodedData(encodedData));
  
  decoder decoder_instance(.encodedData(encodedData), .decodedData(decodedData));
  
endmodule