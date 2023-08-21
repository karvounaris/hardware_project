`timescale 1ns / 1ps

module reception (Rx_EN, RxD, Rx_sample_ENABLE, finalReceivedBitSequence, Rx_valid, Rx_FERROR);
  input Rx_EN;
  input RxD;
  input Rx_sample_ENABLE;
  output reg [10:0] finalReceivedBitSequence = 11'b00000000000;
  output reg Rx_valid = 0;
  output reg Rx_FERROR;
  
  integer counter = 0;
  integer i = -1;
  reg [3:0] onesCounter;
  reg [10:0] receivedBitSequence = 11'bzzzzzzzzzzz;
  reg Rx_ferror;
  
  always @ (posedge Rx_EN)
    begin 
      i <= i + 1;
    end
  
  always @ (posedge Rx_sample_ENABLE)
    begin
      if (Rx_EN)
        begin
      	  if (counter == 15)
            begin
              counter <= 0;
              i <= i + 1;
            end
          else
            begin
              counter <= counter + 1;
            end
        end
    end
  
  always @ (counter)
    begin
      onesCounter <= 0;
      //don't care about the first values of deigmatolipsia
      if (counter != 0)
        begin
          if (RxD == 1)
            onesCounter <= onesCounter + 1;
          if (counter == 15)
            begin 
              //use democracy for the received bit
              if (onesCounter >= 8)
                receivedBitSequence[i] <= 1;
              else
                receivedBitSequence[i] <= 0;
            end
      end
      
      if (i == 11)
          i <= 0;
      else if ( i == 0 && RxD == 1)
        i <= i - 1;
        
    end
  
  always @ (i)
    begin
      if(onesCounter != 15 && onesCounter != 0)
        Rx_ferror = 1;
      if (i == 10 && counter == 15)
        begin
          if (receivedBitSequence[10] == 0)
            Rx_ferror = 1;
          if (receivedBitSequence[0] == 1)
            Rx_ferror = 1;
        end
      if (i == 0 && counter == 0)
        begin
          finalReceivedBitSequence = receivedBitSequence;
          if (finalReceivedBitSequence != 11'b00000000000)
        	Rx_valid = 1;
          Rx_FERROR <= Rx_ferror;
          Rx_ferror <= 0;
        end
    end
  
endmodule