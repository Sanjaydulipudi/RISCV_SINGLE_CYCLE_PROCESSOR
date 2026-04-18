`timescale 1ns / 1ps

module tb_execute_branch_logic;

    reg [31:0] op1, op2;
    reg [2:0] funct3;

    wire branch_taken;

    execute_branch_logic uut(
        .operand1(op1),
        .operand2(op2),
        .funct3(funct3),
        .branch_taken(branch_taken)
    );

    initial begin

        op1 = 10; op2 = 10; funct3 = 3'b000; #10; // BEQ → 1
        op1 = 10; op2 = 5;  funct3 = 3'b001; #10; // BNE → 1
        op1 = 5;  op2 = 10; funct3 = 3'b100; #10; // BLT → 1
        op1 = 10; op2 = 5;  funct3 = 3'b101; #10; // BGE → 1

        $finish;

    end

endmodule