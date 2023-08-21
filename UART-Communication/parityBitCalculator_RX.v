`timescale 1ns / 1ps

module parityBitCalculator_RX (data, parityBit);
  input [7:0] data;
  output reg parityBit;
  
  integer i, counter;
  
  always @ (data)
    begin 
      counter = 0;
      if (data[0] == 1)
        counter = counter + 1;
      if (data[1] == 1)
        counter = counter + 1;
      if (data[2] == 1)
        counter = counter + 1;
      if (data[3] == 1)
        counter = counter + 1;
      if (data[4] == 1)
        counter = counter + 1;
      if (data[5] == 1)
        counter = counter + 1;
      if (data[6] == 1)
        counter = counter + 1;
      if (data[7] == 1)
        counter = counter + 1;
      if (counter % 2 == 0)
        parityBit <= 0;
      else 
        parityBit <= 1;
    end
 
endmodule