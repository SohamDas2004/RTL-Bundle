// Mealy Overlapping. Detect of Pattern 1001.


module seq_detector_1001(input wire clk, reset, inbit, output reg detect);
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;


    reg [1:0] state, next_state;

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
                    detect = 0;
                end
                B:begin
                    if (inbit == 0) next_state = C;
                    else next_state = B;
                    detect = 0;
                end
                C:begin
                    if (inbit == 0) next_state = D;
                    else next_state = B;
                    detect = 0;
                end
                D:begin
                    if (inbit == 0)
                    begin
                        next_state = A;
                        detect = 0;
                    end
                    else 
                    begin
                        next_state = B;
                        detect = 1;
                    end
                end
            endcase
            state = next_state;
        end
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
        drive_bit(1'b1);  // det = 1001
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