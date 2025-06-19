// NAND Gate Modelling

// gate level circuit
module nand_gatelevel(output wire F,  input wire A, input wire B);
    wire Fand;
    and(Fand, A, B);
    not(F,Fand);
endmodule


//data_flow model
module nand_data_flow(output wire F,  input wire A, input wire B);
    assign F = ~(A & B);
endmodule


// Behavioural Model of the AND gate.
module nand_behave(output reg F,  input wire A, input wire B);
    always @ (A or B) begin
        if ((A == 1'b1)  &  (B == 1'b1))
        begin
            F = 1'b0;
        end
        else
        begin
            F = 1'b1;
        end
    end
endmodule  

module tb;
    reg A1,B1;
    wire F1;

    nand_gatelevel instance0(F1, A1, B1);
    //nand_data_flow instance1(F1, A1, B1);
    //nand_behave instance2(F1, A1, B1);

    initial begin
        A1 = 0; B1 = 0;
        #1  A1 = 0; B1 = 1;
        #1  A1 = 1; B1 = 0;
        #1  A1 = 1; B1 = 1;
        #1;
    end

    initial begin
        $display("NAND gate circuit");
        $monitor("%t A1=%d, B1=%d, F1=%d" , $time, A1,B1,F1);
        $dumpfile("dump.vcd");
        $dumpvars();
    end
endmodule