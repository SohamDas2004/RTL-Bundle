// Ssync Up Counter using T Flop., with Sync clear;. None Linear output. 1,2,3,5,7,11,13


module tff_1(input wire t, clk, clear, reset_value, output reg q, output wire qbar);

    always @(posedge clk)
    begin

        if (clear)
        begin
            q = reset_value;
        end
        else  begin
            if (t)
                q = ~q;
            else
                q = q;
        end

    end
    
    assign qbar = ~q;

endmodule;


module upcounter(input wire clk, clear, inout wire [3:0]q);
    wire [3:0] qbar;
    wire q0q1;
    wire q0q1q2;


    tff_1 instance_q0( (qbar[3]&qbar[2]&qbar[1]) | (q[1]&qbar[0]),  clk, clear, 1'b1, q[0], qbar[0]);

    tff_1 instance_q1( (qbar[3]& qbar[1]) | (qbar[2]&q[1]&q[0]),    clk, clear, 1'b0, q[1], qbar[1]);


    tff_1 instance_q2( q[3] | (q[1]&q[0]),                          clk, clear, 1'b0, q[2], qbar[2]);


    tff_1 instance_q3( (q[3]&q[2]) | (q[2]&q[1]),                   clk, clear, 1'b0, q[3], qbar[3]);

endmodule


module tb;
    output reg clk, clear;
    input wire [3:0]q;

    upcounter instance_1(clk,clear, q);

    initial begin
        $monitor("Time:%t, clk:%b, clear:%b, q:%b,q:%d ", $time, clk,clear, q,q);
        //$monitor("Time:%t, clear:%b, q:%b,q:%d ", $time, clear, q,q);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        clear = 1;
        forever #1 clk = ~clk;
    end


    initial begin
        #2;
        clear = 0;
        //#1;
        //clear = 1;
        //#2;
        //clear = 0;
        #40;
        $finish;
    end

endmodule;