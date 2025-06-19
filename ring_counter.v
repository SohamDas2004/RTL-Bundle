// Ring Counter 4bit 

module ring_counter  #(parameter WIDTH=4)
(
    input clk, reset,    output reg[WIDTH-1:0] out  // 3:0
);
    integer i;
    always @(posedge clk)
    begin
        if (reset)
            out = 4'b1011;
        else
        begin
            out[WIDTH-1] <= out[0];
            for (i = 0; i < WIDTH-1; i++)
            begin
                out[i] <= out[i+1];
            end
        end
    end
endmodule;

module tb;
    parameter WIDTH=4;
    reg clk, reset;
    wire[WIDTH-1:0]out;


    ring_counter inst0(clk, reset, out);

    initial begin
        //$monitor("Time:%t, clk:%b, reset=%b, out:%b", $time, clk,reset, out);
        $monitor("Time:%t, reset=%b, out:%b", $time, reset, out);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        reset = 1;
        #2
        reset = 0;

        repeat (15)@ (posedge clk);
        $finish;
    end
endmodule;   