// Async Down Counter using D Flop.


module d_flop_1(input wire d,clk, output reg q,qbar);
    initial begin
        q = 1;
        qbar = 4'b1111;
    end

    always @(posedge clk)
    begin
        q <= d;
        qbar <= ~d;
    end
endmodule

module upcounter(input wire clk, output wire [3:0]q);
    wire [3:0] qbar;

    d_flop_1 instance_q0(qbar[0], clk, q[0], qbar[0]);
    d_flop_1 instance_q1(qbar[1], q[0], q[1], qbar[1]);
    d_flop_1 instance_q2(qbar[2], q[1], q[2], qbar[2]);
    d_flop_1 instance_q3(qbar[3], q[2], q[3], qbar[3]);

endmodule

module tb;
    output reg clk;
    input wire [3:0]q;

    upcounter instance_1(clk,q);

    initial begin
        $monitor("Time:%t, clk:%b, q:%b, ", $time, clk,q);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end


    initial begin
        #40;
        $finish;
    end

endmodule;