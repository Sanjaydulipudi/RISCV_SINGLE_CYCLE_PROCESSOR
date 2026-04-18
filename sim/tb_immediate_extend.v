`timescale 1ns / 1ps

module tb_immediate_extend;

    reg [31:0] instruction;
    wire [31:0] imm_out;

    immediate_extend uut(
        .instruction(instruction),
        .imm_out(imm_out)
    );

    initial begin

        // I-type (addi x1,x0,5)
        instruction = 32'h00500093;
        #10;

        // I-type negative (addi x1,x0,-1)
        instruction = 32'hFFF00093;
        #10;

        // S-type (store)
        instruction = 32'h00102023;
        #10;

        // B-type (branch)
        instruction = 32'h00000063;
        #10;

        $finish;

    end

endmodule