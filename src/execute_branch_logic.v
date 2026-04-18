`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: execute_branch_logic
// Description:
// Determines whether a branch should be taken.
//
//////////////////////////////////////////////////////////////////////////////////

module execute_branch_logic(

    input wire [31:0] operand1,
    input wire [31:0] operand2,
    input wire [2:0] funct3,

    output reg branch_taken

    );

    always @(*) begin

        branch_taken = 0;

        case(funct3)

            3'b000: branch_taken = (operand1 == operand2); // BEQ
            3'b001: branch_taken = (operand1 != operand2); // BNE
            3'b100: branch_taken = ($signed(operand1) < $signed(operand2)); // BLT
            3'b101: branch_taken = ($signed(operand1) >= $signed(operand2)); // BGE

        endcase

    end

endmodule