`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: riscv_cpu_top
// Description:
// Top module of 32-bit Single Cycle RISC-V CPU
// Connects all processor blocks together.
//
//////////////////////////////////////////////////////////////////////////////////

module riscv_cpu_top(

    input wire clk,
    input wire rst

);

// ======================================================
// Internal Wires
// ======================================================

// PC Section
wire [31:0] current_pc;
wire [31:0] next_pc;
wire [31:0] pc_plus4;
wire [31:0] branch_target;

// Instruction Section
wire [31:0] instruction;

// Register File Section
wire [31:0] reg_data1;
wire [31:0] reg_data2;

// Immediate Section
wire [31:0] imm_out;

// ALU Section
wire [31:0] alu_operand2;
wire [31:0] alu_result;
wire [3:0]  alu_op;

// Memory Section
wire [31:0] mem_data;

// Writeback Section
wire [31:0] writeback_data;

// Control Signals
wire reg_write;
wire alu_src;
wire mem_read;
wire mem_write;
wire mem_to_reg;
wire branch;
wire branch_taken;

// ======================================================
// Program Counter Module
// ======================================================

fetch_pc pc_i(

    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .current_pc(current_pc)

);

// ======================================================
// PC + 4 Calculation
// ======================================================

assign pc_plus4 = current_pc + 4;

// ======================================================
// Branch Target Calculation
// ======================================================

assign branch_target = current_pc + imm_out;

// ======================================================
// Next PC Selection
// If branch taken -> jump
// Else -> normal next instruction
// ======================================================

assign next_pc = branch ? 
                 (branch_taken ? branch_target : pc_plus4)
                 : pc_plus4;

// ======================================================
// Instruction Memory
// ======================================================

instruction_mem imem_i(

    .current_pc(current_pc),
    .instruction_out(instruction)

);

// ======================================================
// Control Unit
// ======================================================

control_decoder ctrl_i(

    .instruction(instruction),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .branch(branch)

);

// ======================================================
// Register File
// ======================================================

register_bank reg_i(

    .clk(clk),
    .rst(rst),
    .reg_write(reg_write),

    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),

    .write_data(writeback_data),

    .read_data1(reg_data1),
    .read_data2(reg_data2)

);

// ======================================================
// Immediate Generator
// ======================================================

immediate_extend imm_i(

    .instruction(instruction),
    .imm_out(imm_out)

);

// ======================================================
// ALU Control Unit
// ======================================================

execute_alu_decoder alu_dec_i(

    .instruction(instruction),
    .alu_op(alu_op)

);

// ======================================================
// ALU Input Selection
// If alu_src = 1 -> immediate
// Else -> register data
// ======================================================

assign alu_operand2 = alu_src ? imm_out : reg_data2;

// ======================================================
// ALU
// ======================================================

execute_alu alu_i(

    .operand1(reg_data1),
    .operand2(alu_operand2),
    .alu_op(alu_op),
    .result(alu_result)

);

// ======================================================
// Branch Comparator
// ======================================================

execute_branch_logic br_i(

    .operand1(reg_data1),
    .operand2(reg_data2),
    .funct3(instruction[14:12]),
    .branch_taken(branch_taken)

);

// ======================================================
// Data Memory
// ======================================================

data_memory dmem_i(

    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(alu_result),
    .write_data(reg_data2),
    .read_data(mem_data)

);

// ======================================================
// Writeback Selection
// If load instruction -> memory data
// Else -> ALU result
// ======================================================

assign writeback_data = mem_to_reg ? mem_data : alu_result;
endmodule
