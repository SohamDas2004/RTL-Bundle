// Binary to Gray Code converter.  4 bit.

// Data Flow Model.
module bin2gray4bit_1(bin,gout);
    input wire [3:0]bin;
    output wire [3:0]gout;

    assign gout[3] = bin[3];

    //assign gout[2] = bin[3] ^ bin[2];
    //assign gout[1] = bin[2] ^ bin[1];
    //assign gout[0] = bin[1] ^ bin[0];

    assign gout[2:0] = bin[3:1] ^ bin[2:0];
endmodule


// BEHAVIOURAL model
module bin2gray4bit_2(bin,gout);
    input wire [3:0]bin;
    output reg  [3:0]gout;

    always @(bin)
    begin
        case (bin)
        4'b0000: begin gout = 4'b0000; end
        4'b0001: begin gout = 4'b0001; end
        4'b0010: begin gout = 4'b0011; end
        4'b0011: begin gout = 4'b0010; end
        4'b0100: begin gout = 4'b0110; end
        4'b0101: begin gout = 4'b0111; end
        4'b0110: begin gout = 4'b0101; end
        4'b0111: begin gout = 4'b0100; end
        4'b1000: begin gout = 4'b1100; end
        4'b1001: begin gout = 4'b1101; end
        4'b1010: begin gout = 4'b1111; end
        4'b1011: begin gout = 4'b1110; end
        4'b1100: begin gout = 4'b1010; end
        4'b1101: begin gout = 4'b1011; end
        4'b1110: begin gout = 4'b1001; end
        4'b1111: begin gout = 4'b1000; end
        endcase
    end
endmodule;


module tb;
    input wire [3:0]grayval;
    output reg [3:0]binval;

    bin2gray4bit_2 b2g_instance(.bin(binval),.gout(grayval));


    initial begin
        $monitor("Time:%t, bin:%b, gout:%b ", $time, binval,grayval);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        binval = 4'b0000;
        #25;
        $finish;
    end

    always #1 binval = binval + 1'b1;

endmodule