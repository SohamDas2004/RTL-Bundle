// Async Down Counter using T Flop., with async clear.


module tff_1(input wire clk, clear,output reg q,qbar);
    always @(posedge clk or posedge clear)
    begin

        if (clear)
        begin
            q = 1'b0;
            qbar = 1'b1;
        end
        else  begin
            q = ~q;
            qbar = ~q;
        end
    end
endmodule;


module upcounter(input wire clk, input wire clear, output wire [3:0]q);
    wire [3:0] qbar;

    tff_1 instance_q0(clk, clear, q[0], qbar[0]);
    tff_1 instance_q1(qbar[0], clear, q[1], qbar[1]);
    tff_1 instance_q2(qbar[1], clear, q[2], qbar[2]);
    tff_1 instance_q3(qbar[2], clear, q[3], qbar[3]);

endmodule

module downcounter(input wire clk, input wire clear, output wire [3:0]q);
    wire [3:0] qbar;

    tff_1 instance_q0(clk, clear, q[0], qbar[0]);
    tff_1 instance_q1(q[0], clear, q[1], qbar[1]);
    tff_1 instance_q2(q[1], clear, q[2], qbar[2]);
    tff_1 instance_q3(q[2], clear, q[3], qbar[3]);

endmodule

module tb;
    output reg clk, clear;
    input wire [3:0]q;

//    upcounter instance_1(clk,clear, q);
    downcounter instance_1(clk,clear, q);

    initial begin
        $monitor("Time:%t, clk:%b, clear:%b, q:%b, ", $time, clk,clear, q);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        clear = 0;
        forever #1 clk = ~clk;
    end


    initial begin
        #5;
        clear = 0;
        #1;
        clear = 1;
        #1;
        clear = 0;
        #40;
        $finish;
    end

endmodule;