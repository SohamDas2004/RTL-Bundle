// decoder 2 to 4.


// behavioural model
module decoder_2_to_4_1(input A,B, output reg [3:0]Q );

    always @(A or B)
    begin

        case ({A,B})
        2'b00: begin Q = 4'b0001; end
        2'b01: begin Q = 4'b0010; end
        2'b10: begin Q = 4'b0100; end
        2'b11: begin Q = 4'b1000; end
        endcase
    end

endmodule;

// data flow model
module decoder_2_to_4_2(input A,B, output [3:0]Q );

    assign Q[0] = (~A)&(~B);
    assign Q[1] = (~A)&B;
    assign Q[2] = A&(~B);
    assign Q[3] = A&B;
endmodule;

// gate level flow model
module decoder_2_to_4_3(input A,B, output [3:0]Q );
    wire iA, iB;

    not(iA, A);
    not(iB, B);

    and(Q[0], iA, iB);
    and(Q[1], iA, B);
    and(Q[2], A, iB);
    and(Q[3], A, B);
    
endmodule;

module tb;
    reg A,B;
    wire [3:0]Q;

    decoder_2_to_4_3  decoder_instance(A,B,Q);

    initial begin
        $monitor("Time:%t, A:%b, B:%b, Q:%b, ", $time, A, B, Q);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
    end

    initial begin
        A = 0; B = 0;
        #1; A = 0; B = 1;
        #1 A= 1; B = 0;
        #1 A= 1; B = 1;
        #1
        $finish;
    end

endmodule