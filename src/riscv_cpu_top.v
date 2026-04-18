`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: DULIPUDI LAASHMITH SANJAY
//
// Module Name: riscv_cpu_top
// Description:
// Top module integrating all CPU components
//
//////////////////////////////////////////////////////////////////////////////////

/* module riscv_cpu_top(

    input wire clk,
    input wire rst

);

// ================= PC =================
wire [31:0] current_pc;
wire [31:0] next_pc;
wire [31:0] pc_plus4;
wire [31:0] branch_target;

// ================= Instruction =================
wire [31:0] instruction;

// ================= Decode =================
wire reg_write, alu_src, mem_read, mem_write, mem_to_reg;
wire [3:0] alu_op;
wire branch;
wire branch_taken_final;

// ================= Register File =================
wire [31:0] reg_data1, reg_data2;

// ================= Immediate =================
wire [31:0] imm_out;

// ================= ALU =================
wire [31:0] alu_operand2;
wire [31:0] alu_result;

// ================= Branch =================
wire branch_taken;

// ================= Memory =================
wire [31:0] mem_data;

// ================= Writeback =================
wire [31:0] writeback_data;


// ================= PC =================
fetch_pc pc_inst(
    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .current_pc(current_pc)
);

// PC + 4
fetch_next_pc pc_add(
    .current_pc(current_pc),
    .incremented_pc(pc_plus4)
);

// PC Select
fetch_pc_select pc_mux(
    .branch_taken(branch_taken_final),
    .incremented_pc(pc_plus4),
    .branch_pc(branch_target),
    .selected_pc(next_pc)
);

// Instruction Memory
instruction_mem imem(
    .current_pc(current_pc),
    .instruction_out(instruction)
);

// Control Decoder
control_decoder decoder(
    .instruction(instruction),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .mem_to_reg(mem_to_reg),
    .branch(branch)
);

// Register File
register_bank regfile(
    .clk(clk),
    .reg_write(reg_write),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .write_data(writeback_data),
    .read_data1(reg_data1),
    .read_data2(reg_data2)
);

// Immediate Generator
immediate_extend imm_gen(
    .instruction(instruction),
    .imm_out(imm_out)
);

// ALU Decoder
execute_alu_decoder alu_ctrl(
    .instruction(instruction),
    .alu_op(alu_op)
);

// ALU Source MUX
assign alu_operand2 = (alu_src) ? imm_out : reg_data2;

// ALU
execute_alu alu(
    .operand1(reg_data1),
    .operand2(alu_operand2),
    .alu_op(alu_op),
    .result(alu_result)
);

// Branch Compare
execute_branch_logic branch_unit(
    .operand1(reg_data1),
    .operand2(reg_data2),
    .funct3(instruction[14:12]),
    .branch_taken(branch_taken)
);

// Branch Final Enable
assign branch_taken_final = branch & branch_taken;

// Branch Target
assign branch_target = current_pc + imm_out;

// Data Memory
data_memory dmem(
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(alu_result),
    .write_data(reg_data2),
    .read_data(mem_data)
);

// Writeback
writeback_mux wb(
    .alu_result(alu_result),
    .mem_data(mem_data),
    .mem_to_reg(mem_to_reg),
    .writeback_data(writeback_data)
);

endmodule

*/
module riscv_cpu_top(
    input wire clk,
    input wire rst
);
    // Internal Wires
    wire [31:0] current_pc, next_pc, pc_plus4, branch_target;
    wire [31:0] instruction, imm_out, reg_data1, reg_data2;
    wire [31:0] alu_operand2, alu_result, mem_data, writeback_data;
    wire [3:0] alu_op;
    wire reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch, branch_taken;

    // PC Logic
    fetch_pc pc_i (clk, rst, next_pc, current_pc);
    assign pc_plus4 = current_pc + 32'd4;
    assign branch_target = $signed(current_pc) + $signed(imm_out);
    assign next_pc = (branch && branch_taken) ? branch_target : pc_plus4;

    instruction_mem imem_i (current_pc, instruction);

    control_decoder ctrl_i (instruction, reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch);

    register_bank reg_i (clk, rst, reg_write, instruction[19:15], instruction[24:20], instruction[11:7], writeback_data, reg_data1, reg_data2);

    immediate_extend imm_i (instruction, imm_out);

    execute_alu_decoder alu_dec_i (instruction, alu_op);

    assign alu_operand2 = (alu_src) ? imm_out : reg_data2;
    execute_alu alu_i (reg_data1, alu_operand2, alu_op, alu_result);

    execute_branch_logic br_i (reg_data1, reg_data2, instruction[14:12], branch_taken);

    data_memory dmem_i (clk, mem_read, mem_write, alu_result, reg_data2, mem_data);

    assign writeback_data = (mem_to_reg) ? mem_data : alu_result;

endmodule