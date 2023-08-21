`timescale 1ns / 1ps

module testbench_UART_LED();
  reg reset,clock;
  reg [3:0] digit0;
  reg [3:0] digit1;
  reg [3:0] digit2;
  reg [3:0] digit3;
  
  wire [3:0] anode;
  wire [6:0] LEDOutput;
  wire Tx_BUSY;
  
  reg [7:0] Tx_DATA;
  reg [2:0] baud_select;
  reg Tx_EN;
  reg Rx_EN;
  reg Tx_WR;
  
  
  uart_led UUT(.reset(reset), .clock(clock),  
               .baud_select(baud_select), .Tx_DATA(Tx_DATA), 
               .Tx_WR(Tx_WR), 
    .Tx_EN(Tx_EN), .Rx_EN(Rx_EN),.anode(anode), 
           .LEDOutput(LEDOutput), .Tx_BUSY(Tx_BUSY));
  
  
  initial 
    begin 
      $dumpfile("dump.vcd"); 
      $dumpvars;
      reset = 1;
      clock=0;
      Tx_EN = 0;
      Rx_EN = 0;
      Tx_WR = 0;
      baud_select = 3'b111;
      Tx_DATA = 8'b10101000;
      
      #10
      reset = 0; 
      #10
      reset = 1;
      
      #8680 // = Tsc (depending on baud_select)
      //#8080
      Tx_EN = 1;
      Rx_EN = 1;
      
      #20
      Tx_WR = 1;
      #20
      Tx_WR = 0;
      
      #104130
      Tx_DATA = 8'b00010111;
      Tx_WR = 1;
      #20
      Tx_WR = 0;

      $display("end of test");
      
      #1000000 $finish;
    end
  
  always #10 clock = ~clock; // 20nsec
  
  
  
endmodule
