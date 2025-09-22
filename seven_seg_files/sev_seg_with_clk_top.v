`timescale 1ns / 1ps
module sev_seg_with_clk_top(
    input [3:0] num_1,
    input [3:0] num_2,
    input clk_main,
    input reset,
    output [7:0] sev_seg_leds,
    output [5:0] led_disable,
    output [1:0] led_enable
);

    // Clock division wires and registers
    wire clk_slw;
    reg [14:0] clk_div;
    wire scan_clk;

    // Instantiate IP clock divider (100 MHz → 5 MHz)
    ip_clk_div clk_5M (
        .clk_in1(clk_main),
        .clk_out1(clk_slw)
    );

    // Further divide 5 MHz to ~150 Hz
    always @(posedge clk_slw) begin
        if (reset)
            clk_div <= 15'd0;
        else
            clk_div <= clk_div + 15'd1;
    end

    assign scan_clk = clk_div[14]; // Use MSB for digit switching

    // Instantiate the updated display module
    sev_seg_with_clk display_driver (
        .num_1(num_1),
        .num_2(num_2),
        .clk(clk_main),        // << use main clock for simulation
        .reset(reset),
        .sev_seg_leds(sev_seg_leds),
        .led_disable(led_disable),
        .led_enable(led_enable)
    );


endmodule