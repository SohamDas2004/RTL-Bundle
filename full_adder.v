// Full Adder

// Gate Level Model for Full Adder
module full_adder_1(input A,B,Cin, output S, Cout);
    wire xor_ab;
    
    xor(xor_ab, A,B);
    xor(S, xor_ab, Cin);

    and(and_ab, A,B);
    and(and_cin_xor_ab, xor_ab, Cin);

    or(Cout, and_cin_xor_ab, and_ab);
endmodule

// Data Flow Level Model for Full Adder
module full_adder_2(input A,B,Cin, output S, Cout);
    wire xor_ab;
    
    assign S = A^B^Cin;
    assign Cout = (A&B) | ((A^B)&Cin);
endmodule


// Behavioural Model
module full_adder_3(input A,B,Cin, output reg S, Cout);
    always @(A or B or Cin)
    begin
        case ({A,B,Cin})
        3'b000: begin S=0; Cout=0; end
        3'b001: begin S=1; Cout=0; end
        3'b010: begin S=1; Cout=0; end
        3'b011: begin S=0; Cout=1; end
        3'b100: begin S=1; Cout=0; end
        3'b101: begin S=0; Cout=1; end
        3'b110: begin S=0; Cout=1; end
        3'b111: begin S=1; Cout=1; end
        endcase
    end
endmodule

// Gate Level Model.
module half_adder_1(input A,B, output S,C);
    xor instance_xor_gate(S,A,B);
    and instance_and_gate(C,A,B);
endmodule



// Full Adder using Half Adders.
module full_adder_4(input A,B,Cin, output  S, Cout);
    wire ha0_sum, ha0_carry, ha1_carry;

    half_adder_1  ha_instance_0(A,B,ha0_sum, ha0_carry);

    half_adder_1  ha_instance_1(ha0_sum, Cin, S, ha1_carry);

    or or_instance(Cout, ha0_carry, ha1_carry);

endmodule

module tb;
    reg tbA, tbB, tbCin;
    wire Sum, Carry;

    full_adder_4 instanace_fa(tbA, tbB, tbCin, Sum,Carry);

    initial begin
        $monitor("Time:%t, A:%b, B:%b, Cin:%b, S:%b, C:%b ", $time, tbA, tbB, tbCin, Sum, Carry);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        tbA = 0; tbB= 0; tbCin=0;
        #1; tbA = 0; tbB= 0; tbCin=1;
        #1; tbA = 0; tbB= 1; tbCin=0;
        #1; tbA = 0; tbB= 1; tbCin=1;
        #1; tbA = 1; tbB= 0; tbCin=0;
        #1; tbA = 1; tbB= 0; tbCin=1;
        #1; tbA = 1; tbB= 1; tbCin=0;
        #1; tbA = 1; tbB= 1; tbCin=1;
        #1; tbA = 0; tbB= 0; tbCin=0;
        #1; tbA = 0; tbB= 0; tbCin=1;

        #5
        $finish;
    end
    

endmodule