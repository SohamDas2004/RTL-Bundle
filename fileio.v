module fileio;
    reg clk, testfail,fread_enable;
    integer inf, outf, expf,status_exp_read,status_read;
    reg [15:0] din, dout, exp;


    initial begin  
        //$monitor("Time:%t, gin:%b, bout:%b ", $time, grayval, binval);
        $dumpfile("dump.vcd");
        $dumpvars(0,fileio);

        clk = 0;
        testfail = 0;
        fread_enable = 0;

        inf = $fopen("input.txt", "r");
        expf = $fopen("expected.txt", "r");
        outf = $fopen("output.txt", "w");
    end

    always #1 clk = ~clk;


    initial begin  // reading from file
        #5;

        while (!$feof(inf)) begin
            @ (negedge clk);
            fread_enable = 1;
            status_read = $fscanf(inf, "%h %h \n", din[15:8], din[7:0]);
            @ (negedge clk);
        end

        #15;
        $fclose(inf);
        $fclose(outf);
        $fclose(expf);

        if (testfail)
            $display("Tests have failed ");
        else
            $display("Tests Passed");

        $finish;
    end

    always @(posedge clk)  // modify the read value and write the output to file. compare o/p with expcted.
    begin
        if (fread_enable) begin
            fread_enable = 0;
            dout = din + 1;
            $fwrite(outf, "%h %h \n", dout[15:8], dout[7:0]);

            status_exp_read = $fscanf(expf, "%h %h \n", exp[15:8], exp[7:0]);

            if (dout != exp)
            begin
                $display("Test Fail. in:%h, Expcted:%h, Output:%h", din, exp, dout);
                testfail = 1;
            end
            else
            begin
                $display("in:%h , Expcted:%h, Output:%h ",  din, exp, dout);
            end
        end

    end
endmodule;