// FIFO. 16 8bit locations. 
// R, W pointers are 4 bit wide
// on reset R,W pointers should be made 0


module fifo(clk, reset, wen, ren, wdata, rdata, full, empty);
    input wire clk, reset, wen, ren;
    input wire [7:0] wdata;
    output reg [7:0] rdata;
    output wire full, empty;


    parameter DEPTH = 16;
    reg [7:0]memory[0:DEPTH-1];
    reg [3:0]rptr, wptr;

    assign empty = (wptr == rptr);
    assign full = ((wptr == DEPTH-1) && (rptr == 0)) || (wptr == rptr - 1);

    always @(posedge clk)
    begin
        if (reset)
        begin
            rptr = 0;
            wptr = 0;
        end
        else
        begin
            if (wen && !full)
            begin
                memory[wptr] = wdata;

                if (wptr == DEPTH-1)
                    wptr = 0;
                else
                    wptr = wptr + 1;
            end

            if (ren && !empty)
            begin
                rdata = memory[rptr];
                if (rptr == DEPTH-1)
                    rptr = 0;
                else
                    rptr = rptr + 1;
            end
        end
    end
endmodule

module tb;
    output reg clk, reset, wen, ren;
    output reg [7:0]wdata;
    input wire [7:0]rdata;
    input wire full, empty;
  
    fifo inst(clk, reset, wen, ren, wdata, rdata, full, empty);

    initial begin
        $monitor("Time:%t, clk:%b, reset:%b, wen:%b, ren:%b, wdata:%d, rdata:%d, full:%b, empty:%b", $time, clk, reset, wen, ren, wdata, rdata, full, empty);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        reset = 1;
        #2;
        reset = 0;
        wen=1;

        write(45);
        write(46);
        write(47);
        write(48);
        write(49);

        write(35);
        write(36);
        write(37);
        write(38);
        write(39);

        write(25);
        write(26);
        write(27);
        write(28);
        write(29);

        write(15);
        write(16);
        write(17);
        write(18);
        write(19);

        ren=1;

        write(75);
        write(76);
        write(77);
        write(78);
        write(79);
        wen=0;
        #32;
        $finish;
    end


    task write(input [7:0]data);
        begin
            wdata = data;
            #2;
        end
    endtask
endmodule;