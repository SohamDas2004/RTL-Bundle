// 8 to 3 Encoder.

// BEHAVIOURAL model
module encoder_8_to_3_1(input wire[7:0]Y, output reg[2:0]A);
    always @(Y)
    begin
        case (Y)
        8'b00000001: begin A = 3'b000; end
        8'b00000010: begin A = 3'b001; end
        8'b00000100: begin A = 3'b010; end
        8'b00001000: begin A = 3'b011; end
        8'b00010000: begin A = 3'b100; end
        8'b00100000: begin A = 3'b101; end
        8'b01000000: begin A = 3'b110; end
        8'b10000000: begin A = 3'b111; end
        endcase
    end
endmodule;


//data flow model
module encoder_8_to_3_2(input wire[7:0]Y, output wire[2:0]A);
    assign A[0] = Y[1] | Y[3] | Y[5] | Y[7];
    assign A[1] = Y[2] | Y[3] | Y[6] | Y[7];
    assign A[2] = Y[4] | Y[5] | Y[6] | Y[7];
endmodule;


module tb;
    reg [7:0]Y;
    wire [2:0]A;
    integer i;

    encoder_8_to_3_2  encoder_instance(Y,A);

    initial begin
        $monitor("Time:%t, Y:%b, A:%b ", $time, Y, A);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        for (i = 0; i < 8; i = i + 1)
        begin
            Y = 2**i;
            #1;
        end

        #1
        $finish();

    end

endmodule;