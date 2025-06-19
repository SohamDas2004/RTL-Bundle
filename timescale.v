`timescale 1ns/1ps

module tb;
    reg clk;
    reg test;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        test = 0;

        clk = 0;  #1;
        clk = 1;  #1;
        clk = 0;  #1;
        test = 1;
        clk = 1;  #0.498;
        test = 0;
        clk = 0;  #1;
        clk = 1;  #1;
        clk = 0;  #1;
        test = 1;
        clk = 1;  #0.4987;
        test = 0;
        clk = 0;  #1;
        clk = 1;  #1;
        clk = 0;  #1;
        test = 1;
        clk = 1;  #0.4982;
        test = 0;
        clk = 1;  #1;
        clk = 0;  #1;
        clk = 1;  #1;
        $finish;
    end
endmodule