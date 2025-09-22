`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: fourbit_add_sub
//////////////////////////////////////////////////////////////////////////////////
module fourbit_add_sub(
    input  [3:0] A,     // unsigned 0..15
    input  [3:0] B,     // unsigned 0..15
    input        Sub,   // 0 = add, 1 = subtract
    output [3:0] Sum,   // unsigned result
    output       Cout,  // carry out (for add) or borrow out (for sub)
    output       Sign   // 1 if subtraction result went "negative" (borrow)
);

    wire [3:0] Bin = Sub ? ~B : B;
    wire [3:0] C;
    wire [3:0] S;

    Full_Adder FA0(A[0], Bin[0], Sub,  S[0], C[0]);
    Full_Adder FA1(A[1], Bin[1], C[0], S[1], C[1]);
    Full_Adder FA2(A[2], Bin[2], C[1], S[2], C[2]);
    Full_Adder FA3(A[3], Bin[3], C[2], S[3], C[3]);

    assign Sum  = S;
    assign Cout = (~Sub) & C[3];   
    assign Sign = ( Sub) & ~C[3]; 

endmodule