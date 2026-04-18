`timescale 1ns / 1ps

module tb_execute_alu_decoder;

    reg [31:0] instruction;
    wire [3:0] alu_op;

    execute_alu_decoder uut(
        .instruction(instruction),
        .alu_op(alu_op)
    );

    initial begin

        // ADD
        instruction = 32'h002081B3;
        #10;

        // SUB
        instruction = 32'h402081B3;
        #10;

        // AND
        instruction = 32'h0020F1B3;
        #10;

        // OR
        instruction = 32'h0020E1B3;
        #10;

        // XOR
        instruction = 32'h0020C1B3;
        #10;

        $finish;

    end

endmodule