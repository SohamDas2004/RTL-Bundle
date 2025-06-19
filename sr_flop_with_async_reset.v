// SR Flop  with ASyncronous Reset

// Behavioral code
module sr_flop_async_reset_1(input wire clk, reset, s,r , output reg q,qbar);

    always @(posedge clk or posedge reset) begin

        if (reset)
        begin
            q<=1'bx; 
            qbar<=1'bx; 
        end
        else
        begin
            case ({s,r})
                2'b00: begin q<=q; qbar<=qbar; end
                2'b01: begin q<=1'b0; qbar<=1'b1; end
                2'b10: begin q<=1'b1; qbar<=1'b0; end
                2'b11: begin q<=1'bx; qbar<=1'bx; end
            endcase
        end
    end
endmodule;

module tb;
    reg s,r, clk, reset;
    input wire q,qbar;
    reg [1:0] sr_array[0:9];
    integer i;

    sr_flop_async_reset_1 sr_flop_instance(clk,reset,s,r,q,qbar);

    initial begin
        $monitor("Time:%t, clk:%b, reset=%b, S:%b, R:%b, Q:%b, Qbar:%b ", $time, clk,reset, s,r,q,qbar);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        reset = 0;
        forever #1 clk = ~clk;
    end

    initial begin

        for (i = 0; i < 40; i++)
        begin
            {reset, s,r} = $random & 3'b111;
            #3;
        end
        
        $finish;

    end

endmodule