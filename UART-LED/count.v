`timescale 1ns / 1ps

module count (clock, reset, anode, anodeDelay);
  input clock, reset;
  output reg [3:0] anode;
  output reg [3:0] anodeDelay;

  integer count;
  reg [3:0] counter;

  always @(posedge clock or negedge reset)
      begin 
        if (reset == 0)
          count <= 0;
        else if (count == 15)
          count <= 0;       
       
        else 
          count <= count +1;
      end
  
  always @(posedge clock or negedge reset)
    begin 
      if (reset == 0)
        counter <= 0;
      else if (counter == 15)
        counter <= 0;       
      else if (count == 15)
        counter <= counter +1;
    end

  always @(counter or negedge reset)
      begin 
        if (reset == 0)
          anodeDelay = 4'b1111;
        else
          begin 
            case (counter)
              4'b1110 : anodeDelay = 4'b0111;
              4'b1010 : anodeDelay = 4'b1011;
              4'b0110 : anodeDelay = 4'b1101;
              4'b0010 : anodeDelay = 4'b1110;
              default : anodeDelay = 4'b1111;
 			endcase
          end
      end

  always @(counter or negedge reset)
     begin 
        if (reset == 0)
          anode = 4'b1111;
        else
          begin 
            case (counter)
              4'b0000 : anode = 4'b0111;
              4'b1100 : anode = 4'b1011;
              4'b1000 : anode = 4'b1101;
              4'b0100 : anode = 4'b1110;
              default : anode = 4'b1111;
 			endcase
          end
      end

endmodule
  