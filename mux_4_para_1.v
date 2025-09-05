module mux_4_para_1 (
    input  wire D0, D1, D2, D3,
    input  wire S0, S1,
    output wire Y
);
    wire not_S0, not_S1;
    wire term0, term1, term2, term3;

    not U1 (not_S0, S0);
    not U2 (not_S1, S1);

    and U3 (term0, D0, not_S1, not_S0);
    and U4 (term1, D1, not_S1, S0);
    and U5 (term2, D2, S1, not_S0);
    and U6 (term3, D3, S1, S0);

    or  U7 (Y, term0, term1, term2, term3);
endmodule
