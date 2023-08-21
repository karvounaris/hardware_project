`timescale 1ns / 1ps

module transmission (finalBitSequence, Tx_sample_ENABLE, Tx_WR, TxD, Tx_BUSY);
  input [10:0] finalBitSequence;
  input Tx_sample_ENABLE, Tx_WR;
  output reg TxD;
  output reg Tx_BUSY;
  
  integer i;
  
  always @ (posedge Tx_sample_ENABLE)
    begin
      i = i + 1;
      if (i == 0)
        Tx_BUSY <= 1;
      TxD <= finalBitSequence[i];
      if (i == 11)
        begin 
          Tx_BUSY <= 0;
        end
      if (i>10)
         TxD <= 1;
    end
  
  always @ (posedge Tx_WR)
    begin
      i <= 0;
    end
  
  always @ (finalBitSequence)
    begin
      i <= -1;
    end
 
endmodule