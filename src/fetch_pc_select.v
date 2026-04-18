`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: fetch_pc_select
// Description:
// Selects next PC source between sequential PC+4 and branch target.
//
//////////////////////////////////////////////////////////////////////////////////


module fetch_pc_select(
    input wire branch_taken,
    input wire [31:0] incremented_pc,
    input wire [31:0] branch_pc,
    output wire [31:0] selected_pc);
    
    assign selected_pc = (branch_taken) ? branch_pc : incremented_pc;
endmodule