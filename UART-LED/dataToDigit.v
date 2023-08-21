`timescale 1ns / 1ps

module dataToDigit(Rx_DATA, Rx_VALID, Rx_FERROR, Rx_PERROR, digit0, digit1, digit2, digit3);
  input [7:0] Rx_DATA;
  input Rx_VALID;
  input Rx_FERROR;
  input Rx_PERROR;
  
  output reg[3:0] digit0 = 4'b1011;
  output reg[3:0] digit1 = 4'b1011;
  output reg[3:0] digit2 = 4'b1011;
  output reg[3:0] digit3 = 4'b1011;
  
  reg [15:0] bitStorage;
  integer counter = 0;
  integer delay = 0;
  
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
          digit0 <= bitStorage[3:0];
          digit1 <= bitStorage[7:4];
          digit2 <= bitStorage[11:8];
          digit3 <= bitStorage[15:12];
        end
    end
endmodule