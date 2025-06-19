// Reading into reg memory from a file.
// Writing from reg memory to a file.



module tb;
    
    reg [31:0] mem[0:7];     
    integer i;
    

    initial begin

        $readmemh("data.txt", mem);
        #2;

        for (i = 0; i < 8; i++)
            $display("i=%d, memval=%h ", i,mem[i]);


        $writememh("wdata.hex", mem);
        #1;
        $finish;

    end

endmodule