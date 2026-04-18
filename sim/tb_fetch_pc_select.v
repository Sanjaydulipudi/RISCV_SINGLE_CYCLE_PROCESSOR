`timescale 1ns / 1ps

module tb_fetch_pc_select;
    reg branch_taken;
    reg [31:0] incremented_pc;
    reg [31:0] branch_pc;
    wire [31:0] selected_pc;
    
    fetch_pc_select uut(
        .branch_taken(branch_taken),
        .incremented_pc(incremented_pc),
        .branch_pc(branch_pc),
        .selected_pc(selected_pc)
    );

    initial begin
        incremented_pc = 32'd4;
        branch_pc = 32'd100;
        branch_taken = 0;
        #10;
        branch_taken = 1;
        #10;
        branch_taken = 0;
        #10;
        $finish;
    end
endmodule