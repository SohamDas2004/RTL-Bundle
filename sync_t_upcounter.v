// Ssync Up Counter using T Flop., with Sync clear;


module tff_1(input wire t, clk, clear,output reg q, output wire qbar);

    always @(posedge clk)
    begin

        if (clear)
        begin
            q = 1'b0;
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

    tff_1 instance_q0(1'b1, clk, clear, q[0], qbar[0]);
    tff_1 instance_q1(q[0], clk, clear, q[1], qbar[1]);

    and(q0q1, q[0],q[1]);
    tff_1 instance_q2(q0q1, clk, clear, q[2], qbar[2]);

    and(q0q1q2, q[0],q[1], q[2]);
    tff_1 instance_q3(q0q1q2, clk, clear, q[3], qbar[3]);

endmodule


module tb;
    output reg clk, clear;
    input wire [3:0]q;

    upcounter instance_1(clk,clear, q);

    initial begin
        $monitor("Time:%t, clk:%b, clear:%b, q:%b, ", $time, clk,clear, q);
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