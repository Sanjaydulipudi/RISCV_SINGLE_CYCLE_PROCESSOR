`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: writeback_mux
// Description:
// Selects data to write back to register file.
//
//////////////////////////////////////////////////////////////////////////////////

module writeback_mux(

    input wire [31:0] alu_result,
    input wire [31:0] mem_data,
    input wire mem_to_reg,

    output wire [31:0] writeback_data

    );

    assign writeback_data = (mem_to_reg) ? mem_data : alu_result;

endmodule