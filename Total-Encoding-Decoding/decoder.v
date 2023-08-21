`timescale 1ns / 1ps

module decoder(Rx_DATA, Rx_VALID, Rx_FERROR, Rx_PERROR, digit0, digit1, digit2, digit3);
  input [7:0] Rx_DATA;
  input Rx_VALID;
  input Rx_FERROR;
  input Rx_PERROR;
  
  output reg[3:0] digit0 = 4'b1011;
  output reg[3:0] digit1 = 4'b1011;
  output reg[3:0] digit2 = 4'b1011;
  output reg[3:0] digit3 = 4'b1011;
  
  reg [15:0] bitStorage;
  reg [15:0] decodedData;
  integer counter = 0;
  integer delay = 0;
  integer i;
  
  always @ (Rx_DATA)
    begin
      delay <= delay + 1;
    end
  
  always @ (delay)
    begin
     if (Rx_VALID == 0)
        begin
          bitStorage[15:0] <= 16'b1111111111111111;
          counter <= 0;
        end 
      else if (counter == 0)
        begin
          bitStorage[15:8] <= Rx_DATA;
          counter <= 1;
        end
      else if (counter == 1)
        begin
          bitStorage[7:0] <= Rx_DATA;
          counter <= 0;
        end
    end
  
  always @ (bitStorage)
    begin 
      if (counter == 0)
        begin
          for (i = 0; i < 16; i = i + 1)
            begin
              decodedData[i] = bitStorage[15-i];
           	end
    	end
    end
      
      
  always @ (decodedData)
    begin
      digit0 <= decodedData[3:0];
      digit1 <= decodedData[7:4];
      digit2 <= decodedData[11:8];
      digit3 <= decodedData[15:12];
    end
endmodule