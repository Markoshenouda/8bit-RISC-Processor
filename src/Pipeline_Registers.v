

// ========== IF/ID Pipeline Register ==========
module IF_ID_Register (
    input clk,
    input rst,
    input stall,
    input flush,
    input [7:0] instr_in,
    input [7:0] PC_in,
    output reg [7:0] instr_out,
    output reg [7:0] PC_out
);
    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            instr_out <= 8'h00; // NOP
            PC_out <= 8'h00;
        end else if (!stall) begin
            instr_out <= instr_in;
            PC_out <= PC_in;
        end
    end
endmodule






// ========== ID/EX Pipeline Register ==========
module ID_EX_Register (
    input clk,
    input rst,
    input flush,
    
    // Control signals
    input [3:0] alu_op_in,
    input flag_write_enable_in,
    input [3:0] flag_write_mask_in,
    input reg_write_enable_in,
    input [1:0] reg_dest_in,
    input [2:0] reg_write_src_in,
    input mem_read_in,
    input mem_write_in,
    input [1:0] mem_addr_src_in,
    input is_branch_in,
    input is_call_in,
    input is_ret_in,
    input is_rti_in,
    input sp_inc_in,
    input sp_dec_in,
    input stack_op_in,
    input is_load_in,
    input is_store_in,
    input output_en_in,
    input input_en_in,
    
    // Data signals
    input [7:0] instr_in,
    input [7:0] PC_in,
    input [7:0] reg_a_data_in,
    input [7:0] reg_b_data_in,
    input [7:0] imm_in,
    input [1:0] ra_in,
    input [1:0] rb_in,
    
    // Control outputs
    output reg [3:0] alu_op_out,
    output reg flag_write_enable_out,
    output reg [3:0] flag_write_mask_out,
    output reg reg_write_enable_out,
    output reg [1:0] reg_dest_out,
    output reg [2:0] reg_write_src_out,
    output reg mem_read_out,
    output reg mem_write_out,
    output reg [1:0] mem_addr_src_out,
    output reg is_branch_out,
    output reg is_call_out,
    output reg is_ret_out,
    output reg is_rti_out,
    output reg sp_inc_out,
    output reg sp_dec_out,
    output reg stack_op_out,
    output reg is_load_out,
    output reg is_store_out,
    output reg output_en_out,
    output reg input_en_out,
    
    // Data outputs
    output reg [7:0] instr_out,
    output reg [7:0] PC_out,
    output reg [7:0] reg_a_data_out,
    output reg [7:0] reg_b_data_out,
    output reg [7:0] imm_out,
    output reg [1:0] ra_out,
    output reg [1:0] rb_out
);
    always @(posedge clk or posedge rst) begin
        if (rst || flush) begin
            // Clear all control signals
            alu_op_out <= 4'h0;
            flag_write_enable_out <= 1'b0;
            flag_write_mask_out <= 4'h0;
            reg_write_enable_out <= 1'b0;
            reg_dest_out <= 2'b00;
            reg_write_src_out <= 3'b000;
            mem_read_out <= 1'b0;
            mem_write_out <= 1'b0;
            mem_addr_src_out <= 2'b00;
            is_branch_out <= 1'b0;
            is_call_out <= 1'b0;
            is_ret_out <= 1'b0;
            is_rti_out <= 1'b0;
            sp_inc_out <= 1'b0;
            sp_dec_out <= 1'b0;
            stack_op_out <= 1'b0;
            is_load_out <= 1'b0;
            is_store_out <= 1'b0;
            output_en_out <= 1'b0;
            input_en_out <= 1'b0;
            
            // Clear data
            instr_out <= 8'h00;
            PC_out <= 8'h00;
            reg_a_data_out <= 8'h00;
            reg_b_data_out <= 8'h00;
            imm_out <= 8'h00;
            ra_out <= 2'b00;
            rb_out <= 2'b00;
        end else begin
            // Pass control signals
            alu_op_out <= alu_op_in;
            flag_write_enable_out <= flag_write_enable_in;
            flag_write_mask_out <= flag_write_mask_in;
            reg_write_enable_out <= reg_write_enable_in;
            reg_dest_out <= reg_dest_in;
            reg_write_src_out <= reg_write_src_in;
            mem_read_out <= mem_read_in;
            mem_write_out <= mem_write_in;
            mem_addr_src_out <= mem_addr_src_in;
            is_branch_out <= is_branch_in;
            is_call_out <= is_call_in;
            is_ret_out <= is_ret_in;
            is_rti_out <= is_rti_in;
            sp_inc_out <= sp_inc_in;
            sp_dec_out <= sp_dec_in;
            stack_op_out <= stack_op_in;
            is_load_out <= is_load_in;
            is_store_out <= is_store_in;
            output_en_out <= output_en_in;
            input_en_out <= input_en_in;
            
            // Pass data
            instr_out <= instr_in;
            PC_out <= PC_in;
            reg_a_data_out <= reg_a_data_in;
            reg_b_data_out <= reg_b_data_in;
            imm_out <= imm_in;
            ra_out <= ra_in;
            rb_out <= rb_in;
        end
    end
endmodule






