module decodificador_7seg (
    input wire[3:0] D,
    output wire[6:0] SEG
);

    //Entradas negadas
    wire n_B0, n_B1, n_B2, n_B3;

    not U0_n(n_B0, D[0]);
    not B1_n(n_B1, D[1]);
    not B2_n(n_B2, D[2]);
    not B3_n(n_B3, D[3]);

    //HEX[0] = B2 B1' B0' + B3' B2' B1' B0;
    wire B2nB1nB0_and, nB3nB2nB1B0_and;
    and B2nB1nB0 (B2nB1nB0_and, D[2], n_B1, n_B0);
    and nB3nB2nB1B0 (nB3nB2nB1B0_and, n_B3, n_B2, n_B1, D[0]);
    or HEX0 (SEG[0], B2nB1nB0_and, nB3nB2nB1B0_and);

    //HEX[1] = B2 B1' B0 + B2 B1 B0';
    wire B2nB1B0_and , B2B1nB0_and;
    and B2nB1B0 (B2nB1B0_and, D[2], n_B1, D[0]);
    and B2B1nB0 (B2B1nB0_and, D[2], D[1], n_B0);
    or HEX1 (SEG[1], B2nB1B0_and, B2B1nB0_and);

    //HEX[2] = B2' B1 B0';
    and HEX2 (SEG[2], n_B2, D[1], n_B0);

    //HEX[3] = B2 B1 B0 + B2 B1' B0' + B3' B2' B1' B0;
    wire B2B1B0_and;
    and B2B1B0 (B2B1B0_and, D[2], D[1], D[0]);
    or HEX3 (SEG[3], B2B1B0_and, B2nB1nB0_and, nB3nB2nB1B0_and);

    //HEX[4] = B0 + B2 B1' ;
    wire B2nB1_and;
    and B2nB1 (B2nB1_and, D[2], n_B1);
    or HEX4 (SEG[4], D[0], B2nB1_and);

    //HEX[5] = B2' B1  + B1 B0 + B3' B2' B0;
    wire nB2B1_and, B1B0_and, nB3nB2B0_and;
    and nB2B1 (nB2B1_and, n_B2, D[1]);
    and B1B0 (B1B0_and, D[1], D[0]);
    and nB3nB2B0 (nB3nB2B0_and, n_B3, n_B2, D[0]);
    or HEX5 (SEG[5], nB2B1_and, B1B0_and, nB3nB2B0_and);

    //HEX[6] = B3' B2' B1'  + B2 B1 B0;
    wire nB3nB2nB1_and;
    and nB3nB2nB1 (nB3nB2nB1_and, n_B3, n_B2, n_B1);
    or HEX6 (SEG[6], nB3nB2nB1_and, B2B1B0_and);

endmodule