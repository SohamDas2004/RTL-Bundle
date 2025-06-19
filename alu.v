// ALU with 2 bit operator. input operands are 4 bits.


module alu(input [1:0]opcode, input [3:0]operand1, input [3:0]operand2, output reg [7:0] result, output reg cflag, output reg zflag);


    parameter [1:0]ADD=2'b00, MUL=2'b01, OR=2'b10, AND=2'b11;

    always  @(opcode, operand1, operand2)
    begin
        case (opcode)
        ADD: begin
            result = operand1 + operand2;
            zflag = (result == 8'b0);
            cflag = result[4];
        end

        MUL: begin
            result = operand1 * operand2;
            zflag = (result == 8'b0);
            cflag = result[4];
        end

        OR: begin
            result = operand1 | operand2;
            zflag = (result == 8'b0);
            cflag = result[4];
        end

        AND: begin
            result = operand1 & operand2;
            zflag = (result == 8'b0);
            cflag = result[4];
        end
        endcase
    end
endmodule

module tb;
    output reg [1:0] opcode;
    output reg [3:0] operand1, operand2;
    input wire [7:0] result;
    input wire cflag, zflag;


     alu inst0(opcode,operand1,operand2, result, cflag, zflag);


    initial begin
        $monitor("Time:%t, opcode:%b,operand1:%d_%b,operand2:%d_%b, result:%d, cflag:%b, zflag:%b ", $time, opcode,operand1,operand1,operand2, operand2,result, cflag, zflag);
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);

        opcode = 2'b00;        operand1 = 4;        operand2 = 5;         #2;

        opcode = 2'b00;        operand1 = 12;        operand2 = 5;         #2;

        opcode = 2'b00;        operand1 = 0;        operand2 = 0;         #2;

        opcode = 2'b00;        operand1 = 2;        operand2 = -2;         #2;

        opcode = 2'b11;        operand1 = 2;        operand2 = 6;         #2;
        $finish;
    end

endmodule;