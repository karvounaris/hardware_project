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
        //max_counter= Tsc/20  (Tsc = 1/16*baud_rate)
        300    : max_counter = 10416; // round on integer 
        //max_counter = 10416.5 Tsc = 0.00020833 
        1200   : max_counter = 2604; // round on integer
        //max_counter = 2604 Tsc = 0.00005208 
        4800   : max_counter = 651; // round on integer
        //max_counter = 651 Tsc = 0.00001302    
        9600   : max_counter = 325; // round on integer
        //max_counter = 325.5 Tsc = 0.00000651
        19200  : max_counter = 163; // round on integer
        //max_counter = 163 Tsc = 0.00000326
        38400  : max_counter = 81; // round on integer
        //max_counter = 81.5 Tsc = 0.00000163
        57600  : max_counter = 54; // round on integer
        //max_counter = 54.5 Tsc = 0.00000109
        115200 : max_counter = 27; // round on integer
        //max_counter = 27 Tsc = 0.00000054
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
        else if (counter == max_counter -1)
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