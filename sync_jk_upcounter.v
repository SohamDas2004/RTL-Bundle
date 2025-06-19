module jkff_1(input wire clk, j, k, clear, output reg q, qbar);

    always @(posedge clk or posedge clear)
    begin
        if (clear)
            q = 0;
        else
        begin
            case ({j,k})

                2'b01: begin q=1'b0; qbar = 1'b1; end
                2'b10: begin q=1'b1; qbar = 1'b0; end
                2'b11: begin q=~q;  qbar = ~q; end
            endcase
        end
    end
endmodule

module sync_up_counter ( input clk,  input reset, output [3:0] count );
    wire [3:0] d;
    wire [3:0] q;
    wire [3:0] qbar;

    // Assigning output
    assign count = q;

    // Instantiate jk flip-flops

    jkff_1 ff0 (.clk(clk), .j(1'b1), .k(1'b1), .clear(reset), .q(q[0]), .qbar(qbar[0]) );
    jkff_1 ff1 (.clk(clk), .j(q[0]), .k(q[0]), .clear(reset), .q(q[1]), .qbar(qbar[0]) );
    jkff_1 ff2 (.clk(clk), .j(q[0] & q[1]), .k(q[0]&q[1]), .clear(reset), .q(q[2]), .qbar(qbar[0]) );
    jkff_1 ff3 (.clk(clk), .j(q[0] & q[1] & q[2]), .k(q[0]&q[1]&q[2]), .clear(reset), .q(q[3]), .qbar(qbar[0]) );


endmodule

module tb;
 reg clk, reset;
 wire [3:0] count;

 // Instantiate the counter
 sync_up_counter uut ( .clk(clk), .reset(reset), .count(count) );

 // Clock generation
 initial begin
     clk = 0;
     forever #1 clk = ~clk; // 10 time unit clock period
 end

 // Stimulus
 initial begin
     #10;
     reset = 0;
     #10;
     reset = 1;
     #10;
     reset = 0;
     #40;
     $finish;
 end

 initial begin
    $monitor("Time = %0t | Count = %b", $time, count);  // Monitor output
    $dumpfile("dump.vcd"); // Output file   // Dump VCD for GTKWave
    $dumpvars(0, tb); // Dump all variables in this module // Dump VCD for GTKWave
 end 
endmodule