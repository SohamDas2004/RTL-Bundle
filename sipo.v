// Serial In , Parallel Out 4 bit.

module sr_sipo(input clk, si, output [3:0]po);
    reg [3:0]temp;

    always @(posedge clk)
    begin
        //temp = {temp[2:0],si}; // 1001  si = 1 ,  0011  lsb_in
        temp = {si, temp[3:1]}; // 1001  si = 1 ,  1100  msb_in
    end

    assign po = temp;

endmodule


module tb;
    reg clk, si;
    input wire [3:0]po;


    sr_sipo inst0(clk, si, po);

    initial begin
        $monitor("Time:%t, clk:%b, si=%b, po=%b ", $time, clk,si, po);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        #2;
        drive_data(4'b1011);
        $finish;
    end

    task drive_data(input [3:0]data);
    begin
        si = data[0];  // lsb_data_bit is first injected into the MSB_Flop
        #2;
        si = data[1];
        #2;
        si = data[2];
        #2;
        si = data[3];
        #2;
    end
    endtask;

endmodule;
