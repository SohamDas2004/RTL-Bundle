// Full Subtractor


// Data Flow Model
module full_sub_1(input A,B, Bin,  output D, Bo);
    assign D = A ^ B ^ Bin;
    assign Bo = (  (~(A^B))  & Bin)  |     ( (~A) & B  );
endmodule

// Behavioural Flow Model
module full_sub_2(input A,B, Bin,  output reg D, Bo);
    always @(A or B or Bin)
    begin
        case ({A,B,Bin})
        3'b000: begin D=0; Bo=0; end
        3'b001: begin D=1; Bo=1; end
        3'b010: begin D=1; Bo=1; end
        3'b011: begin D=0; Bo=1; end
        3'b100: begin D=1; Bo=0; end
        3'b101: begin D=0; Bo=0; end
        3'b110: begin D=0; Bo=0; end
        3'b111: begin D=1; Bo=1; end
        endcase
    end
endmodule

module tb;
    reg A,B,Bin;
    wire D, Bo;

    full_sub_2 full_sub_instance(A,B,Bin,D,Bo);

    initial begin
        $monitor("Time:%t, A:%b, B:%b, Bin:%b, D:%b, Bo:%b ", $time, A, B, Bin, D, Bo);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        A = 0; B = 0; Bin = 0;

        #16
        $finish();
    end

    always #8 A = ~A;
    always #4 B = ~B;
    always #2 Bin = ~Bin;

endmodule  