`timescale 1ns / 1ps

module testbenchEncoder();
  reg [15:0] unencodedData; 
  wire [15:0] decodedData;

  encoding_decoding UUT(
    .unencodedData(unencodedData),
    .decodedData(decodedData));
  
  initial
    begin 
      $dumpfile("dump.vcd"); 
      $dumpvars;
	  unencodedData = 16'b1100111010001010;
      
      $display("end of test");
      
      #10880 $finish;
    end
  
endmodule
