// SR Latch 

// Behavioral code
module sr_latch_1(input wire s,r , output reg q,qbar);

    always @(s,r) begin
    
        case ({s,r})
            2'b00: begin q<=q; qbar<=qbar; end
            2'b01: begin q<=1'b0; qbar<=1'b1; end
            2'b10: begin q<=1'b1; qbar<=1'b0; end
            2'b11: begin q<=1'bx; qbar<=1'bx; end
        endcase
    end
endmodule;


module tb;
    reg s,r;
    input wire q,qbar;
    reg [1:0] sr_array[0:9];
    integer i;

    sr_latch_1 sr_latch_instance(s,r,q,qbar);

    initial begin
        $monitor("Time:%t, S:%b, R:%b, Q:%b, Qbar:%b ", $time, s,r,q,qbar);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

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
            #1;
        end
    
        #1;
        $finish;

    end

endmodule