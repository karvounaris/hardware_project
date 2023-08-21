`timescale 1ns / 1ps

module testbench7SegmentDisplayDriver();
  reg reset,clock;
  reg [3:0] digit0;
  reg [3:0] digit1;
  reg [3:0] digit2;
  reg [3:0] digit3;
  
  wire [3:0] anode;
  wire [6:0] LED;
  
  SevenSegmentDisplayDriver UUT(
    .clock(clock), .reset(reset), .digit0(digit0), 
    .digit1(digit1), .digit2(digit2), 
    .digit3(digit3), .anode(anode), 
    .LED(LED));
  
  initial 
    begin 
      $dumpfile("dump.vcd"); 
      $dumpvars;
      clock=0;
      digit0 = 4;
      digit1 = 9;
      digit2 = 1;
      digit3 = 10;

      reset = 1;
      #10
      reset = 0;
      #10
      reset = 1;

      
      $display("end of test");
      
      #10880 $finish;
    end
  
  always #10 clock = ~clock; // 20nsec
  
  
  
endmodule
