`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: instruction_mem
// Description:
// Stores processor instructions and outputs instruction based on PC.
//
//////////////////////////////////////////////////////////////////////////////////

module instruction_mem(

    input wire [31:0] current_pc,
    output wire [31:0] instruction_out

);

reg [31:0] instr_mem [0:31];

initial begin

    instr_mem[0] = 32'h00500093; // addi x1,x0,5
    instr_mem[1] = 32'h00A00113; // addi x2,x0,10
    instr_mem[2] = 32'h002081B3; // add x3,x1,x2
    instr_mem[3] = 32'h00302023; // sw x3,0(x0)
    instr_mem[4] = 32'h00002183; // lw x3,0(x0)
    instr_mem[5] = 32'h00318663; // beq x3,x3,+12
    instr_mem[6] = 32'h00100213; // addi x4,x0,1 (skip)
    instr_mem[7] = 32'h06300293; // addi x5,x0,99

    instr_mem[8]  = 32'h00000013;
    instr_mem[9]  = 32'h00000013;
    instr_mem[10] = 32'h00000013;
    instr_mem[11] = 32'h00000013;
    instr_mem[12] = 32'h00000013;
    instr_mem[13] = 32'h00000013;
    instr_mem[14] = 32'h00000013;
    instr_mem[15] = 32'h00000013;
    instr_mem[16] = 32'h00000013;
    instr_mem[17] = 32'h00000013;
    instr_mem[18] = 32'h00000013;
    instr_mem[19] = 32'h00000013;
    instr_mem[20] = 32'h00000013;
    instr_mem[21] = 32'h00000013;
    instr_mem[22] = 32'h00000013;
    instr_mem[23] = 32'h00000013;
    instr_mem[24] = 32'h00000013;
    instr_mem[25] = 32'h00000013;
    instr_mem[26] = 32'h00000013;
    instr_mem[27] = 32'h00000013;
    instr_mem[28] = 32'h00000013;
    instr_mem[29] = 32'h00000013;
    instr_mem[30] = 32'h00000013;
    instr_mem[31] = 32'h00000013;

end

assign instruction_out = instr_mem[current_pc[31:2]];

endmodule