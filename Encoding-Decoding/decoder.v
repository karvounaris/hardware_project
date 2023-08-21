`timescale 1ns / 1ps

module decoder(encodedData, decodedData);
  input [15:0] encodedData;
  output reg [15:0] decodedData;
  
  integer i;
  
  always @ (encodedData)
    begin 
      for (i = 0; i < 16; i = i + 1)
        begin
          decodedData[i] = encodedData[15-i];
        end
    end
  
endmodule
