// de multiplexor 1 to 4.  input bus size is 3 bits.


// behavioural model
module demux_1to4_1(input [2:0]din, input [1:0]s, output reg [11:0]yout);

    always@(s, din) begin

        case (s)
            2'b00: begin  yout = 0; yout[2:0] = din; end
            2'b01: begin  yout = 0; yout[5:3] = din; end
            2'b10: begin  yout = 0; yout[8:6] = din; end
            2'b11: begin  yout = 0; yout[11:9] = din; end
        endcase
    end

endmodule;

module tb;
    output reg[2:0]din;
    output reg[1:0]s;
    input wire [11:0]yout;

    demux_1to4_1 demux_instance(din,s,yout);

    initial begin
        $monitor("Time:%t, din:%b, s:%b, y0:%b, y1:%b, y2:%b, y3:%b,", $time, din,s,yout[2:0], yout[5:3], yout[8:6], yout[11:9]);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        din = 3'b111;
        s = 2'b00;
        #1 s = 2'b01;
        #1 s =2'b10;
        #1 s = 2'b11;
        #1 s = 2'b00;
        $finish;
    end
endmodule;