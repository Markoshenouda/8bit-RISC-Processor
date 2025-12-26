
module Branch_Unit (
    // Inputs
    input [7:0] id_ex_instr,
    input [7:0] alu_result,
    input [3:0] current_flags,
    input ex_mem_is_branch,
    input [7:0] ex_mem_reg_b_data,
    input ex_mem_is_ret,           
    input ex_mem_is_rti,           
    
    // Outputs
    output reg pc_branch_taken,
    output reg [7:0] branch_target
);

    wire [3:0] opcode = id_ex_instr[7:4];
    wire [1:0] ra = id_ex_instr[3:2];
    wire [1:0] rb = id_ex_instr[1:0];
    
    wire Z = current_flags[0];
    wire N = current_flags[1];
    wire C = current_flags[2];
    wire V = current_flags[3];
    
    always @(*) begin
        pc_branch_taken = 1'b0;
        branch_target = 8'h00;
        
        
        if (!ex_mem_is_branch || ex_mem_is_ret || ex_mem_is_rti) begin
            pc_branch_taken = 1'b0;
            branch_target = 8'h00;
        end else begin
            case (opcode)
                4'h9: begin // Conditional branches (JZ, JN, JC, JV)
                    case (ra)
                        2'b00: begin // JZ
                            if (Z) begin
                                pc_branch_taken = 1'b1;
                                branch_target = ex_mem_reg_b_data;
                            end
                        end
                        2'b01: begin // JN
                            if (N) begin
                                pc_branch_taken = 1'b1;
                                branch_target = ex_mem_reg_b_data;
                            end
                        end
                        2'b10: begin // JC
                            if (C) begin
                                pc_branch_taken = 1'b1;
                                branch_target = ex_mem_reg_b_data;
                            end
                        end
                        2'b11: begin // JV
                            if (V) begin
                                pc_branch_taken = 1'b1;
                                branch_target = ex_mem_reg_b_data;
                            end
                        end
                    endcase
                end
                
                4'hA: begin // LOOP
                    if (alu_result != 8'h00) begin
                        pc_branch_taken = 1'b1;
                        branch_target = ex_mem_reg_b_data;
                    end
                end
                
                4'hB: begin // JMP/CALL 
                    case (ra)
                        2'b00: begin // JMP
                            pc_branch_taken = 1'b1;
                            branch_target = ex_mem_reg_b_data;
                        end
                        2'b01: begin // CALL
                            pc_branch_taken = 1'b1;
                            branch_target = ex_mem_reg_b_data;
                        end
                        
                    endcase
                end
                
                default: begin
                    pc_branch_taken = 1'b0;
                    branch_target = 8'h00;
                end
            endcase
        end
        
    end

endmodule