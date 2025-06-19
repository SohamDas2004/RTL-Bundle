// parallel in , serial out on msb flop.


module sr_piso(input wire clk, load, input wire[3:0]pi, output reg so);

    reg [3:0]temp;

    always@(posedge clk)
    begin
        if (load)
            temp = pi;
        else
        begin
            so = temp[3];  // serial out is on the MSB flop.
            temp = {temp[2:0], 1'b0};
        end          
    end
endmodule;


module tb;
    reg clk, load;
    reg [3:0]pi;
    input wire so;


    sr_piso inst0(clk, load, pi, so);
    initial begin
        $monitor("Time:%t, clk:%b, load=%b, pi=%b, so=%b ", $time, clk,load, pi, so);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        drive_pdata(4'b1011);
        #10;
        $finish;
    end


    task drive_pdata(input [3:0]data);
    begin
        load = 0;
        pi = data;
        load = 1;
        #2;
        load = 0;
    end
    endtask;

endmodule;