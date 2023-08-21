`timescale 1ns / 1ps

module whichDigit(digit0, digit1, digit2, digit3, anodeDelay, outDigit);
  input [3:0] digit0; // units
  input [3:0] digit1; // tens
  input [3:0] digit2; // hundrends
  input [3:0] digit3; // thousands
  input [3:0] anodeDelay;
  output reg [3:0] outDigit;
  
  always @(anodeDelay)
    begin 
      case (anodeDelay)
        4'b0111 : outDigit = digit3;
        4'b1011 : outDigit = digit2;
        4'b1101 : outDigit = digit1;
        4'b1110 : outDigit = digit0;
        //default : outDigit = digit0;
      endcase
    end
endmodule