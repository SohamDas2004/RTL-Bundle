// Serial-In Serial-Out 4bit Shift Register.
// In is at MSB, Out is at LSB.

module d_flop_1(input wire d,clk, output reg q,qbar);

    always @(posedge clk)
    begin
        q <= d;
        qbar <= ~d;
    end
endmodule

module siso_rl_2(input wire clk, clear, si, output wire so, output wire [3:0]q);
    wire [3:0]qbar;
    
    d_flop_1 inst0( .clk(clk), .d(q[1]), .q(q[0]), .qbar(qbar[0]) );
    d_flop_1 inst1( .clk(clk), .d(q[2]), .q(q[1]), .qbar(qbar[1]) );
    d_flop_1 inst2( .clk(clk), .d(q[3]), .q(q[2]), .qbar(qbar[2]) );
    d_flop_1 inst3( .clk(clk), .d(si), .q(q[3]), .qbar(qbar[3]) );

    assign so = q[0];

endmodule

module siso_rl_1(input wire clk, clear, si, output reg so, output reg [3:0]q);
    
    always @(posedge clk)
    begin
        if (clear)
        begin
            q = 4'b0000;
            so = 1'b0;
        end
        else
        begin
            q = q >> 1;
            q[3] = si;
            so = q[0];
        end
    end
endmodule

module tb;
    output reg clk, clear, si;
    input wire so;
    input wire [3:0]q;

    siso_rl_2 inst0(clk, clear, si, so,q);

    initial begin
        $monitor("Time:%t, clk:%b, clear=%b, si:%b, so:%b, q:%b ", $time, clk,clear, si, so,q);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        si = 0;
        forever #1 clk = ~clk;
    end


    initial begin
        #2;
        clear = 1;
        #2;
        clear = 0;
        #2;

        si = 0; #2;
        si = 1; #2;
        si = 0; #2;
        si = 0; #2;
        si = 0; #2;
        si = 0; #2;
        
        #16;
        $finish;
    end

endmodule