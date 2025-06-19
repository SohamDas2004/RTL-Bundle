// Toggle Flop with t input presumed to be tied to 1


module tff(input wire clk, clear,output reg q,qbar);
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


module tb;
    output reg clk, clear;
    input wire q,qbar;

    tff tff_instance(clk,clear,q,qbar);

    initial begin
        $monitor("Time:%t, clk:%b, clear:%b, q:%b, qbar:%b ", $time, clk,clear, q,qbar);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        #3;
        clear = 1'b1;
        #1;
        clear = 1'b0;
        #1

        #10;
        $finish;
    end


endmodule;