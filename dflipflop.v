// Data.  D Flip Flop

module d_flop_1(input wire d,clk, output reg q,qbar);

    always @(posedge clk)
    begin
        q <= d;
        qbar <= ~d;
    end
endmodule

module tb;
    output reg d,clk;
    input wire q,qbar;

    d_flop_1 dflop_instance(d,clk,q,qbar);

    initial begin
        $monitor("Time:%t, clk:%b, d=%b, q:%b, qbar:%b ", $time, clk,d,q,qbar);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        d = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        d = 0; #3;
        d = 1; #3;
        d = 0; #3;
        d = 1'bx; #3;
        d = 0; #3;
        d = 1; #3;
        d = 0; #3;
        
        $finish;
    end
endmodule