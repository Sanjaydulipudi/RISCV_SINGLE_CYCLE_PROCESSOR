`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Create Date: 15.04.2026 09:43:44
// Design Name:
// Module Name: fetch_pc
// Project Name: Design and Verification of a 32-bit 5-Stage Pipelined RISC-V Processor
//               with Hazard Detection and Forwarding using Verilog HDL
// Target Devices:
// Tool Versions:
// Description:
// Program Counter Register
// Stores the current instruction address and updates every clock cycle.
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module fetch_pc(
    input wire clk,
    input wire rst,
    input wire [31:0] next_pc,
    output reg [31:0] current_pc
    );

 always @(posedge clk or posedge rst) begin
    if (rst)
        current_pc <= 32'd0;
    else
        current_pc <= next_pc;
end
endmodule