
module Forwarding_Unit (
    // --- Inputs from Execute Stage (Consumer) ---
    input [1:0] id_ex_ra,               // Source Register A of the instruction needing data
    input [1:0] id_ex_rb,               // Source Register B of the instruction needing data

    // --- Inputs from Memory Stage (Provider 1 - Most Recent) ---
    input ex_mem_reg_write_enable,      // Flag: Is the instruction in MEM stage writing to a register?
    input [1:0] ex_mem_reg_dest,        // Destination register of the instruction in MEM stage

    // --- Inputs from Writeback Stage (Provider 2 - Older) ---
    input mem_wb_reg_write_enable,      // Flag: Is the instruction in WB stage writing to a register?
    input [1:0] mem_wb_reg_dest,        // Destination register of the instruction in WB stage

    // --- Control Outputs ---
    output reg [1:0] forward_a,         // MUX Select for ALU Input A: 00=RegFile, 10=EX_Fwd, 01=MEM_Fwd
    output reg [1:0] forward_b          // MUX Select for ALU Input B: 00=RegFile, 10=EX_Fwd, 01=MEM_Fwd
);



    // Forward A logic
    always @(*) begin
        forward_a = 2'b00;  
        
        // Check EX hazard first (most recent - highest priority)
        if (ex_mem_reg_write_enable && (ex_mem_reg_dest == id_ex_ra)) begin
            forward_a = 2'b10;  // Forward from EX/MEM
            
        end
        // Check MEM hazard (older data)
        else if (mem_wb_reg_write_enable && (mem_wb_reg_dest == id_ex_ra)) begin
            forward_a = 2'b01;  // Forward from MEM/WB
            
        end
    end
    
    // Forward B logic 
    always @(*) begin
        forward_b = 2'b00;
        
        if (ex_mem_reg_write_enable && (ex_mem_reg_dest == id_ex_rb)) begin
            forward_b = 2'b10;
            
        end
        else if (mem_wb_reg_write_enable && (mem_wb_reg_dest == id_ex_rb)) begin
            forward_b = 2'b01;
    
        end
    end

endmodule