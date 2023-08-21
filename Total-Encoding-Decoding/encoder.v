`timescale 1ns / 1ps

module encoder(clock, unencodedData, Tx_WR, Tx_DATA);
  input clock;
  input [15:0] unencodedData;
  input Tx_WR;
  output reg [7:0] Tx_DATA;
  
  reg [15:0] encodedData;
  
  integer i;
  integer counter = 0; 
  
  always @ (unencodedData)
    begin 
      for (i = 0; i < 16; i = i + 1)
        begin
          encodedData[i] = unencodedData[15-i];
        end
    end
  
  always @ (negedge Tx_WR)
    begin
      if (counter == 0)
        begin 
          Tx_DATA <= encodedData[15:8];
          counter <= 1;
        end
      else if (counter == 1)
        begin 
          Tx_DATA <= encodedData[7:0];
          counter <= 2;
        end
    end
  
endmodule
