`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module: Full Adder
//////////////////////////////////////////////////////////////////////////////////
module Full_Adder(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
    );
    
    wire C1, C2, S1;
    
    Half_Adder HA01(A, B, S1, C1);
    Half_Adder HA02(Cin, S1, Sum, C2);
    
    assign Cout = C1 | C2;
    
endmodule
