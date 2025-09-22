`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: addsub_display_wrapper
//////////////////////////////////////////////////////////////////////////////////
module addsub_display_wrapper (
    input        clk_main,
    input        reset,
    input  [3:0] A,
    input  [3:0] B,
    input        Sub,
    output [7:0] sev_seg_leds,
    output [4:0] led_disable,   // 5 disables (3 digits enabled elsewhere)
    output [2:0] led_enable,    // 3 digits
    output       LED_overflow,
    output       LED_sign
);

    wire [3:0] Sum;
    wire       Cout;
    wire       Sign;

    fourbit_add_sub U_ADD_SUB (
        .A(A),
        .B(B),
        .Sub(Sub),
        .Sum(Sum),
        .Cout(Cout),
        .Sign(Sign)
    );

    sev_seg_with_clk_top U_DISP (
        .num_A(A),           // left digit
        .num_B(B),           // middle digit
        .num_S(Sum),         // right digit
        .clk_main(clk_main),
        .reset(reset),
        .sev_seg_leds(sev_seg_leds),
        .led_disable(led_disable),
        .led_enable(led_enable)
    );

    assign LED_overflow = Cout;
    assign LED_sign     = Sign;

endmodule