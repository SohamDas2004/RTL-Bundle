// clockgen

`timescale 1ns/1ps

module clockgen(output reg clk);
    parameter CLK_PERIOD = 1;
    parameter DUTY_CYCLE = 50.0; // dutycycle is percentage of high time in the clk period.

    real clk_on = (DUTY_CYCLE/100.0) * CLK_PERIOD;
    real clk_off = (100 - DUTY_CYCLE)/100.0 * CLK_PERIOD;

    initial begin
        $display("Clkperiod: %d, dutycycle: %d, clk_on:%e, clk_off:%e ", CLK_PERIOD, DUTY_CYCLE, clk_on, clk_off);
    end

    always begin
        clk = 1'b1; #clk_on;
        clk = 1'b0; #clk_off;
    end
endmodule

module tb;
    wire clk1, clk2;
    
    clockgen clkgen_inst0(clk1);
    clockgen #(.CLK_PERIOD(10), .DUTY_CYCLE(70)) clkgen_inst1(clk2);

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        #50;
        $finish;
    end
endmodule