// Half Adder

// Gate Level Model.
module half_adder_1(input A,B, output S,C);
    xor instance_xor_gate(S,A,B);
    and instance_and_gate(C,A,B);
endmodule

// Data Flow Level Model.
module half_adder_2(input A,B, output S,C);
    assign S = A ^ B;
    assign C = A & B;
endmodule

// Behavioural Model
module half_adder_3(input A,B, output reg S,C);

    always @(A or B)
    begin
        case ({A,B})
        2'b00: begin S=0; C=0; end
        2'b01: begin S=1; C=0; end
        2'b10: begin S=1; C=0; end
        2'b11: begin S=1; C=1; end
        endcase
    end
endmodule

module half_adder_tb;
    reg tb_A, tb_B;
    wire tb_S, tb_C;

    half_adder_3 instance_ha(tb_A, tb_B, tb_S, tb_C);

    initial begin
        $monitor("Time:%t, A:%b, B:%b, S:%b, C:%b ", $time, tb_A, tb_B, tb_S, tb_C);
        $dumpfile("dump.vcd");
        $dumpvars();

        tb_A = 0; tb_B = 0;
        #1;        tb_A = 0; tb_B = 1;
        #1;        tb_A = 1; tb_B = 0;
        #1;        tb_A = 1; tb_B = 1;
        #1;        tb_A = 0; tb_B = 0;
        #1;        $finish();
    end
endmodule