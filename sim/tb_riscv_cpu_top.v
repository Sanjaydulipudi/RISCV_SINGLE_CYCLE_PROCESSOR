`timescale 1ns / 1ps

/* module tb_riscv_cpu_top;

reg clk;
reg rst;

riscv_cpu_top uut(
    .clk(clk),
    .rst(rst)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #10 rst = 0;

    // Wait for execution
    #60;

    // Check ADD result
    if (uut.regfile.reg_array[3] == 15)
        $display("ADD PASSED");
    else
        $display("ADD FAILED");

    #40;

    // Check Branch target result
    if (uut.regfile.reg_array[5] == 99)
        $display("BRANCH PASSED");
    else
        $display("BRANCH FAILED");

    #40;
    $finish;
end

endmodule */

module tb_riscv_cpu_top;
    reg clk;
    reg rst;

    riscv_cpu_top uut(.clk(clk), .rst(rst));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        #15 rst = 0; // Release reset after a clock cycle

        // Execution time for your instruction set
        #150; 

        $display("---------- SIMULATION REPORT ----------");
        
        // Check x3 (Final sum result)
        if (uut.reg_i.reg_array[3] === 32'd15)
            $display("[PASS] Register x3: Correct Result (15)");
        else
            $display("[FAIL] Register x3: Expected 15, Got %d", uut.reg_i.reg_array[3]);

        // Check x5 (Branch target success)
        if (uut.reg_i.reg_array[5] === 32'd99)
            $display("[PASS] Register x5: Branch Logic Verified (99)");
        else
            $display("[FAIL] Register x5: Expected 99, Got %d", uut.reg_i.reg_array[5]);

        $display("---------------------------------------");
        $finish;
    end
endmodule