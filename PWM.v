`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2022 01:45:02 PM
// Design Name: 
// Module Name: PWM
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


module  PWM(input clk,input  [7:0] duty_cycle,output PWM_out );
  reg [7:0] pwm_counter=0;
always@(posedge clk)
begin
	if(pwm_counter >= 100)
		pwm_counter <= 0;
	else
		pwm_counter <= pwm_counter + 1;
	
end
assign PWM_out = pwm_counter < duty_cycle ? 1 : 0;
endmodule
