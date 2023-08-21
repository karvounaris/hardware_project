`timescale 1ns / 1ps

module testbench_UART();
  reg reset,clock;
  reg [2:0] baud_select;
  reg Rx_EN;
  reg RxD;
  
  wire [7:0] Rx_DATA;
  wire  Rx_FERROR;
  wire  Rx_PERROR;
  wire  Rx_VALID;
  
  uart_receiver UUT(
    .reset(reset), .clock(clock), .Rx_DATA(Rx_DATA), 
    .baud_select(baud_select), .Rx_EN(Rx_EN), 
    .RxD(RxD), .Rx_FERROR(Rx_FERROR), 
    .Rx_PERROR(Rx_PERROR), .Rx_VALID(Rx_VALID));
  
   initial 
    begin 
      $dumpfile("dump.vcd"); 
      $dumpvars;
      reset = 1;
      clock=0;
      Rx_EN = 0;
      baud_select = 3'b111;
      
      #10
      reset = 0; 
      #10
      reset = 1;
      
      #540 // = Tsc (depending on baud_select)
      Rx_EN = 1;
      RxD = 1;
      
      #8110
      RxD = 0;
      #8680
      RxD = 1;
      #8680
      RxD = 0;
      #8680
      RxD = 1;
      #8680
      RxD = 0;
      #8680
      RxD = 1;
      #8680
      RxD = 0;
      #8680
      RxD = 0;
      #8680
      RxD = 0;
      #8680
      RxD = 1;
      #8680
      RxD = 1;
      
      //New 8 bit sequence
      #8680
      RxD = 0;
      #8680
      RxD = 1;
      #8680
      RxD = 0;
      #8680
      RxD = 0;
      #8680
      RxD = 0;
      #8680
      RxD = 1;
      #8680
      RxD = 0;
      #8680
      RxD = 0;
      #8680
      RxD = 0;
      #8680
      RxD = 0;
      #8680
      RxD = 1;
      
      $display("end of test");
      
      #100000 $finish;
    end
  
  always #10 clock = ~clock; // 20nsec
  
  
endmodule
