// JK Flop.

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


module tb;
    output reg clk, j, k, clear;
    input wire q,qbar;

    jkff_1  jkinstance(clk, j,k,q,qbar);
    
    initial begin
        $monitor("Time:%t, clk:%b, j=%b, k=%b, q:%b, qbar:%b ", $time, clk,j,k,q,qbar);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
        clk = 0;
        forever #1 clk = ~clk;
    end

    task drivejk(input [1:0]jk);
        begin
            {j,k} = jk;
            #3;
        end
    endtask;  
    
    initial begin
        drivejk(2'b00);
        drivejk(2'b11);
        drivejk(2'b01);
        drivejk(2'b10);
        drivejk(2'b11);
        drivejk(2'b11);
        drivejk(2'b00);
        drivejk(2'b11);
        $finish;
    end
endmodule