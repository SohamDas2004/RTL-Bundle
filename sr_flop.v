// SR Flop 

// Behavioral code
module sr_flop_1(input wire clk, s,r , output reg q,qbar);

    always @(posedge clk) begin
    
        case ({s,r})
            2'b00: begin q<=q; qbar<=qbar; end
            2'b01: begin q<=1'b0; qbar<=1'b1; end
            2'b10: begin q<=1'b1; qbar<=1'b0; end
            2'b11: begin q<=1'bx; qbar<=1'bx; end
        endcase
    end
endmodule;


module tb;
    reg s,r, clk;
    input wire q,qbar;
    reg [1:0] sr_array[0:9];
    integer i;

    sr_flop_1 sr_flop_instance(clk,s,r,q,qbar);

    initial begin
        $monitor("Time:%t, clk:%b, S:%b, R:%b, Q:%b, Qbar:%b ", $time, clk,s,r,q,qbar);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin


        sr_array[0] = 2'b00;
        sr_array[1] = 2'b01;
        sr_array[2] = 2'b00;
        sr_array[3] = 2'b11;
        sr_array[4] = 2'b00;
        sr_array[5] = 2'b10;
        sr_array[6] = 2'b00;
        sr_array[7] = 2'b01;
        sr_array[8] = 2'b10;
        sr_array[9] = 2'b11;

        for (i = 0; i < 10; i++)
        begin
            {s,r} = sr_array[i];
            //{s,r} = $random & 2'b11;
            #3;
        end
        $finish;

    end

endmodule