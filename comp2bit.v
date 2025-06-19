// 2bit comparator.


// behavioral Model
module comp_2bit_1(input [1:0]A,B, output reg G, E, L);  // check if A<B , A==B, A>B

    always @(A or B)
    begin
        L = A < B;
        G = A > B;
        E = A==B;
    end
endmodule

// data flow Model
module comp_2bit_2(input [1:0]A,B, output  G, E, L);  // check if A<B , A==B, A>B

    assign E = (~(A[1] ^ B[1]))  &    (~(A[0] ^ B[0]));

    assign G =  (A[1]&(~B[1])) |  (A[0]&(~B[1])&(~B[0]))  | (A[1]&A[0]&(~B[0]));
    
    assign L =  (~A[1]&(B[1])) |  (~A[0]&(B[1])&(B[0]))  | (~A[1]&~A[0]&(B[0]));
endmodule;

module tb;
    reg [1:0]A,B;
    integer i;
    wire G,E,L;

    comp_2bit_2 instance_comp_2bit(A,B,G,E,L);

    initial begin
        $monitor("Time:%t, A:%b, B:%b, G:%b, E:%b, L:%b ", $time, A, B, G, E, L);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        for (i = 0; i < 16; i = i + 1)
        begin
            {A,B} = i;
            #1;
        end

        #1
        $finish();
    end

endmodule