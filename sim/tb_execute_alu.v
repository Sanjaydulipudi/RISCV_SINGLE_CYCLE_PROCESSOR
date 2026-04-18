`timescale 1ns / 1ps

module tb_execute_alu;

    reg [31:0] operand1;
    reg [31:0] operand2;
    reg [3:0] alu_op;

    wire [31:0] result;

    execute_alu uut(
        .operand1(operand1),
        .operand2(operand2),
        .alu_op(alu_op),
        .result(result)
    );

    initial begin

        // ADD
        operand1 = 10;
        operand2 = 5;
        alu_op = 4'b0000;
        #10;

        // SUB
        alu_op = 4'b0001;
        #10;

        // AND
        alu_op = 4'b0010;
        #10;

        // OR
        alu_op = 4'b0011;
        #10;

        // XOR
        alu_op = 4'b0100;
        #10;

        $finish;

    end

endmodule