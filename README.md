# SEVSEG(1) — 4-Bit Adder/Subtractor with Seven-Segment Display

## NAME
**sev_seg_decoder**, **sev_seg_with_clk**, **sev_seg_with_clk_top**, **addsub_display_wrapper**, **fourbit_add_sub**, **Full_Adder**, **Half_Adder** — Verilog modules for arithmetic operations and multiplexed seven-segment display driving.

## DESCRIPTION

This project implements a complete **4-bit signed adder/subtractor system** for the **Nexys 4 Artix-7 Power board**.
The design performs addition or subtraction on two 4-bit inputs, detects arithmetic overflow, and displays the result in real time on the board’s four-digit seven-segment display.

### Design Highlights

* **fourbit\_add\_sub:** Core arithmetic unit implementing ripple-carry addition and two’s complement subtraction.
* **Full\_Adder / Half\_Adder:** Gate-level primitives used to construct the 4-bit adder chain.
* **sev\_seg\_decoder:** Converts binary sum output to seven-segment code (0–F).
* **sev\_seg\_with\_clk:** Implements display multiplexing using a clock divider to cycle through digits at a visually stable refresh rate.
* **sev\_seg\_with\_clk\_top:** Connects the decoder to the digit-enable logic.
* **addsub\_display\_wrapper:** Top-level module connecting arithmetic logic, sign/overflow indicators, and display drivers.

A key feature is **overflow detection**, signaling when signed results exceed representable range. The **sign indicator LED** reflects whether the result is positive or negative.

## ENVIRONMENT

**Language:** Verilog
**Software:** Vivado (for synthesis, implementation, and bitstream generation)
**Hardware:** Digilent Nexys 4 DDR FPGA Development Board

## CORE CONCEPTS

* Ripple-Carry Addition and Two’s Complement Subtraction
* Signed Arithmetic and Overflow Detection
* Seven-Segment Display Multiplexing
* Clock Division and Refresh Rate Control
* Hierarchical & Modular Design Methodology
* Digital Simulation and Timing Verification with Vivado Simulator

## EXAMPLES

1. **Synthesize & Implement:** Use Vivado to synthesize and implement the project, then program the Nexys 4 board.
2. **Apply Inputs:** Set A and B via input switches, toggle `Sub` to select add/subtract mode.
3. **Observe Output:** The result appears on the rightmost digits of the seven-segment display.

   * **Overflow LED** lights when the result cannot be represented in 4 bits.
   * **Sign LED** lights when the result is negative.

Example:

* **A=7 (0111), B=8 (1000), Sub=0 → Result = 15 (1111)** displayed as `F` on the rightmost digit.
* **A=7 (0111), B=8 (1000), Sub=1 → Result = -1 (1111)** displays `F` with **sign LED ON**.

## TIMING

The display uses time-multiplexing controlled by a clock divider.
A simplified timing diagram (ASCII) for three digits:

```
clk_main:   ────┐┌────┐┌────┐┌────
digit0_en:  ████░░░░░░░░░░░░░░
digit1_en:  ░░░░████░░░░░░░░░░
digit2_en:  ░░░░░░░░████░░░░░░
segments:   <d0> <d1> <d2> repeat...
```

This cycling occurs fast enough that persistence of vision makes all digits appear simultaneously lit.

## AUTHOR

Written by **Johnathon Lamoreaux** as part of FPGA-based digital design coursework and lab work using the Nexys 4 DDR board.

