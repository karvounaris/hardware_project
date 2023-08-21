`timescale 1ns / 1ps

module channel (TxD, RxD);
  input TxD;
  output reg RxD;
  
  always @ (TxD)
    begin
      RxD <= TxD;
    end
  
endmodule
