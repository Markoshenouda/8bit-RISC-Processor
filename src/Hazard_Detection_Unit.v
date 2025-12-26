
module Hazard_Detection_Unit (
    // --- Inputs from Decode Stage (Current Instruction) ---
    input [1:0] if_id_ra,       // Source Register A index of the instruction currently in Decode
    input [1:0] if_id_rb,       // Source Register B index of the instruction currently in Decode
    input [7:0] if_id_instr,    // Full instruction code in Decode (used to check opcode)

    // --- Inputs from Execute Stage (Previous Instruction) ---
    input id_ex_mem_read,       // Signal indicating if the instruction in Execute will read from memory
    input [1:0] id_ex_reg_dest, // Destination Register index of the instruction in Execute
    input id_ex_is_load,        // Specific flag confirming the Execute instruction is a LOAD operation

    // --- Outputs to Control Flow ---
    output reg pc_stall,        // Active High: Tells PC Unit to stop incrementing (Freeze Fetch)
    output reg if_id_stall,     // Active High: Tells IF/ID Register to hold current value (Freeze Decode)
    output reg id_ex_flush      // Active High: Clears ID/EX Register to 0 (Inserts NOP/Bubble in Execute)
);

    wire [3:0] if_id_opcode = if_id_instr[7:4];
    wire uses_ra, uses_rb;
    
    // Determine which registers current instruction uses
    assign uses_ra = (if_id_opcode == 4'h2) ||  // ADD
                     (if_id_opcode == 4'h3) ||  // SUB
                     (if_id_opcode == 4'h4) ||  // AND
                     (if_id_opcode == 4'h5) ||  // OR
                     (if_id_opcode == 4'hA) ||  // LOOP
                     (if_id_opcode == 4'hD) ||  // LDI
                     (if_id_opcode == 4'hE);    // STI
    
    assign uses_rb = (if_id_opcode == 4'h1) ||  // MOV
                     (if_id_opcode == 4'h2) ||  // ADD
                     (if_id_opcode == 4'h3) ||  // SUB
                     (if_id_opcode == 4'h4) ||  // AND
                     (if_id_opcode == 4'h5) ||  // OR
                     (if_id_opcode == 4'h6) ||  // RLC/RRC
                     (if_id_opcode == 4'h7) ||  // PUSH/POP/OUT/IN
                     (if_id_opcode == 4'h8) ||  // NOT/NEG/INC/DEC
                     (if_id_opcode == 4'h9) ||  // Branches
                     (if_id_opcode == 4'hA) ||  // LOOP
                     (if_id_opcode == 4'hB) ||  // JMP/CALL/RET/RTI
                     (if_id_opcode == 4'hC) ||  // LDM/LDD/STD
                     (if_id_opcode == 4'hD) ||  // LDI
                     (if_id_opcode == 4'hE);    // STI

    always @(*) begin
        // Default: no stall
        pc_stall = 1'b0;
        if_id_stall = 1'b0;
        id_ex_flush = 1'b0;
        
        // Load-Use Hazard Detection
        if (id_ex_is_load) begin
            // Check if current instruction uses the register being loaded
            if ((uses_ra && (if_id_ra == id_ex_reg_dest)) ||
                (uses_rb && (if_id_rb == id_ex_reg_dest))) begin
                
                pc_stall = 1'b1;        // Stall PC
                if_id_stall = 1'b1;     // Stall IF/ID register
                id_ex_flush = 1'b1;     // Insert bubble in ID/EX
                
               
            end
        end
    end

endmodule