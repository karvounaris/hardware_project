`timescale 1ns / 1ps

module LEDDecoder(char, LEDOutput);
  input [3:0] char; //0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -, F, κενό
  output reg [6:0] LEDOutput; // A,B,C,D,E,F,G
  
  always @ (char)
  begin 
    case (char)
      4'b0000 : LEDOutput = 7'b1111110; // 0     
      4'b0001 : LEDOutput = 7'b0110000;     
      4'b0010 : LEDOutput = 7'b1101101;     
      4'b0011 : LEDOutput = 7'b1111001;      
      4'b0100 : LEDOutput = 7'b0110011; // ...      
      4'b0101 : LEDOutput = 7'b1011011;     
      4'b0110 : LEDOutput = 7'b1011111;     
      4'b0111 : LEDOutput = 7'b1110000;     
      4'b1000 : LEDOutput = 7'b1111111;      
      4'b1001 : LEDOutput = 7'b1111011; // 9    
      4'b1010 : LEDOutput = 7'b0000001; // "-" = 10      
      4'b1011 : LEDOutput = 7'b0000000; // null = 11
      default : LEDOutput = 7'b1000111; // F in any other case
    endcase
  end
endmodule