// JK Master Slave Flip Flop

module jkff_1(input wire clk, clear, j, k, output reg q, qbar);

    always @(posedge clk or posedge clear)
    begin

        if (clear)
        begin
            q = 1'b0;
            qbar = 1'b1;
        end
        else  begin
            case ({j,k})

                2'b01: begin q=1'b0; qbar = 1'b1; end
                2'b10: begin q=1'b1; qbar = 1'b0; end
                2'b11: begin q=~q;  qbar = ~q; end
            endcase
        end
    end
endmodule

module jkms_1(input wire clk, clear,j,k, inout wire q,qbar);
    wire clk_inv;
    wire qm, qmbar;
    not not_instance(clk_inv, clk);

    jkff_1 m_instance(.clk(clk), .clear(clear),.j(j),.k(k),.q(qm),.qbar(qmbar) );

    jkff_1 s_instance(.clk(clk_inv),.clear(clear), .j(qm), .k(qmbar), .q(q),.qbar(qbar));

endmodule;

module tb;
    output reg clk, clear, j,k;
    input wire q,qbar;

    jkms_1  jkms_instance(clk, clear, j,k,q,qbar);

    initial begin
        $monitor("Time:%t, clk:%b, clear:%b, j=%b, k=%b, q:%b, qbar:%b ", $time, clk,clear, j,k,q,qbar);
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
        #3;
        clear = 1'b1;
        #1;
        clear = 1'b0;
        #1
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