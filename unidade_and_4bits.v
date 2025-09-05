module unidade_and_4bits (
    input  wire [3:0] A,    
    input  wire [3:0] B,    
    output wire [3:0] S     
);

    and AND0 (S[0], A[0], B[0]);
    and AND1 (S[1], A[1], B[1]);
    and AND2 (S[2], A[2], B[2]);
    and AND3 (S[3], A[3], B[3]);

endmodule
