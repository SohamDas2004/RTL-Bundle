module d_flip_flop (
 input clk,
 input reset,
 input d,
 output reg q,
 output wire qbar
);
     always @(posedge clk or posedge reset) 
     begin
         if (reset)
            q <= 0;
         else
            q <= d;
     end

     assign qbar = ~q;  
endmodule

module sync_up_counter (
 input clk,
 input reset,
 output [3:0] count
);
 wire [3:0] d;
 wire [3:0] q;
 wire [3:0] qbar;

 // Assigning output
 assign count = q;

 // D Flip-Flop logic for synchronous up counter
 //assign d[0] = ~q[0];
 //assign d[1] = q[0] ^ q[1];
 //assign d[2] = (q[0] & q[1]) ^ q[2];
 //assign d[3] = (q[0] & q[1] & q[2]) ^ q[3];

 // Instantiate D flip-flops
 d_flip_flop dff0 (.clk(clk), .reset(reset), .d(qbar[0]), .q(q[0]), .qbar(qbar[0]) );
 d_flip_flop dff1 (.clk(clk), .reset(reset), .d(q[0] ^ q[1]), .q(q[1]), .qbar(qbar[1]) );
 d_flip_flop dff2 (.clk(clk), .reset(reset), .d((q[0] & q[1]) ^ q[2]), .q(q[2]), .qbar(qbar[2]) );
 d_flip_flop dff3 (.clk(clk), .reset(reset), .d((q[0] & q[1] & q[2]) ^ q[3]), .q(q[3]), .qbar(qbar[3]) );

endmodule

module tb_sync_up_counter;
 reg clk, reset;
 wire [3:0] count;

 // Instantiate the counter
 sync_up_counter uut (
 .clk(clk),
 .reset(reset),
 .count(count)
 );

 // Clock generation
 initial begin
     clk = 0;
     forever #5 clk = ~clk; // 10 time unit clock period
 end

 // Stimulus
 initial begin
     reset = 1;
     #10;
     reset = 0;
     #200;
     $finish;
 end

 // Monitor output
 initial begin
    $monitor("Time = %0t | Count = %b", $time, count);
 end

 // Dump VCD for GTKWave
 initial begin
     $dumpfile("dump.vcd"); // Output file
     $dumpvars(0, tb_sync_up_counter); // Dump all variables in this module
 end
endmodule