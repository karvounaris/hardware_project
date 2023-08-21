`timescale 1ns / 1ps

module baud_controller(reset, clock, baud_select, sample_ENABLE);
  input clock, reset;
  input [2:0] baud_select;
  output reg sample_ENABLE;
  
  integer counter, max_counter, baud_rate;
  
  always @ (baud_select)
    begin 
      case (baud_select)
        3'b000 : baud_rate = 300; 
        3'b001 : baud_rate = 1200;     
        3'b010 : baud_rate = 4800;     
        3'b011 : baud_rate = 9600;      
        3'b100 : baud_rate = 19200; 
        3'b101 : baud_rate = 38400;     
        3'b110 : baud_rate = 57600;     
        3'b111 : baud_rate = 115200;
        default : baud_rate = 0;
      endcase
    end
  
  always @ (baud_rate)
    begin
      case (baud_rate)
        //max_counter= Tsc/20  (Tsc = 1/baud_rate)
        300    : max_counter = 166666; // round on integer 
        //max_counter = 166666.65 Tsc = 0.003333333 
        1200   : max_counter = 41666; // round on integer
        //max_counter = 41666.65 Tsc = 0.000833333 
        4800   : max_counter = 10416; // round on integer
        //max_counter = 10416.65 Tsc = 0.000208333    
        9600   : max_counter = 5208; // round on integer
        //max_counter = 5208.5 Tsc = 0.000104170
        19200  : max_counter = 2604; // round on integer
        //max_counter = 2604.15 Tsc = 0.000052083
        38400  : max_counter = 1302; // round on integer
        //max_counter = 1302.05 Tsc = 0.000026041
        57600  : max_counter = 868; // round on integer
        //max_counter = 868.05 Tsc = 0.000017361
        115200 : max_counter = 434; // round on integer
        //max_counter = 434 Tsc = 0.000008680
        default : max_counter = 0;
      endcase
    end
  
  always @(posedge clock or negedge reset)
      begin 
        if (reset == 0)
          begin
            counter <= 0;
            sample_ENABLE <= 0;
          end
        else if (counter == max_counter)
          begin
            sample_ENABLE <= 1;
            counter <= 0;
          end
        else if (counter == 0)
          begin
            sample_ENABLE <= 0;
            counter <= counter + 1;
          end
        else
          counter <= counter + 1;
      end
  
  
endmodule