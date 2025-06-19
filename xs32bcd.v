// xs3 to bcd


module excess3_2_bcd(input [3:0]din, output [3:0]dout);


    assign dout = (din == 3) ? 0 :
                (din == 4) ? 1 :
                (din == 5) ? 2 :
                (din == 6) ? 3 :
                (din == 7) ? 4 :
                (din == 8) ? 5 :
                (din == 9) ? 6 :
                (din == 10) ? 7 :
                (din == 11) ? 8 :
                (din == 12) ? 9 :
                4'bxxxx;
endmodule;


module tb;
    output reg [3:0]din;
    input wire [3:0]dout;
    integer i;

    excess3_2_bcd   inst0(din,dout);

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