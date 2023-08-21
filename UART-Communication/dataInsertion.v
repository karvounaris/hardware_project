`timescale 1ns / 1ps

module dataInsertion (Tx_EN, Tx_Data, Tx_WR, data);
  input Tx_EN;
  input [7:0] Tx_Data;
  input Tx_WR;
  output reg [7:0] data;
  
  always @ (posedge Tx_WR )
    begin
      if (Tx_EN == 1)
        data <= Tx_Data;
    end
 
endmodule
