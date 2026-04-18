`timescale 1ns / 1ps

module tb_control_decoder;

    reg [31:0] instruction;

    wire reg_write;
    wire alu_src;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;

control_decoder uut(
    .instruction(instruction),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .branch(branch) 
);

    initial begin

        // R-type
        instruction = 32'h002081B3;
        #10;

        // I-type
        instruction = 32'h00500093;
        #10;

        // Load
        instruction = 32'h00002183;
        #10;

        // Store
        instruction = 32'h00102023;
        #10;

        $finish;

    end

endmodule