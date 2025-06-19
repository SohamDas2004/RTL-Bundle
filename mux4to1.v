// Multiplexor 4input to 1 output. So 2 control signals.

module mux_4to1_1(i0,i1,i2,i3, s0,s1,y);
    input wire [2:0]i0,i1,i2,i3;
    input wire s1,s0;
    output reg [2:0]y;

    always @(i0,i1,i2,i3,s1,s0)
    begin
        case ({s1,s0})
            2'b00: y<=i0;
            2'b01: y<=i1;
            2'b10: y<=i2;
            2'b11: y<=i3;
        endcase
    end
endmodule;


module mux_4to1_2(i0,i1,i2,i3, s0,s1,y);
    input wire [2:0]i0,i1,i2,i3;
    input wire s1,s0;
    output wire [2:0]y;

    assign y = s1 ? (s0 ? i3:i2) : (s0 ? i1:i0); // tertiary statement

endmodule;

module tb;
    wire [2:0]y;
    reg s1,s0;
    reg [2:0]i0,i1,i2,i3;

    mux_4to1_2 mux_instance(i0,i1,i2,i3,s0,s1,y);

    initial begin
        $monitor("Time:%t, i0:%b, i1:%b, i2:%b, i3:%b, s1:%b, s0:%b, y:%b", $time, i0,i1,i2,i3,s1,s0,y);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        i0 = 3'b010;
        i1 = 3'b011;
        i2 = 3'b101;
        i3 = 3'b110;
        s0 = 1'b0;
        s1 = 1'b0;

        #6;
        $finish;
    end

    always #1 s0 = ~s0;
    always #2 s1 = ~s1; 

endmodule