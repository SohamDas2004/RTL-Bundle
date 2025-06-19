// decoder 2 to 4 with enable


// behavioural model
module decoder_2_to_4_enable_1(input EN, A,B, output reg [3:0]Q );

    always @(EN,A,B)
    begin

        if (EN == 1)
        begin
            case ({A,B})
            2'b00: begin Q = 4'b0001; end
            2'b01: begin Q = 4'b0010; end
            2'b10: begin Q = 4'b0100; end
            2'b11: begin Q = 4'b1000; end
            endcase
        end
        else Q = 4'b0000;
    end

endmodule;

// data flow model
module decoder_2_to_4_enable_2(input EN,A,B, output [3:0]Q );

    assign Q[0] = EN&(~A)&(~B);
    assign Q[1] = EN&(~A)&B;
    assign Q[2] = EN&A&(~B);
    assign Q[3] = EN&A&B;
endmodule;

// gate level flow model
module decoder_2_to_4_enable_3(input EN,A,B, output [3:0]Q );
    wire iA, iB;

    not(iA, A);
    not(iB, B);

    and(Q[0], EN,iA, iB);
    and(Q[1], EN,iA, B);
    and(Q[2], EN,A, iB);
    and(Q[3], EN,A, B);
    
endmodule;

module tb;
    reg A,B,EN;
    wire [3:0]Q;

    decoder_2_to_4_enable_3  decoder_instance(EN,A,B,Q);

    initial begin
        $monitor("Time:%t, EN:%b, A:%b, B:%b, Q:%b, ", $time, EN, A, B, Q);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
    end

    initial begin
        EN=0;
        #1 EN=1;  A = 0; B = 0;
        #1; A = 0; B = 1;
        #1 A= 1; B = 0;
        #1 A= 1; B = 1;
        #1 A= 0; B = 0;
        #1 EN=0;
        #1 EN=1;  A = 0; B = 1;
        #1;
        $finish;
    end

endmodule