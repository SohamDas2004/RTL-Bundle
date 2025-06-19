// decoder 3 to 8.


// behavioural model
module decoder_3_to_8_1(input A,B,C,output reg [7:0]Q );

    always @(A or B or C)
    begin

        case ({A,B,C})
        3'b000: begin Q = 8'b00000001; end
        3'b001: begin Q = 8'b00000010; end
        3'b010: begin Q = 8'b00000100; end
        3'b011: begin Q = 8'b00001000; end
        3'b100: begin Q = 8'b00010000; end
        3'b101: begin Q = 8'b00100000; end
        3'b110: begin Q = 8'b01000000; end
        3'b111: begin Q = 8'b10000000; end
        endcase
    end

endmodule;



module tb;
    reg A,B,C;
    wire [7:0]Q;

    decoder_3_to_8_1  decoder_instance(A,B,C,Q);

    initial begin
        $monitor("Time:%t, A:%b, B:%b, C:%b, Q:%b, ", $time, A, B, C, Q);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
    end

    initial begin
        A = 0; B = 0; C = 0;
        #1; A = 0; B = 0; C = 1;
        #1; A = 0; B = 1; C = 0;
        #1; A = 0; B = 1; C = 1;
        #1; A = 1; B = 0; C = 0;
        #1; A = 1; B = 0; C = 1;
        #1; A = 1; B = 1; C = 0;
        #1; A = 1; B = 1; C = 1;
        #1; A = 0; B = 0; C = 0;
        #1
        $finish;
    end

endmodule