 `timescale 1ns / 1ps

module PErrorDetection(inputParityBit, parityBit, Rx_PERROR);
  input inputParityBit;
  input parityBit;
  output reg Rx_PERROR;
  
  always @ (inputParityBit or parityBit)
    begin
      if (inputParityBit == parityBit)
        Rx_PERROR = 0;
      else
        Rx_PERROR = 1;
    end
  
endmodule