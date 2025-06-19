// Serial-In Serial-Out Shift Register.
// In is at LSB, Out is at MSB.

module d_flop_1(input wire d,clk, output reg q,qbar);

    always @(posedge clk)
    begin
        q <= d;
        qbar <= ~d;
    end
endmodule

module siso_msb2lsb_2(input wire clk, clear, si, output wire so, output wire [3:0]q);
    wire [3:0]qbar;
    
    d_flop_1 d0( .clk(clk), .d(q[1]), .q(q[0]), .qbar(qbar[0]) );
    d_flop_1 d1( .clk(clk), .d(q[2]), .q(q[1]), .qbar(qbar[1]) );
    d_flop_1 d2( .clk(clk), .d(q[3]), .q(q[2]), .qbar(qbar[2]) );
    d_flop_1 d3( .clk(clk), .d(si), .q(q[3]), .qbar(qbar[3]) );

    assign so = q[0];

endmodule

module siso_msb2lsb_1(input wire clk, clear, si, output wire so, output reg [3:0]q);
    
    always @(posedge clk)
    begin
        if (clear)
        begin
            q = 4'b0000;
        end
        else
        begin
            q = q >> 1;
            q[3] = si;
        end
    end
    assign so = q[0];
endmodule

module tb;
    output reg clk, clear, si;
    input wire so;
    input wire [3:0]q;

    siso_msb2lsb_2 inst_0(clk, clear, si, so,q);

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