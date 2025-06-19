// Single Port RAM.  16 location, 4bit address bus..  8bit data bus.

module sp_ram(input clk, chip_enable, write_enable, input [7:0]din, input [3:0]address, output reg [7:0]dout);

    reg [7:0]memory[0:15];

    always @(posedge clk)
    begin
        if (chip_enable)
        begin
            if (write_enable)
                memory[address] = din;
            else
                dout = memory[address];
        end
    end
endmodule;


module tb;
    output reg clk, chip_enable, write_enable;
    output reg[7:0]din;
    output reg[3:0]address;
    input wire [7:0]dout;

    sp_ram inst0(clk, chip_enable, write_enable, din, address, dout);

    initial begin
        $monitor("Time:%t, clk:%b, chip_enable:%b, write_enable:%b, din:%d, address:%d, dout:%d ", $time, clk,chip_enable, write_enable, din, address, dout);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        chip_enable = 1;
        din = 45;  address = 6;
        write_enable = 1;
        #2;
        din = 23;  address = 14;
        #2
        write_enable = 0;
        address = 6;
        #2;
        address = 14;
        #2;
        $finish;

    end

endmodule