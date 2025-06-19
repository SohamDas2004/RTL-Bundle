// Parallel In , Parallel Out 4 bit.

module sr_pipo(input clk, reset, input [3:0]pi,  output reg [3:0]po);
    reg [3:0]temp;

    always @(posedge clk)
    begin
        if (reset)
            po = 4'b000;
        else
            po = pi;
    end
endmodule


module tb;
    reg clk, reset;
    reg [3:0]pi;
    input wire [3:0]po;


    sr_pipo inst0(clk, reset, pi, po);

    initial begin
        $monitor("Time:%t, clk:%b, reset=%b, pi=%b, po=%b ", $time, clk,reset, pi, po);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        reset = 0;
        #2;
        reset = 1;
        #2;
        reset = 0;
        #2;
        pi= 4'b1011;
        #2;
        
        $finish;
    end


endmodule;
