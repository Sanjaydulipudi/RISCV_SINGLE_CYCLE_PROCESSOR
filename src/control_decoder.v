`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Create Date: 18.04.2026 12:33:57
// Module Name: control_decoder
// Project Name: 5-Stage Pipelined RISC-V CPU
// Description:
// Decodes instruction opcode into control signals for datapath.
//
//////////////////////////////////////////////////////////////////////////////////


module control_decoder(
    input wire [31:0] instruction,
    output reg reg_write,
    output reg alu_src,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg branch 
);
    wire [6:0] opcode = instruction[6:0];

    always @(*) begin
        // Default values to prevent latches
        reg_write  = 0; alu_src = 0; mem_read = 0;
        mem_write  = 0; mem_to_reg = 0; branch = 0;

        case (opcode)
            7'b0110011: reg_write = 1; // R-type
            7'b0010011: begin          // I-type
                reg_write = 1;
                alu_src   = 1;
            end
            7'b0000011: begin          // LW
                reg_write = 1; alu_src = 1;
                mem_read  = 1; mem_to_reg = 1;
            end
            7'b0100011: begin          // SW
                alu_src   = 1; mem_write = 1;
            end    
            7'b1100011: branch = 1;    // Branch
        endcase
    end
endmodule