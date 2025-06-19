// Gray Code to Binary converter.  4 bit.

// Data Flow Model.
module gray2bin4bit_1(gin, bout);
    input wire [3:0]gin;
    output wire [3:0]bout;

    assign bout[0] = gin[0] ^ gin[1] ^ gin[2] ^ gin[3];
    assign bout[1] = gin[1] ^ gin[2] ^ gin[3];
    assign bout[2] = gin[2]  ^ gin[3];
    assign bout[3] = gin[3];

endmodule


module tb;
    input wire [3:0]binval;
    output reg [3:0]grayval;

    gray2bin4bit_1 g2b_instance(.gin(grayval),.bout(binval));

    initial begin
        $monitor("Time:%t, gin:%b, bout:%b ", $time, grayval, binval);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        grayval = 4'b0000;
        #17;
        $finish;
    end

    always #1 grayval = grayval + 1'b1;

endmodule