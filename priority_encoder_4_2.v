// Priority 4 to 2 Encoder.

// BEHAVIOURAL model
module pencoder_4_to_2_1(input wire[3:0]Y, output reg[1:0]A);
    always @(Y)
    begin
        casex (Y)
        4'b0001: begin A = 2'b00; end
        4'b001x: begin A = 2'b01; end
        4'b01xx: begin A = 2'b10; end
        4'b1xxx: begin A = 2'b11; end

        endcase
    end
endmodule;


//data flow model
module pencoder_4_to_2_2(input wire[3:0]Y, output wire[1:0]A);
    assign A[0] = Y[3] | (Y[1] & ~Y[2]);
    assign A[1] = Y[2] | Y[3];
endmodule;


module tb;
    reg [3:0]Y;
    wire [1:0]A;
    integer i;

    pencoder_4_to_2_1  pencoder_instance(Y,A);

    initial begin
        $monitor("Time:%t, Y:%b, A:%b ", $time, Y, A);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        for (i = 0; i < 16; i = i + 1)
        begin
            Y = i;
            #1;
        end

        #1
        $finish();

    end

endmodule;