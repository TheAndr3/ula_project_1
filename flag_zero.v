module flag_zero (
	input [6:0] HEX0, HEX1, HEX2,
	output ledr8
);

	wire hex0_and, hex1_and, hex2_and, saida;
	
	// HEX0 negado
	wire nHEX00, nHEX01, nHEX02, nHEX03, nHEX04, nHEX05;
	not nH00 (nHEX00, HEX0[0]);
	not nH01 (nHEX01, HEX0[1]);
	not nH02 (nHEX02, HEX0[2]);
	not nH03 (nHEX03, HEX0[3]);
	not nH04 (nHEX04, HEX0[4]);
	not nH05 (nHEX05, HEX0[5]);
	
	//HEX1 negado
	wire nHEX10, nHEX11, nHEX12, nHEX13, nHEX14, nHEX15;
	not nH10 (nHEX10, HEX1[0]);
	not nH11 (nHEX11, HEX1[1]);
	not nH12 (nHEX12, HEX1[2]);
	not nH13 (nHEX13, HEX1[3]);
	not nH14 (nHEX14, HEX1[4]);
	not nH15 (nHEX15, HEX1[5]);
	
	//HEX2 negado
	wire nHEX20, nHEX21, nHEX22, nHEX23, nHEX24, nHEX25;
	not nH20 (nHEX20, HEX2[0]);
	not nH21 (nHEX21, HEX2[1]);
	not nH22 (nHEX22, HEX2[2]);
	not nH23 (nHEX23, HEX2[3]);
	not nH24 (nHEX24, HEX2[4]);
	not nH25 (nHEX25, HEX2[5]);
	
	and fz0 (hex0_and, nHEX00, nHEX01, nHEX02, nHEX03, nHEX04, nHEX05, HEX0[6]);
	and fz1 (hex1_and, nHEX10, nHEX11, nHEX12, nHEX13, nHEX14, nHEX15, HEX1[6]);
	and fz2 (hex2_and, nHEX20, nHEX21, nHEX22, nHEX23, nHEX24, nHEX25, HEX2[6]);
	and fz (ledr8, hex0_and, hex1_and, hex2_and);

endmodule