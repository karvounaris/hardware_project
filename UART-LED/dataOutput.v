`timescale 1ns / 1ps

module dataOutput (Rx_PERROR, Rx_FERROR, data, Rx_valid, Rx_DATA, Rx_VALID);
  input Rx_PERROR;
  input Rx_FERROR;
  input Rx_valid;
  input [7:0] data;
  output reg [7:0] Rx_DATA;
  output reg Rx_VALID;
  
  always @ (Rx_PERROR or Rx_FERROR or Rx_valid)
    begin 
      if (~Rx_PERROR & ~Rx_FERROR & Rx_valid)
        Rx_VALID <= 1;
      else 
        Rx_VALID <= 0;
    end
  
  always @ (data)
    begin
      Rx_DATA <= data;
    end
 
endmodule
