// 1 bit comparitor

// gate level model
module comp_1bit_1(input A,B, output G, E, L);  // check if A<B , A==B, A>B
    wire iB, iA;

    xnor inst_1(E,A,B);

    not inst_2(iB, B);
    and inst_3(G, A, iB);

    not inst_4(iA, A);
    and inst_5(L, iA, B);

endmodule;

// Data flow  level model
module comp_1bit_2(input A,B, output G, E, L);  // check if A<B , A==B, A>B

    assign L = (~A) & B;
    assign G = A & (~B);
    assign E = ~(A^B);

endmodule;


// Behavioural level model
module comp_1bit_3(input A,B, output reg G, E, L);  // check if A<B , A==B, A>B
    always @(A or B)
    begin

        if (A==1'b0 && B==1'b0)     
        begin
            G = 0;
            L = 0;
            E = 1;
        end
        else if (A==1'b0 && B ==1'b1)
            begin
            E = 1'b0;
            L = 1'b1;
            G = 1'b0;
        end
        else if (A==1'b1 && B ==1'b0)
            begin
            E = 1'b0;
            L = 1'b0;
            G = 1'b1;
        end
        else 
            begin
            E = 1'b1;
            L = 1'b0;
            G = 1'b0;
        end
    end

endmodule;


module tb;
    reg A,B;
    wire G,E,L;

    comp_1bit_3 inst_comp1bit(A,B,G,E,L);

    initial begin
        $monitor("Time:%t, A:%b, B:%b, G:%b, E:%b, L:%b ", $time, A, B, G, E, L);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        A = 0; B = 0; 

        #5
        $finish();
    end

    always #2 A = ~A;
    always #1 B = ~B;

endmodule