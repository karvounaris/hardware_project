`timescale 1ns / 1ps

module inputBitSequence(finalReceivedBitSequence, data, inputParityBit);
  input [10:0] finalReceivedBitSequence;
  output reg [7:0] data;
  output reg inputParityBit;
  
  always @ (finalReceivedBitSequence)
    begin 
      inputParityBit = finalReceivedBitSequence[9];
      data = finalReceivedBitSequence[8:1];
    end
  
endmodule
