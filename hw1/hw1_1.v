module hw1_1 // define module name
(
input A, B, C, D, E, F, G, // set input A, B, C, D, E, F, G
output O // set the output of hw1_1 as O
);
wire w1, w2, w3, w4, w5, w6, w7; // define wires

and gate1(w1, A, B); // w1 = A and B
or gate2(w2, C, D); // w2 = C or D
not gate3(w3, w2); // w3 = not w2
and gate4(w4, E, F); // w4 = E and F
and gate5(w5, w1, w3); // w5 = w1 and w3
or gate6(w6, G, w4); // w6 = G and w4
not gate7(w7, w6); // w7 = not w6
or gate8(O, w5, w7); // G = w5 or w7
endmodule