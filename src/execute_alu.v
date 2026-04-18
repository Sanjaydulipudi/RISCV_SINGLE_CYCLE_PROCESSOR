`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: execute_alu
// Description:
// Performs arithmetic and logic operations based on alu_op.
//
//////////////////////////////////////////////////////////////////////////////////


module execute_alu(
    input wire [31:0] operand1,
    input wire [31:0] operand2,
    input wire [3:0] alu_op,
    output reg [31:0] result
);
    always @(*) begin
        case(alu_op)
            4'b0000: result = operand1 + operand2; // ADD
            4'b0001: result = operand1 - operand2; // SUB
            4'b0010: result = operand1 & operand2; // AND
            4'b0011: result = operand1 | operand2; // OR
            4'b0100: result = operand1 ^ operand2; // XOR
            default: result = 32'h0;
        endcase
    end
endmodule