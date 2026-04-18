`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Create Date:
// Design Name:
// Module Name: fetch_next_pc
// Project Name: Design and Verification of a 32-bit 5-Stage Pipelined RISC-V Processor
//               with Hazard Detection and Forwarding using Verilog HDL
// Description:
// Adds 4 to current PC to generate next sequential instruction address.
//
//////////////////////////////////////////////////////////////////////////////////


module fetch_next_pc(
    input wire [31:0] current_pc,
    output wire [31:0] incremented_pc);

    assign incremented_pc = current_pc + 32'd4;
endmodule