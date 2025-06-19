// Binary to Gray Code converter.  3 bit.

// Data Flow Model.
module bin2gray3bit_1(bin,gout);
    input wire [2:0]bin;
    output wire [2:0]gout;

    assign gout[2] = bin[2];

    //assign gout[1] = bin[2] ^ bin[1];
    //assign gout[0] = bin[1] ^ bin[0];

    assign gout[1:0] = bin[2:1] ^ bin[1:0];
endmodule


// BEHAVIOURAL model
module bin2gray3bit_2(bin,gout);
    input wire [2:0]bin;
    output reg  [2:0]gout;

    always @(bin)
    begin
        case (bin)
        3'b000: begin gout = 3'b000; end
        3'b001: begin gout = 3'b001; end
        3'b010: begin gout = 3'b011; end
        3'b011: begin gout = 3'b010; end
        3'b100: begin gout = 3'b110; end
        3'b101: begin gout = 3'b111; end
        3'b110: begin gout = 3'b101; end
        3'b111: begin gout = 3'b100; end
        endcase
    end
endmodule;


module tb;
    input wire [2:0]grayval;
    output reg [2:0]binval;

    bin2gray3bit_2 b2g_instance(.bin(binval),.gout(grayval));


    initial begin
        $monitor("Time:%t, bin:%b, gout:%b ", $time, binval,grayval);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        binval = 3'b010;
        #15;
        $finish;
    end

    always #1 binval = binval + 1'b1;

endmodule