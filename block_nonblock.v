// Blocking and NonBlocking example

module tb;

    reg[7:0] A,B,C,D,E,F;


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();

        A=3;
        B=4;
        C=5;
        D=6;
        E=7;
        F=8;
        $display("Blocking1 A=%h, B=%h, C=%h, D=%h, E=%h, F=%h", A,B,C,D,E,F);

        #5

        A=E;
        B=A;
        $display("Blocking2 A=%h, B=%h, C=%h, D=%h, E=%h, F=%h", A,B,C,D,E,F);

        #5

        C <= F;  #  non blocking assignment
        D <= C;  #  non blocking assignment
        F <= A;
        #1
        $display("Non Blocking3 A=%h, B=%h, C=%h, D=%h, E=%h, F=%h", A,B,C,D,E,F);
    end

endmodule;