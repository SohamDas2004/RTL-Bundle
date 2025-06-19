// bcd to xs3


module bcd_2_excess3(input [3:0]din, output [3:0]dout);


    assign dout = (din == 0) ? 3 :
                (din == 1) ? 4 :
                (din == 2) ? 5 :
                (din == 3) ? 6 :
                (din == 4) ? 7 :
                (din == 5) ? 8 :
                (din == 6) ? 9 :
                (din == 7) ? 10 :
                (din == 8) ? 11 :
                (din == 9) ? 12 :
                4'bxxxx;
endmodule;


module tb;
    output reg [3:0]din;
    input wire [3:0]dout;
    integer i;

    bcd_2_excess3   inst0(din,dout);

    initial begin
        $monitor("Time:%t, din:%b, dout:%b ", $time, din, dout);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        for (i = 0; i < 16; i++)
        begin

            din = i;
            #1;
        end

        $finish;
    end
endmodule;