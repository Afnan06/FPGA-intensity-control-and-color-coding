`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2022 01:44:01 PM
// Design Name: 
// Module Name: dsd_CEP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dsd_CEP(input clk,  
    input reset,
    input[8:0]sw1,
    output reg[8:0] led1,
    output reg [7:0] SSEG_CA,
    output reg [7:0] SSEG_AN,
    output reg R,
    output reg G,
    output reg B
    );
       
    wire [18:0] count_out;
    reg [7:0] duty_cycle;
    wire Pwm_out;
    reg [3:0] seg;
    reg [3:0] first;
    reg [3:0] second;
    reg [3:0] third;
    reg [3:0] fourth;
    reg [3:0] fifth;
    reg [7:0] number;
    reg sign;
    
  counter S1 (clk, reset, count_out);
  PWM P1(.clk(clk),.duty_cycle(duty_cycle) ,.PWM_out(Pwm_out));
// to select which 7 segment

    always@(posedge clk)
    begin
    case({count_out[18],count_out[17],count_out[16]})
    3'b000: begin
    SSEG_AN<=8'b11111110;
    seg<=fifth;
    end
    3'b001: begin
    SSEG_AN<=8'b11111101;
    seg<=fourth;
    end
    3'b010: begin
    SSEG_AN<=8'b11111011;
    seg<=third;
    end
    3'b011: begin
    SSEG_AN<=8'b11110111;
    seg<=second;//
    end
    3'b100: begin
    SSEG_AN<=8'b11101111;
    seg<=first;//-
    end
    endcase 
    led1 <= sw1;
    fifth=4'b1011;
    fourth=4'b1010;
    if (sw1[8]==0)   first=4'b1110;
    else          first=4'b1111;
//to select what to display on 7 segment based on input
    case (seg)
        4'b0000: SSEG_CA <= 8'b11000000;
        4'b0001: SSEG_CA <= 8'b11111001;
        4'b0010: SSEG_CA <= 8'b10100100;
        4'b0011: SSEG_CA <= 8'b10110000;
        4'b0100: SSEG_CA <= 8'b10011001;
        4'b0101: SSEG_CA <= 8'b10010010;
        4'b0110: SSEG_CA <= 8'b10000010;
        4'b0111: SSEG_CA <= 8'b11011000;
        4'b1000: SSEG_CA <= 8'b10000000;
        4'b1001: SSEG_CA <= 8'b10011000;
        
        //sign
        4'b1110: SSEG_CA <= 8'b11111111;//third
        4'b1111: SSEG_CA <= 8'b10111111;//third
        
        4'b1010: SSEG_CA <= 8'b11111101;//degree
        4'b1011: SSEG_CA <= 8'b11000110;//C 
       endcase

        //this case is for selecting what to display in  the decimal of switch input(in binary)
        case(sw1[7:0])
        //0-10
        8'b00000000: begin second=4'b0000;  third=4'b0000; end
        8'b00000001: begin second=4'b0000;  third=4'b0001; end
        8'b00000010: begin second=4'b0000;  third=4'b0010; end
        8'b00000011: begin second=4'b0000;  third=4'b0011; end
        8'b00000100: begin second=4'b0000;  third=4'b0100; end
        8'b00000101: begin second=4'b0000;  third=4'b0101; end
        8'b00000110: begin second=4'b0000;  third=4'b0110; end
        8'b00000111: begin second=4'b0000;  third=4'b0111; end
        8'b00001000: begin second=4'b0000;  third=4'b1000; end
        8'b00001001: begin second=4'b0000;  third=4'b1001; end
        8'b00001010: begin second=4'b0001;  third=4'b0000; end 
        //11-20
        8'b00001011: begin second=4'b0001;  third=4'b0001; end
        8'b00001100: begin second=4'b0001;  third=4'b0010; end
        8'b00001101: begin second=4'b0001;  third=4'b0011; end
        8'b00001110: begin second=4'b0001;  third=4'b0100; end
        8'b00001111: begin second=4'b0001;  third=4'b0101; end
        8'b00010000: begin second=4'b0001;  third=4'b0110; end
        8'b00010001: begin second=4'b0001;  third=4'b0111; end
        8'b00010010: begin second=4'b0001;  third=4'b1000; end
        8'b00010011: begin second=4'b0001;  third=4'b1001; end
        8'b00010100: begin second=4'b0010;  third=4'b0000; end 
        //20-30
        8'b00010101: begin second=4'b0010;  third=4'b0001; end
        8'b00010110: begin second=4'b0010;  third=4'b0010; end
        8'b00010111: begin second=4'b0010;  third=4'b0011; end
        8'b00011000: begin second=4'b0010;  third=4'b0100; end
        8'b00011001: begin second=4'b0010;  third=4'b0101; end
        8'b00011010: begin second=4'b0010;  third=4'b0110; end
        8'b00011011: begin second=4'b0010;  third=4'b0111; end
        8'b00011100: begin second=4'b0010;  third=4'b1000; end
        8'b00011101: begin second=4'b0010;  third=4'b1001; end
        8'b00011110: begin second=4'b0011;  third=4'b0000; end 
        //30-40
        8'b00011111: begin second=4'b0011;  third=4'b0001; end
        8'b00100000: begin second=4'b0011;  third=4'b0010; end
        8'b00100001: begin second=4'b0011;  third=4'b0011; end
        8'b00100010: begin second=4'b0011;  third=4'b0100; end
        8'b00100011: begin second=4'b0011;  third=4'b0101; end
        8'b00100100: begin second=4'b0011;  third=4'b0110; end
        8'b00100101: begin second=4'b0011;  third=4'b0111; end
        8'b00100110: begin second=4'b0011;  third=4'b1000; end
        8'b00100111: begin second=4'b0011;  third=4'b1001; end
        8'b00101000: begin second=4'b0100;  third=4'b0000; end 
        //40-50
        8'b00101001: begin second=4'b0100;  third=4'b0001; end
        8'b00101010: begin second=4'b0100;  third=4'b0010; end
        8'b00101011: begin second=4'b0100;  third=4'b0011; end
        8'b00101100: begin second=4'b0100;  third=4'b0100; end
        8'b00101101: begin second=4'b0100;  third=4'b0101; end
        8'b00101110: begin second=4'b0100;  third=4'b0110; end
        8'b00101111: begin second=4'b0100;  third=4'b0111; end
        8'b00110000: begin second=4'b0100;  third=4'b1000; end
        8'b00110001: begin second=4'b0100;  third=4'b1001; end
        8'b00110010: begin second=4'b0101;  third=4'b0000; end 
        //50-60
        8'b00110011: begin second=4'b0101;  third=4'b0001; end
        8'b00110100: begin second=4'b0101;  third=4'b0010; end
        8'b00110101: begin second=4'b0101;  third=4'b0011; end
        8'b00110110: begin second=4'b0101;  third=4'b0100; end
        8'b00110111: begin second=4'b0101;  third=4'b0101; end
        8'b00111000: begin second=4'b0101;  third=4'b0110; end
        8'b00111001: begin second=4'b0101;  third=4'b0111; end
        8'b00111010: begin second=4'b0101;  third=4'b1000; end
        8'b00111011: begin second=4'b0101;  third=4'b1001; end
        8'b00111100: begin second=4'b0110;  third=4'b0000; end 
        //60-70
        8'b00111101: begin second=4'b0110;  third=4'b0001; end
        8'b00111110: begin second=4'b0110;  third=4'b0010; end
        8'b00111111: begin second=4'b0110;  third=4'b0011; end
        8'b01000000: begin second=4'b0110;  third=4'b0100; end
        8'b01000001: begin second=4'b0110;  third=4'b0101; end
        8'b01000010: begin second=4'b0110;  third=4'b0110; end
        8'b01000011: begin second=4'b0110;  third=4'b0111; end
        8'b01000100: begin second=4'b0110;  third=4'b1000; end
        8'b01000101: begin second=4'b0110;  third=4'b1001; end
        8'b01000110: begin second=4'b0111;  third=4'b0000; end
        //70-80
        8'b01000111: begin second=4'b0111;  third=4'b0001; end
        8'b01001000: begin second=4'b0111;  third=4'b0010; end
        8'b01001001: begin second=4'b0111;  third=4'b0011; end
        8'b01001010: begin second=4'b0111;  third=4'b0100; end
        8'b01001011: begin second=4'b0111;  third=4'b0101; end
        8'b01001100: begin second=4'b0111;  third=4'b0110; end
        8'b01001101: begin second=4'b0111;  third=4'b0111; end
        8'b01001110: begin second=4'b0111;  third=4'b1000; end
        8'b01001111: begin second=4'b0111;  third=4'b1001; end
        8'b01010000: begin second=4'b1000;  third=4'b0000; end
        //80-90
        8'b01010001: begin second=4'b1000;  third=4'b0001; end
        8'b01010010: begin second=4'b1000;  third=4'b0010; end
        8'b01010011: begin second=4'b1000;  third=4'b0011; end
        8'b01010100: begin second=4'b1000;  third=4'b0100; end
        8'b01010101: begin second=4'b1000;  third=4'b0101; end
        8'b01010110: begin second=4'b1000;  third=4'b0110; end
        8'b01010111: begin second=4'b1000;  third=4'b0111; end
        8'b01011000: begin second=4'b1000;  third=4'b1000; end
        8'b01011001: begin second=4'b1000;  third=4'b1001; end
        8'b01011010: begin second=4'b1001;  third=4'b0000; end
        //90-99
        8'b01011011: begin second=4'b1001;  third=4'b0001; end
        8'b01011100: begin second=4'b1001;  third=4'b0010; end
        8'b01011101: begin second=4'b1001;  third=4'b0011; end
        8'b01011110: begin second=4'b1001;  third=4'b0100; end
        8'b01011111: begin second=4'b1001;  third=4'b0101; end
        8'b01100000: begin second=4'b1001;  third=4'b0110; end
        8'b01100001: begin second=4'b1001;  third=4'b0111; end
        8'b01100010: begin second=4'b1001;  third=4'b1000; end
        8'b01100011: begin second=4'b1001;  third=4'b1001; end
        default:begin second=4'b1111;  third=4'b1111; end
        endcase
  end 
    always@(posedge clk)
    begin
    number = sw1[7:0];
    sign=sw1[8];
    if (sign==1 )
    begin
        if (number>8'd0 & number <8'd20)
        begin
        duty_cycle<=number+2;
            //blue color
         G=0; R=0; B=Pwm_out;
        end

        else if (number>=8'd20 & number <8'd40)
        begin
        //white color
        duty_cycle<=number-18;
         G=Pwm_out; B=Pwm_out; R=Pwm_out;
        end
    end

    else if (number>=8'd0 & number <8'd20)
    begin
    duty_cycle<=number+2;
    //cyan colo
    begin G<=Pwm_out; R=0; B<=Pwm_out;end
    end

    else if (number>=8'd20 & number <8'd40)
    begin
    duty_cycle<=number-18;
    //yellow color
    begin G=Pwm_out; B=0; R=Pwm_out;end
    end

    else if (number>=8'd40 & number <8'd60)
    begin
    duty_cycle<=number-38;
    //green color
    begin R=0; G=Pwm_out; B=0;end
    end

    else if (number>=8'd60 & number <8'd80 )
    begin
    duty_cycle<=number-58;
    //magenta color
     R=Pwm_out; G=0; B=Pwm_out;
    end
    
    else if (number>=8'd80 )
    begin
    duty_cycle<=number-78;
    //red color
     G=0; R=Pwm_out; B=0;
    end
  end
endmodule



module counter(input clk,input reset,output reg [18:0] count_out);
always@(posedge clk or posedge reset)
begin
if(reset)
count_out<=0;
else
count_out=count_out+1;
end
endmodule