// ========== EX/MEM Pipeline Register  ==========
module EX_MEM_Register (
    input clk,
    input rst,
    
    // Control signals
    input reg_write_enable_in,
    input [1:0] reg_dest_in,
    input [2:0] reg_write_src_in,
    input mem_read_in,
    input mem_write_in,
    input [1:0] mem_addr_src_in,
    input is_ret_in,
    input is_rti_in,
    input sp_inc_in,
    input sp_dec_in,
    input stack_op_in,
    input is_load_in,
    input is_store_in,
    input output_en_in,
    input input_en_in,
    
    // Data signals
    input [7:0] instr_in,
    input [7:0] PC_in,
    input [7:0] alu_result_in,
    input [7:0] reg_a_data_in,  
    input [7:0] reg_b_data_in,
    input [7:0] mem_addr_in,
    input [7:0] imm_in,
    
    // Control outputs
    output reg reg_write_enable_out,
    output reg [1:0] reg_dest_out,
    output reg [2:0] reg_write_src_out,
    output reg mem_read_out,
    output reg mem_write_out,
    output reg [1:0] mem_addr_src_out,
    output reg is_ret_out,
    output reg is_rti_out,
    output reg sp_inc_out,
    output reg sp_dec_out,
    output reg stack_op_out,
    output reg is_load_out,
    output reg is_store_out,
    output reg output_en_out,
    output reg input_en_out,
    
    // Data outputs
    output reg [7:0] instr_out,
    output reg [7:0] PC_out,
    output reg [7:0] alu_result_out,
    output reg [7:0] reg_a_data_out,  
    output reg [7:0] reg_b_data_out,
    output reg [7:0] mem_addr_out,
    output reg [7:0] imm_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Clear control signals
            reg_write_enable_out <= 1'b0;
            reg_dest_out <= 2'b00;
            reg_write_src_out <= 3'b000;
            mem_read_out <= 1'b0;
            mem_write_out <= 1'b0;
            mem_addr_src_out <= 2'b00;
            is_ret_out <= 1'b0;
            is_rti_out <= 1'b0;
            sp_inc_out <= 1'b0;
            sp_dec_out <= 1'b0;
            stack_op_out <= 1'b0;
            is_load_out <= 1'b0;
            is_store_out <= 1'b0;
            output_en_out <= 1'b0;
            input_en_out <= 1'b0;
            
            // Clear data
            instr_out <= 8'h00;
            PC_out <= 8'h00;
            alu_result_out <= 8'h00;
            reg_a_data_out <= 8'h00;  
            reg_b_data_out <= 8'h00;
            mem_addr_out <= 8'h00;
            imm_out <= 8'h00;
        end else begin
            // Pass control signals
            reg_write_enable_out <= reg_write_enable_in;
            reg_dest_out <= reg_dest_in;
            reg_write_src_out <= reg_write_src_in;
            mem_read_out <= mem_read_in;
            mem_write_out <= mem_write_in;
            mem_addr_src_out <= mem_addr_src_in;
            is_ret_out <= is_ret_in;
            is_rti_out <= is_rti_in;
            sp_inc_out <= sp_inc_in;
            sp_dec_out <= sp_dec_in;
            stack_op_out <= stack_op_in;
            is_load_out <= is_load_in;
            is_store_out <= is_store_in;
            output_en_out <= output_en_in;
            input_en_out <= input_en_in;
            
            // Pass data
            instr_out <= instr_in;
            PC_out <= PC_in;
            alu_result_out <= alu_result_in;
            reg_a_data_out <= reg_a_data_in;  
            reg_b_data_out <= reg_b_data_in;
            mem_addr_out <= mem_addr_in;
            imm_out <= imm_in;
        end
    end
endmodule




// ========== MEM/WB Pipeline Register ==========
module MEM_WB_Register (
    input clk,
    input rst,
    
    // Control signals
    input reg_write_enable_in,
    input [1:0] reg_dest_in,
    input [2:0] reg_write_src_in,
    
    // Data signals
    input [7:0] instr_in,
    input [7:0] alu_result_in,
    input [7:0] mem_data_in,
    input [7:0] imm_in,
    input [7:0] input_port_in,
    
    // Control outputs
    output reg reg_write_enable_out,
    output reg [1:0] reg_dest_out,
    output reg [2:0] reg_write_src_out,
    
    // Data outputs
    output reg [7:0] instr_out,
    output reg [7:0] alu_result_out,
    output reg [7:0] mem_data_out,
    output reg [7:0] imm_out,
    output reg [7:0] input_port_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Clear control signals
            reg_write_enable_out <= 1'b0;
            reg_dest_out <= 2'b00;
            reg_write_src_out <= 3'b000;
            
            // Clear data
            instr_out <= 8'h00;
            alu_result_out <= 8'h00;
            mem_data_out <= 8'h00;
            imm_out <= 8'h00;
            input_port_out <= 8'h00;
        end else begin
            // Pass control signals
            reg_write_enable_out <= reg_write_enable_in;
            reg_dest_out <= reg_dest_in;
            reg_write_src_out <= reg_write_src_in;
            
            // Pass data
            instr_out <= instr_in;
            alu_result_out <= alu_result_in;
            mem_data_out <= mem_data_in;
            imm_out <= imm_in;
            input_port_out <= input_port_in;
        end
    end
endmodule