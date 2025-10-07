module nor_gate(
    input wire a,
    input wire b,
    output wire y
);
    assign y = ~(a | b);
endmodule

module not_gate_nor(
    input wire a,
    output wire y
);
    nor_gate nor_inst(a, a, y);
endmodule

module or_gate_nor(
    input wire a,
    input wire b,
    output wire y
);
    wire w1;
    nor_gate nor1(a, b, w1);
    not_gate_nor not1(w1, y);
endmodule

module and_gate_nor(
    input wire a,
    input wire b,
    output wire y
);
    wire w1, w2;
    not_gate_nor not1(a, w1);
    not_gate_nor not2(b, w2);
    nor_gate nor1(w1, w2, y);
endmodule

module xor_gate_nor(
    input wire a,
    input wire b,
    output wire y
);
    wire w1, w2, w3, w4;
    
    nor_gate nor1(a, b, w1);      
    nor_gate nor2(a, a, w2);       
    nor_gate nor3(b, b, w3);        
    nor_gate nor4(w2, w3, w4);     
    nor_gate nor5(w1, w4, y);       
endmodule

module full_adder_nor(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);
    wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10;
    
    xor_gate_nor xor1(a, b, w1);
    xor_gate_nor xor2(w1, cin, sum);
    
    and_gate_nor and1(a, b, w2);           
    and_gate_nor and2(cin, w1, w3);        
    or_gate_nor or1(w2, w3, cout);         
endmodule

module four_bit_adder_nor(
    input wire [3:0] a,
    input wire [3:0] b,
    input wire cin,
    output wire [3:0] sum,
    output wire cout
);
    wire [2:0] carry;
    
    full_adder_nor fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(carry[0])
    );
    
    full_adder_nor fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(carry[0]),
        .sum(sum[1]),
        .cout(carry[1])
    );
    
    full_adder_nor fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(carry[1]),
        .sum(sum[2]),
        .cout(carry[2])
    );
    
    full_adder_nor fa3(
        .a(a[3]),
        .b(b[3]),
        .cin(carry[2]),
        .sum(sum[3]),
        .cout(cout)
    );
endmodule