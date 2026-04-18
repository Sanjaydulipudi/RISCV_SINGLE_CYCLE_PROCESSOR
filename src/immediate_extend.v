`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: immediate_extend
// Description:
// Extracts and sign-extends immediate values from instruction.
//
//////////////////////////////////////////////////////////////////////////////////

module immediate_extend(

    input wire [31:0] instruction,
    output reg [31:0] imm_out

    );

    wire [6:0] opcode;
    assign opcode = instruction[6:0];

    always @(*) begin
    case (instruction[6:0])

        // I-type (addi, lw)
        7'b0010011,
        7'b0000011:
            imm_out = {{20{instruction[31]}}, instruction[31:20]};

        // S-type (sw)
        7'b0100011:
            imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

        // B-type (branch)  🔥 CRITICAL
        7'b1100011:
            imm_out = {{19{instruction[31]}},
                       instruction[31],
                       instruction[7],
                       instruction[30:25],
                       instruction[11:8],
                       1'b0};   // already shifted

        default:
            imm_out = 0;
    endcase
end

endmodule