`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:01:50 09/28/2013 
// Design Name: 
// Module Name:    sev_seg_with_clk 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sev_seg_with_clk(
    input [3:0] num_1, // input number one
    input [3:0] num_2, // input number two
input clk, // we need a clk to switch between multiple digits
input reset, // reset signal
output  [7:0] sev_seg_leds, // controls the 8 individual LEDs in all sev_seg digits
output  [5:0]led_disable, // connected to disable the 6 displays that will not be used
output  reg [1:0]led_enable // connected to drive the 2 displays that will be used
    );


reg sel ;

assign led_disable = 6'b111111; // disable other 6 digits

// We will toggle the register "sel" at every rising clock edge
// This register will be used to switch the display between two displays
// led_enable[1] controls the leftmost display, led_enable[0] controls the one next to it
// The displays are activated when the corresponding enable bit goes to LOW
always @ (posedge clk or posedge reset) // Whenever the clock or the reset signal goes high, this block will be activated
begin
if (reset) // If reset is high
begin
sel = 0 ; // sel signal is brought to 0
led_enable = 2'b11; // both displays are turned off
end
else // If reset button is not pressed
begin
sel = ~sel; // sel signal is toggled
if(sel == 1)
led_enable = 2'b10; // if sel = 1, then the second display from left is turned on
else
led_enable = 2'b01; // if sel = 0, then the leftmost display is turned on
end
end

// If sel = 0, num_2 is sent to the decoder input; otherwise it is num_1
sev_seg_decoder decoder1(.num_in(sel ? num_1 : num_2), .sev_seg_leds(sev_seg_leds));
// So, num_2 controls the leftmost display, and num_1 controls the one next to it
// For convenience, we assigned num_2 to the four leftmost switches and num_1 to the four rightmost switches
 
endmodule
