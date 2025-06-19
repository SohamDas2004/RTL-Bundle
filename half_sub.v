// Half Subtractor


// Gate Level Model
module half_sub_1(input A,B, output D,Bo);
    wire invA;
    xor xor_instance(D,A,B);
    not not_instance(invA, A);
    and and_instance(Bo, invA, B);
endmodule

// Data Flow Level Model
module half_sub_2(input A,B, output D,Bo);

    assign D = A ^ B;
    assign Bo = (~A)&B;

endmodule

// Behavioural Level Model
module half_sub_3(input A,B, output reg D,Bo);

    always @(A or B)
    begin
        case ({A,B})
        2'b00: begin D=0; Bo=0; end
        2'b01: begin D=1; Bo=1; end
        2'b10: begin D=1; Bo=0; end
        2'b11: begin D=0; Bo=0; end
        endcase
    end

endmodule


module tb;
    wire tb_D,tb_Bo;
    reg tb_A,tb_B;

    half_sub_3  instance_hs(.A(tb_A), .B(tb_B) ,.D(tb_D), .Bo(tb_Bo));

    initial begin
        $monitor("Time:%t, A:%b, B:%b, D:%b, Bo:%b, ", $time, tb_A, tb_B, tb_D, tb_Bo);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
    end

    initial begin
        tb_A = 0; tb_B = 0;
        #1  tb_A = 0; tb_B = 1;
        #1  tb_A = 1; tb_B = 0;
        #2  tb_A = 1; tb_B = 1;
        #1  tb_A = 0; tb_B = 0;
        #2
        $finish;
    end

endmodule