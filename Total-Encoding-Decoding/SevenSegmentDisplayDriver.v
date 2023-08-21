`include "count.v"
`include "whichDigit.v"
`include "LEDDecoder.v"

`timescale 1ns / 1ps

module SevenSegmentDisplayDriver(clock, reset, digit0, digit1, digit2, digit3, anode, LEDOutput);
  input clock, reset;
  input [3:0] digit0; 
  input [3:0] digit1; 
  input [3:0] digit2; 
  input [3:0] digit3; 
  
  output wire [6:0] LEDOutput; 
  output wire[3:0] anode;

  wire [3:0] anodeDelay;
  wire [3:0] outDigit;

  count COUNT(
    .clock(clock), .reset(reset), 
    .anode(anode), 
    .anodeDelay(anodeDelay));  
  
  whichDigit WDIGIT (
    .digit0(digit0), .digit1(digit1), 
    .digit2(digit2), .digit3(digit3), 
    .anodeDelay(anodeDelay), .outDigit(outDigit));
  
  LEDDecoder LEDDEC (
    .char(outDigit), .LEDOutput(LEDOutput));

endmodule
