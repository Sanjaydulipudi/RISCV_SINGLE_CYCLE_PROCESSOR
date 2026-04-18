`timescale 1ns / 1ps

module tb_instruction_mem;

    reg [31:0] current_pc;

    wire [31:0] instruction_out;

    instruction_mem uut(

        .current_pc(current_pc),
        .instruction_out(instruction_out)

    );

    initial begin

        current_pc = 0;
        #10;

        current_pc = 4;
        #10;

        current_pc = 8;
        #10;

        current_pc = 12;
        #10;

        $finish;

    end

endmodule