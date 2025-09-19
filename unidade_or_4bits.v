module unidade_or_4bits (
    input  wire [4:0] AC,    
    input  wire [3:0] B,    
    output wire S     
);

    
    or OR0 (S, AC[0], AC[1], AC[2], AC[3], AC[4], B[0], B[1], B[2], B[3]);

endmodule