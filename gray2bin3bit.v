// Gray Code to Binary converter.  3 bit.

// Data Flow Model.
module gray2bin3bit_1(gin, bout);
    input wire [2:0]gin;
    output wire [2:0]bout;

    assign bout[0] = gin[0] ^ gin[1] ^ gin[2];
    assign bout[1] = gin[1] ^ gin[2];
    assign bout[2] = gin[2];

endmodule


// BEHAVIOURAL model
module gray2bin3bit_2(gin,bout);
    input wire [2:0]gin;
    output reg  [2:0]bout;

    always @(gin)
    begin
        case (gin)
        3'b000: begin bout = 3'b000; end
        3'b001: begin bout = 3'b001; end
        3'b010: begin bout = 3'b011; end
        3'b011: begin bout = 3'b010; end
        3'b100: begin bout = 3'b111; end
        3'b101: begin bout = 3'b110; end
        3'b110: begin bout = 3'b100; end
        3'b111: begin bout = 3'b101; end
        endcase
    end
endmodule;

module tb;
    input wire [2:0]binval;
    output reg [2:0]grayval;

    gray2bin3bit_2 g2b_instance(.gin(grayval),.bout(binval));

    initial begin
        $monitor("Time:%t, gin:%b, bout:%b ", $time, grayval, binval);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        grayval = 3'b000;
        #15;
        $finish;
    end

    always #1 grayval = grayval + 1'b1;

endmodule