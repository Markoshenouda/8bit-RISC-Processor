module Processor_Top (
    input clk,
    input rst,
    input [7:0] input_port,
    input interrupt,
    output [7:0] output_port
);

    // ============================================
    // FETCH STAGE SIGNALS
    // ============================================
    wire [7:0] pc_current;
    wire pc_stall;
    wire [7:0] instr_fetched;
    wire [7:0] interrupt_vector;
    
    // ============================================
    // IF/ID STAGE SIGNALS
    // ============================================
    wire [7:0] if_id_instr, if_id_pc;
    wire if_id_stall_hazard;
    wire [3:0] opcode;
    wire [1:0] ra, rb;
    
    // ============================================
    // DECODE STAGE SIGNALS
    // ============================================
    wire [7:0] reg_a_data, reg_b_data, immediate_value;
    wire [3:0] alu_op;
    wire flag_write_enable;
    wire [3:0] flag_write_mask;
    wire reg_write_enable;
    wire [1:0] reg_dest;
    wire [2:0] reg_write_src;
    wire mem_read, mem_write;
    wire [1:0] mem_addr_src;
    wire is_branch, is_call, is_ret, is_rti;
    wire sp_inc, sp_dec, stack_op;
    wire is_load, is_store;
    wire output_en, input_en;
    wire is_two_byte;
    wire id_ex_flush_hazard;
    
    // ============================================
    // ID/EX STAGE SIGNALS
    // ============================================
    wire [3:0] id_ex_alu_op;
    wire id_ex_flag_write_enable;
    wire [3:0] id_ex_flag_write_mask;
    wire id_ex_reg_write_enable;
    wire [1:0] id_ex_reg_dest;
    wire [2:0] id_ex_reg_write_src;
    wire id_ex_mem_read, id_ex_mem_write;
    wire [1:0] id_ex_mem_addr_src;
    wire id_ex_is_branch, id_ex_is_call, id_ex_is_ret, id_ex_is_rti;
    wire id_ex_sp_inc, id_ex_sp_dec, id_ex_stack_op;
    wire id_ex_is_load, id_ex_is_store;
    wire id_ex_output_en, id_ex_input_en;
    wire [7:0] id_ex_instr, id_ex_pc;
    wire [7:0] id_ex_reg_a_data, id_ex_reg_b_data, id_ex_imm;
    wire [1:0] id_ex_ra, id_ex_rb;
    
    // ============================================
    // EXECUTE STAGE SIGNALS
    // ============================================
    wire [7:0] alu_result;
    wire alu_z, alu_n, alu_c, alu_v;
    wire [3:0] current_flags;
    wire [7:0] mem_addr_ex;
    wire [1:0] forward_a, forward_b;
    wire [7:0] forwarded_a, forwarded_b;
    
    // ============================================
    // EX/MEM STAGE SIGNALS
    // ============================================
    wire ex_mem_reg_write_enable;
    wire [1:0] ex_mem_reg_dest;
    wire [2:0] ex_mem_reg_write_src;
    wire ex_mem_mem_read, ex_mem_mem_write;
    wire [1:0] ex_mem_mem_addr_src;
    reg ex_mem_is_branch_reg;
    wire ex_mem_is_branch;
    wire ex_mem_is_ret, ex_mem_is_rti;
    wire ex_mem_sp_inc, ex_mem_sp_dec, ex_mem_stack_op;
    wire ex_mem_is_load, ex_mem_is_store;
    wire ex_mem_output_en, ex_mem_input_en;
    wire [7:0] ex_mem_instr, ex_mem_pc;
    wire [7:0] ex_mem_alu_result;
    wire [7:0] ex_mem_reg_a_data, ex_mem_reg_b_data;
    wire [7:0] ex_mem_mem_addr, ex_mem_imm;
    
    // ============================================
    // MEMORY STAGE SIGNALS
    // ============================================
    wire [7:0] mem_data_read;
    wire [7:0] mem_addr_final, mem_write_data;
    
    // ============================================
    // MEM/WB STAGE SIGNALS
    // ============================================
    wire mem_wb_reg_write_enable;
    wire [1:0] mem_wb_reg_dest;
    wire [2:0] mem_wb_reg_write_src;
    wire [7:0] mem_wb_instr;
    wire [7:0] mem_wb_alu_result, mem_wb_mem_data, mem_wb_imm, mem_wb_input_port;
    
    // ============================================
    // WRITEBACK STAGE SIGNALS
    // ============================================
    wire [7:0] write_back_data;
    
    // ============================================
    // SPECIAL UNITS SIGNALS
    // ============================================
    wire [7:0] sp_current;
    wire sp_write_enable;      
    wire pc_branch_taken;
    wire [7:0] branch_target;
    wire interrupt_trigger;
    wire interrupt_active;
    wire [7:0] saved_pc;
    wire [3:0] saved_flags;
    
    // ============================================
    // INTERRUPT & MEMORY BRANCH SIGNALS
    // ============================================
    wire mem_branch_taken;
    wire [7:0] mem_branch_target;
    wire final_branch_taken;
    wire [7:0] final_branch_target;
    
    wire interrupt_mem_write;
    wire [7:0] interrupt_mem_addr;
    wire [7:0] interrupt_mem_data;
    wire interrupt_sp_dec;
    
    wire final_mem_write;
    wire [7:0] final_mem_addr;
    wire [7:0] final_mem_data;
    
    // ============================================
    // COMBINATIONAL LOGIC
    // ============================================
    
    // Decode stage
    assign opcode = if_id_instr[7:4];
    assign ra = if_id_instr[3:2];
    assign rb = if_id_instr[1:0];
    
    // Branch detection
    assign ex_mem_is_branch = ex_mem_is_branch_reg;
    
    // Memory addressing
    assign mem_addr_ex = (id_ex_mem_addr_src == 2'b10 && id_ex_sp_inc) ? (sp_current + 8'd1) :
                         (id_ex_mem_addr_src == 2'b10) ? sp_current :
                         (id_ex_mem_addr_src == 2'b01) ? id_ex_imm :
                         (id_ex_mem_addr_src == 2'b00) ? forwarded_a :
                         8'h00;
    
    // ============================================
    // INTERRUPT MEMORY WRITE LOGIC 
    // ============================================
    assign interrupt_mem_write = interrupt_trigger;
    assign interrupt_mem_addr = sp_current;
    assign interrupt_mem_data = saved_pc;  
    assign interrupt_sp_dec = interrupt_trigger;
    
    // Final memory signals with interrupt priority
    assign final_mem_write = interrupt_mem_write || ex_mem_mem_write;
    assign final_mem_addr = interrupt_mem_write ? interrupt_mem_addr : ex_mem_mem_addr;
    assign final_mem_data = interrupt_mem_write ? interrupt_mem_data : mem_write_data;
    
    assign mem_addr_final = final_mem_addr;
    assign mem_write_data = ex_mem_reg_b_data;
    
    assign mem_branch_taken = (ex_mem_is_ret || ex_mem_is_rti) && ex_mem_mem_read;
    assign mem_branch_target = mem_data_read;
    

    assign final_branch_taken = mem_branch_taken || pc_branch_taken;
    assign final_branch_target = mem_branch_taken ? mem_branch_target : branch_target;
    
    // Writeback multiplexer
    assign write_back_data = (mem_wb_reg_write_src == 3'b000) ? mem_wb_alu_result :
                            (mem_wb_reg_write_src == 3'b001) ? mem_wb_mem_data :
                            (mem_wb_reg_write_src == 3'b010) ? mem_wb_imm :
                            (mem_wb_reg_write_src == 3'b011) ? mem_wb_input_port :
                            8'h00;
    
    // Forwarding multiplexers
    assign forwarded_a = (forward_a == 2'b10) ? ex_mem_alu_result :
                        (forward_a == 2'b01) ? write_back_data :
                        id_ex_reg_a_data;
    
    assign forwarded_b = (forward_b == 2'b10) ? ex_mem_alu_result :
                        (forward_b == 2'b01) ? write_back_data :
                        id_ex_reg_b_data;
    
    // ============================================
    // SEQUENTIAL LOGIC
    // ============================================
    
    // Branch register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ex_mem_is_branch_reg <= 1'b0;
        end else begin
            ex_mem_is_branch_reg <= id_ex_is_branch;
        end
    end
    
    // ============================================
    // MODULE INSTANTIATIONS
    // ============================================
    
    // ========== PC Unit  ==========
    PC_Unit pc_unit (
        .clk(clk),
        .rst(rst),
        .pc_stall(pc_stall),
        .interrupt_trigger(interrupt_trigger),
        .pc_branch_taken(final_branch_taken),      
        .branch_target(final_branch_target),        
        .instr_fetched(instr_fetched),
        .interrupt_vector(interrupt_vector),
        .pc_current(pc_current)
    );
    
    // ========== Instruction Memory ==========
    Instruction_Memory imem (
        .addr(pc_current),
        .instr(instr_fetched)
    );
    
    // ========== IF/ID Pipeline Register ==========
    IF_ID_Register if_id_reg (
        .clk(clk),
        .rst(rst || interrupt_trigger),
        .stall(if_id_stall_hazard),
        .flush(final_branch_taken),                 
        .instr_in(instr_fetched),
        .PC_in(pc_current),
        .instr_out(if_id_instr),
        .PC_out(if_id_pc)
    );
    
    // ========== Control Unit ==========
    Control_Unit control (
        .instr(if_id_instr),
        .alu_op(alu_op),
        .flag_write_enable(flag_write_enable),
        .flag_write_mask(flag_write_mask),
        .reg_write_enable(reg_write_enable),
        .reg_dest(reg_dest),
        .reg_write_src(reg_write_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_addr_src(mem_addr_src),
        .is_branch(is_branch),
        .is_call(is_call),
        .is_ret(is_ret),
        .is_rti(is_rti),
        .sp_inc(sp_inc),
        .sp_dec(sp_dec),
        .stack_op(stack_op),
        .is_load(is_load),
        .is_store(is_store),
        .output_en(output_en),
        .input_en(input_en),
        .is_two_byte(is_two_byte)
    );
    
    // ========== Register File  ==========
    reg_file rf (
        .clk(clk),
        .rst(rst),
        .WE(mem_wb_reg_write_enable),
        .ra(ra),
        .rb(rb),
        .w_add(mem_wb_reg_dest),
        .wd(write_back_data),
        .sp_value(sp_current),
        .sp_write_enable(sp_write_enable),
        .a_out(reg_a_data),
        .b_out(reg_b_data)
    );
    
    // ========== Immediate Fetch ==========
    Instruction_Memory imem_imm (
        .addr(if_id_pc + 8'd1),
        .instr(immediate_value)
    );
    
    // ========== ID/EX Pipeline Register ==========
    ID_EX_Register id_ex_reg (
        .clk(clk),
        .rst(rst || interrupt_trigger),
        .flush(final_branch_taken || id_ex_flush_hazard),  
        .alu_op_in(alu_op),
        .flag_write_enable_in(flag_write_enable),
        .flag_write_mask_in(flag_write_mask),
        .reg_write_enable_in(reg_write_enable),
        .reg_dest_in(reg_dest),
        .reg_write_src_in(reg_write_src),
        .mem_read_in(mem_read),
        .mem_write_in(mem_write),
        .mem_addr_src_in(mem_addr_src),
        .is_branch_in(is_branch),
        .is_call_in(is_call),
        .is_ret_in(is_ret),
        .is_rti_in(is_rti),
        .sp_inc_in(sp_inc),
        .sp_dec_in(sp_dec),
        .stack_op_in(stack_op),
        .is_load_in(is_load),
        .is_store_in(is_store),
        .output_en_in(output_en),
        .input_en_in(input_en),
        .instr_in(if_id_instr),
        .PC_in(if_id_pc),
        .reg_a_data_in(reg_a_data),
        .reg_b_data_in(reg_b_data),
        .imm_in(immediate_value),
        .ra_in(ra),
        .rb_in(rb),
        .alu_op_out(id_ex_alu_op),
        .flag_write_enable_out(id_ex_flag_write_enable),
        .flag_write_mask_out(id_ex_flag_write_mask),
        .reg_write_enable_out(id_ex_reg_write_enable),
        .reg_dest_out(id_ex_reg_dest),
        .reg_write_src_out(id_ex_reg_write_src),
        .mem_read_out(id_ex_mem_read),
        .mem_write_out(id_ex_mem_write),
        .mem_addr_src_out(id_ex_mem_addr_src),
        .is_branch_out(id_ex_is_branch),
        .is_call_out(id_ex_is_call),
        .is_ret_out(id_ex_is_ret),
        .is_rti_out(id_ex_is_rti),
        .sp_inc_out(id_ex_sp_inc),
        .sp_dec_out(id_ex_sp_dec),
        .stack_op_out(id_ex_stack_op),
        .is_load_out(id_ex_is_load),
        .is_store_out(id_ex_is_store),
        .output_en_out(id_ex_output_en),
        .input_en_out(id_ex_input_en),
        .instr_out(id_ex_instr),
        .PC_out(id_ex_pc),
        .reg_a_data_out(id_ex_reg_a_data),
        .reg_b_data_out(id_ex_reg_b_data),
        .imm_out(id_ex_imm),
        .ra_out(id_ex_ra),
        .rb_out(id_ex_rb)
    );
    
    // ========== ALU ==========
    alu alu_inst (
        .a_in(forwarded_a),
        .b_in(forwarded_b),
        .opcode(id_ex_alu_op),
        .ra(id_ex_ra),
        .rb(id_ex_rb),
        .C_in(current_flags[2]),
        .Z_in(current_flags[0]),
        .N_in(current_flags[1]),
        .V_in(current_flags[3]),
        .result(alu_result),
        .Z(alu_z),
        .N(alu_n),
        .C(alu_c),
        .V(alu_v)
    );
    
    // ========== CCR (Flags Register) ==========
    CCR ccr_inst (
        .clk(clk),
        .rst(rst),
        .write_en(id_ex_flag_write_enable),
        .flag_write_mask(id_ex_flag_write_mask),
        .flags_in({alu_v, alu_c, alu_n, alu_z}),
        .restore_en(ex_mem_is_rti && mem_branch_taken),  
        .restore_value(saved_flags),
        .flags_out(current_flags)
    );
    
    // ========== EX/MEM Pipeline Register ==========
    EX_MEM_Register ex_mem_reg (
        .clk(clk),
        .rst(rst || interrupt_trigger),  
        .reg_write_enable_in(id_ex_reg_write_enable),
        .reg_dest_in(id_ex_reg_dest),
        .reg_write_src_in(id_ex_reg_write_src),
        .mem_read_in(id_ex_mem_read),
        .mem_write_in(id_ex_mem_write),
        .mem_addr_src_in(id_ex_mem_addr_src),
        .is_ret_in(id_ex_is_ret),
        .is_rti_in(id_ex_is_rti),
        .sp_inc_in(id_ex_sp_inc),
        .sp_dec_in(id_ex_sp_dec),
        .stack_op_in(id_ex_stack_op),
        .is_load_in(id_ex_is_load),
        .is_store_in(id_ex_is_store),
        .output_en_in(id_ex_output_en),
        .input_en_in(id_ex_input_en),
        .instr_in(id_ex_instr),
        .PC_in(id_ex_pc),
        .alu_result_in(alu_result),
        .reg_a_data_in(forwarded_a),
        .reg_b_data_in(forwarded_b),
        .mem_addr_in(mem_addr_ex),
        .imm_in(id_ex_imm),
        .reg_write_enable_out(ex_mem_reg_write_enable),
        .reg_dest_out(ex_mem_reg_dest),
        .reg_write_src_out(ex_mem_reg_write_src),
        .mem_read_out(ex_mem_mem_read),
        .mem_write_out(ex_mem_mem_write),
        .mem_addr_src_out(ex_mem_mem_addr_src),
        .is_ret_out(ex_mem_is_ret),
        .is_rti_out(ex_mem_is_rti),
        .sp_inc_out(ex_mem_sp_inc),
        .sp_dec_out(ex_mem_sp_dec),
        .stack_op_out(ex_mem_stack_op),
        .is_load_out(ex_mem_is_load),
        .is_store_out(ex_mem_is_store),
        .output_en_out(ex_mem_output_en),
        .input_en_out(ex_mem_input_en),
        .instr_out(ex_mem_instr),
        .PC_out(ex_mem_pc),
        .alu_result_out(ex_mem_alu_result),
        .reg_a_data_out(ex_mem_reg_a_data),
        .reg_b_data_out(ex_mem_reg_b_data),
        .mem_addr_out(ex_mem_mem_addr),
        .imm_out(ex_mem_imm)
    );
    
    // ========== Data Memory (UPDATED) ==========
    Data_Memory dmem (
        .clk(clk),
        .rst(rst),
        .mem_read(ex_mem_mem_read),
        .mem_write(final_mem_write),          
        .addr(final_mem_addr),                
        .data_in(final_mem_data),             
        .data_out(mem_data_read),
        .interrupt_vector(interrupt_vector)
    );
    
    // ========== MEM/WB Pipeline Register ==========
    MEM_WB_Register mem_wb_reg (
        .clk(clk),
        .rst(rst),
        .reg_write_enable_in(ex_mem_reg_write_enable),
        .reg_dest_in(ex_mem_reg_dest),
        .reg_write_src_in(ex_mem_reg_write_src),
        .instr_in(ex_mem_instr),
        .alu_result_in(ex_mem_alu_result),
        .mem_data_in(mem_data_read),
        .imm_in(ex_mem_imm),
        .input_port_in(input_port),
        .reg_write_enable_out(mem_wb_reg_write_enable),
        .reg_dest_out(mem_wb_reg_dest),
        .reg_write_src_out(mem_wb_reg_write_src),
        .instr_out(mem_wb_instr),
        .alu_result_out(mem_wb_alu_result),
        .mem_data_out(mem_wb_mem_data),
        .imm_out(mem_wb_imm),
        .input_port_out(mem_wb_input_port)
    );
    
    // ========== Forwarding Unit ==========
    Forwarding_Unit fwd_unit (
        .id_ex_ra(id_ex_ra),
        .id_ex_rb(id_ex_rb),
        .ex_mem_reg_write_enable(ex_mem_reg_write_enable),
        .ex_mem_reg_dest(ex_mem_reg_dest),
        .mem_wb_reg_write_enable(mem_wb_reg_write_enable),
        .mem_wb_reg_dest(mem_wb_reg_dest),
        .forward_a(forward_a),
        .forward_b(forward_b)
    );
    
    // ========== Hazard Detection Unit ==========
    Hazard_Detection_Unit hazard_unit (
        .if_id_ra(ra),
        .if_id_rb(rb),
        .if_id_instr(if_id_instr),
        .id_ex_mem_read(id_ex_mem_read),
        .id_ex_reg_dest(id_ex_reg_dest),
        .id_ex_is_load(id_ex_is_load),
        .pc_stall(pc_stall),
        .if_id_stall(if_id_stall_hazard),
        .id_ex_flush(id_ex_flush_hazard)
    );
    
    // ========== Branch Unit  ==========
    Branch_Unit branch_unit (
        .id_ex_instr(id_ex_instr),
        .alu_result(alu_result),
        .current_flags(current_flags),
        .ex_mem_is_branch(ex_mem_is_branch),
        .ex_mem_reg_b_data(ex_mem_reg_b_data),
        .ex_mem_is_ret(ex_mem_is_ret),       
        .ex_mem_is_rti(ex_mem_is_rti),       
        .pc_branch_taken(pc_branch_taken),
        .branch_target(branch_target)
    );
    
    // ========== Stack Pointer Unit  ==========
    Stack_Pointer_Unit sp_unit (
        .clk(clk),
        .rst(rst),
        .ex_mem_sp_inc(ex_mem_sp_inc),
        .ex_mem_sp_dec(ex_mem_sp_dec),
        .interrupt_sp_dec(interrupt_sp_dec),  // ADDED
        .mem_wb_reg_write_enable(mem_wb_reg_write_enable),
        .mem_wb_reg_dest(mem_wb_reg_dest),
        .write_back_data(write_back_data),
        .sp_current(sp_current)
    );
    
    // ========== Interrupt Unit ==========
    Interrupt_Unit int_unit (
        .clk(clk),
        .rst(rst),
        .interrupt(interrupt),
        .pc_next(pc_current + 8'd1),
        .current_flags(current_flags),
        .mem_wb_instr(mem_wb_instr),
        .interrupt_active(interrupt_active),
        .saved_pc(saved_pc),
        .saved_flags(saved_flags),
        .interrupt_trigger(interrupt_trigger)
    );
    
    // ========== Output Unit ==========
    Output_Unit out_unit (
        .clk(clk),
        .rst(rst),
        .id_ex_output_en(id_ex_output_en),
        .forwarded_b(forwarded_b),
        .id_ex_rb(id_ex_rb),
        .output_port(output_port)
    );

endmodule