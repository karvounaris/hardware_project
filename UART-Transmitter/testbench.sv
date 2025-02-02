`timescale 1ns / 1ps

module testbench_UART();
  reg clock, reset;
  reg [7:0] Tx_DATA;
  reg [2:0] baud_select;
  reg Tx_EN;
  reg Tx_WR;
  
  wire TxD;
  wire Tx_BUSY;
  
  uart_transmitter UUT(
    .reset(reset), .clock(clock), .Tx_DATA(Tx_DATA), 
    .baud_select(baud_select), .Tx_WR(Tx_WR), 
    .Tx_EN(Tx_EN), .TxD(TxD), .Tx_BUSY(Tx_BUSY));
  
  
  initial 
    begin 
      $dumpfile("dump.vcd"); 
      $dumpvars;
      reset = 1;
      clock=0;
      Tx_EN = 0;
      Tx_WR = 0;
      baud_select = 3'b111;
      Tx_DATA = 8'b10101000;
      
      #10
      reset = 0; 
      #10
      reset = 1;
      
      #8680 // = Tsc (depending on baud_select)
      Tx_EN = 1;
      
      #20
      Tx_WR = 1;
      #20
      Tx_WR = 0;
      
      
      
      
      #110000
      Tx_DATA = 8'b10001000;
      Tx_WR = 1;
      #20
      Tx_WR = 0;

      
      $display("end of test");
      
      #1000000 $finish;
    end
  
  always #10 clock = ~clock; // 20nsec
  
  
  
endmodule
