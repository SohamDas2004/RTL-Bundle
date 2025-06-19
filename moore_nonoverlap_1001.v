// Moore Non Overlapping. Detect of Pattern 1001.


module seq_detector_1001(input wire clk, reset, inbit, output reg detect);
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;


    reg [2:0] state, next_state;

    always @(posedge clk)
    begin
        if (reset)
        begin
            state = A;
        end
        else
        begin
            case (state)
                A:begin
                    if (inbit == 0) next_state = A;
                    else next_state = B;
                end
                B:begin
                    if (inbit == 0) next_state = C;
                    else next_state = B;
                end
                C:begin
                    if (inbit == 0) next_state = D;
                    else next_state = B;
                end
                D:begin
                    if (inbit == 0) next_state = A;
                    else next_state = E;
                end
                E:begin
                    if (inbit == 0) next_state = A;
                    else next_state = B;
                end
            endcase
            state = next_state;
        end
    end

    always @(state)
    begin
        case (state)
            A: detect = 0;
            B: detect = 0;
            C: detect = 0;
            D: detect = 0;
            E: detect = 1;
            default: detect = 1'bx;
        endcase
    end
endmodule;


module tb;
    reg clk, reset,inbit;
    input wire detect;

    seq_detector_1001 inst0 (clk, reset, inbit, detect);

    initial begin
        $monitor("Time:%t, clk:%b, reset:%b, inbit:%b, detect:%b ", $time, clk, reset, inbit, detect);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        inbit = 0;
        clk = 0;
        forever #1 clk = ~clk;
    end

    task drive_bit(input data);
    begin
        inbit = data; #2;
    end
    endtask;

    initial begin
        reset = 1; #2; reset = 0;

        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1); // det = 1001
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b1); // det = 1001
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b0);
        drive_bit(1'b1);
        drive_bit(1'b1);    // det 1011
        drive_bit(1'b0);
        drive_bit(1'b0);
        drive_bit(1'b0);



        $finish;
    end

endmodule;