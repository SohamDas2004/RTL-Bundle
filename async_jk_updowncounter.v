// Async Down Counter using T Flop., with async clear.


module jkff_1(input wire clk, j, k, clear, output reg q, qbar);

    always @(posedge clk or posedge clear)
    begin
        if (clear)
            q = 0;
        else
        begin
            case ({j,k})

                2'b01: begin q=1'b0; qbar = 1'b1; end
                2'b10: begin q=1'b1; qbar = 1'b0; end
                2'b11: begin q=~q;  qbar = ~q; end
            endcase
        end
    end
endmodule


module upcounter(input wire clk,j,k,clear, output wire [3:0]q);
    wire [3:0] qbar;

    jkff_1 instance_q0(clk, j,k, clear, q[0], qbar[0]);
    jkff_1 instance_q1(qbar[0], j,k, clear,q[1], qbar[1]);
    jkff_1 instance_q2(qbar[1], j,k, clear,q[2], qbar[2]);
    jkff_1 instance_q3(qbar[2], j,k, clear,q[3], qbar[3]);

endmodule

module downcounter(input wire clk,j,k,clear,output wire [3:0]q);
    wire [3:0] qbar;

    jkff_1 instance_q0(clk, j,k, clear,q[0], qbar[0]);
    jkff_1 instance_q1(q[0], j,k, clear,q[1], qbar[1]);
    jkff_1 instance_q2(q[1], j,k, clear,q[2], qbar[2]);
    jkff_1 instance_q3(q[2], j,k, clear,q[3], qbar[3]);

endmodule

module tb;
    output reg clk, j,k, clear, up_or_down;
    input wire [3:0]qup;
    input wire [3:0]qdown;
    output wire [3:0]q;

    upcounter instance_1(  .clk(clk),  .j(j),  .k(k), .clear(clear), .q(qup) );
    downcounter instance_2( .clk(clk),  .j(j),  .k(k), .clear(clear), .q(qdown) );

    assign q = up_or_down ? qup : qdown; // ternary condition statement

    initial begin
        $monitor("Time:%t, clk:%b, up_or_down:%b, q:%b, ", $time, clk, up_or_down, q);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        j =1;
        k = 1;
        up_or_down = 0;
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
        up_or_down = 1;
        #40;
        $finish;
    end

endmodule;