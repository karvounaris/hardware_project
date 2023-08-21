`timescale 1ns / 1ps

module encoder(unencodedData, encodedData);
  input [15:0] unencodedData;
  output reg [15:0] encodedData;
  
  integer i;
  
  always @ (unencodedData)
    begin 
      for (i = 0; i < 16; i = i + 1)
        begin
          encodedData[i] = unencodedData[15-i];
        end
    end
  
endmodule
