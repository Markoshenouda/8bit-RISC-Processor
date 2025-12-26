
module Control_Unit (
    // ==========================================
    // INPUTS
    // ==========================================
    input [7:0] instr,              // The full 8-bit instruction fetched from IF/ID stage
    
    // ==========================================
    // EXECUTION CONTROL OUTPUTS
    // ==========================================
    output reg [3:0] alu_op,        // Selects the operation for the ALU (e.g., 2=ADD, 4=AND)
    output reg reg_write_enable,    // 1 = Enable writing the result back into the Register File
    output reg [1:0] reg_dest,      // Selects which register to write to (ra or rb)
    output reg [2:0] reg_write_src, // MUX Select for Writeback Data:
                                    // 000=ALU Result, 001=Memory, 010=Immediate, 011=Input Port

    // ==========================================
    // FLAG CONTROL OUTPUTS (CCR)
    // ==========================================
    output reg flag_write_enable,   // 1 = Allow the CCR (Flags) to be updated
    output reg [3:0] flag_write_mask, // Selects WHICH flags to update {V, C, N, Z}
                                      // 1 = Update, 0 = Keep previous value

    // ==========================================
    // MEMORY CONTROL OUTPUTS
    // ==========================================
    output reg mem_read,            // 1 = Enable reading from Data Memory (Load, POP, RET)
    output reg mem_write,           // 1 = Enable writing to Data Memory (Store, PUSH, CALL)
    output reg [1:0] mem_addr_src,  // MUX Select for Memory Address:
                                    // 00 = Forwarded Address (Indirect)
                                    // 01 = Immediate Address (Direct)
                                    // 10 = Stack Pointer (SP)

    // ==========================================
    // BRANCH & FLOW CONTROL OUTPUTS
    // ==========================================
    output reg is_branch,           // 1 = Indicates a Conditional Branch (JZ, JN) or JMP
    output reg is_call,             // 1 = Indicates a Subroutine Call (Jumps + Pushes PC)
    output reg is_ret,              // 1 = Indicates a Return (Pops PC + Jumps)
    output reg is_rti,              // 1 = Indicates Return from Interrupt (Pops PC + Flags)

    // ==========================================
    // STACK POINTER CONTROL OUTPUTS
    // ==========================================
    output reg sp_inc,              // 1 = Increment SP (Move UP) -> Used for POP, RET
    output reg sp_dec,              // 1 = Decrement SP (Move DOWN) -> Used for PUSH, CALL
    output reg stack_op,            // 1 = Flag for Hazard Unit: Instruction uses the Stack

    // ==========================================
    // I/O & INSTRUCTION TYPE OUTPUTS
    // ==========================================
    output reg is_load,             // 1 = Instruction loads data from memory (Hazard checking)
    output reg is_store,            // 1 = Instruction stores data to memory
    output reg output_en,           // 1 = Enable writing to the Output Port (OUT instruction)
    output reg input_en,            // 1 = Enable reading from the Input Port (IN instruction)
    output reg is_two_byte          // 1 = Instruction is 2 bytes long (PC increments by 2)
);

    // ==========================================
    // INTERNAL DECODING WIRES
    // ==========================================
    wire [3:0] opcode = instr[7:4]; 
    wire [1:0] ra = instr[3:2];     
    wire [1:0] rb = instr[1:0];     

    always @(*) begin
        // Defaults
        alu_op = 4'h0;
        flag_write_enable = 1'b0;
        flag_write_mask = 4'b0000;
        reg_write_enable = 1'b0;
        reg_dest = 2'b00;
        reg_write_src = 3'b000;
        mem_read = 1'b0;
        mem_write = 1'b0;
        mem_addr_src = 2'b00;
        is_branch = 1'b0;
        is_call = 1'b0;
        is_ret = 1'b0;
        is_rti = 1'b0;
        sp_inc = 1'b0;
        sp_dec = 1'b0;
        stack_op = 1'b0;
        is_load = 1'b0;
        is_store = 1'b0;
        output_en = 1'b0;
        input_en = 1'b0;
        is_two_byte = 1'b0;

        // opcode decoding
        case (opcode)
            4'h0: begin // NOP
            end

            4'h1: begin // MOV
                alu_op = 4'h1;
                reg_write_enable = 1'b1;
                reg_dest = ra;
                reg_write_src = 3'b000;
            end

            4'h2: begin // ADD
                alu_op = 4'h2;
                reg_write_enable = 1'b1;
                reg_dest = ra;
                reg_write_src = 3'b000;
                flag_write_enable = 1'b1;
                flag_write_mask = 4'b1111; // Update all flags (V, C, N, Z)
            end

            4'h3: begin // SUB
                alu_op = 4'h3;
                reg_write_enable = 1'b1;
                reg_dest = ra;
                reg_write_src = 3'b000;
                flag_write_enable = 1'b1;
                flag_write_mask = 4'b1111; // Update all flags
            end

            4'h4: begin // AND
                alu_op = 4'h4;
                reg_write_enable = 1'b1;
                reg_dest = ra;
                reg_write_src = 3'b000;
                flag_write_enable = 1'b1;
                flag_write_mask = 4'b0011; // Update only Z and N
            end

            4'h5: begin // OR
                alu_op = 4'h5;
                reg_write_enable = 1'b1;
                reg_dest = ra;
                reg_write_src = 3'b000;
                flag_write_enable = 1'b1;
                flag_write_mask = 4'b0011; // Update only Z and N
            end

            4'h6: begin // RLC/RRC/SETC/CLRC
                alu_op = 4'h6;
                flag_write_enable = 1'b1;
                
                case(ra)
                    2'b00: begin // RLC
                        reg_write_enable = 1'b1;
                        reg_dest = rb;
                        reg_write_src = 3'b000;
                        flag_write_mask = 4'b0111; // Update C, N, Z
                    end
                    2'b01: begin // RRC
                        reg_write_enable = 1'b1;
                        reg_dest = rb;
                        reg_write_src = 3'b000;
                        flag_write_mask = 4'b0111; // Update C, N, Z
                    end
                    2'b10: begin // SETC
                        flag_write_mask = 4'b0100; // Update only C
                    end
                    2'b11: begin // CLRC
                        flag_write_mask = 4'b0100; // Update only C
                    end
                endcase
            end

            4'h7: begin // PUSH/POP/OUT/IN
                case(ra)
                    2'b00: begin // PUSH
                        stack_op = 1'b1;
                        mem_write = 1'b1;
                        mem_addr_src = 2'b10;  // Use SP
                        sp_dec = 1'b1;
                    end
                    2'b01: begin // POP
                        stack_op = 1'b1;
                        mem_read = 1'b1;
                        mem_addr_src = 2'b10;  // Use SP + 1
                        sp_inc = 1'b1;
                        reg_write_enable = 1'b1;
                        reg_dest = rb;
                        reg_write_src = 3'b001; // From memory
                    end
                    2'b10: begin // OUT
                        output_en = 1'b1;
                    end
                    2'b11: begin // IN
                        input_en = 1'b1;
                        reg_write_enable = 1'b1;
                        reg_dest = rb;
                        reg_write_src = 3'b011;
                    end
                endcase
            end

            4'h8: begin // NOT/NEG/INC/DEC
                alu_op = 4'h8;
                reg_write_enable = 1'b1;
                reg_dest = rb;
                reg_write_src = 3'b000;
                flag_write_enable = 1'b1;
                
                case(ra)
                    2'b00: flag_write_mask = 4'b0011; // NOT: Z, N only
                    2'b01: flag_write_mask = 4'b0011; // NEG: Z, N only
                    2'b10: flag_write_mask = 4'b1111; // INC: All flags
                    2'b11: flag_write_mask = 4'b1111; // DEC: All flags
                endcase
            end

            4'h9: begin // Conditional branches (JZ, JN, JC, JV)
                is_branch = 1'b1;
            end

            4'hA: begin // LOOP
                alu_op = 4'hA;
                reg_write_enable = 1'b1;
                reg_dest = ra;
                reg_write_src = 3'b000;
                is_branch = 1'b1;
                flag_write_enable = 1'b1;
                flag_write_mask = 4'b0011; // Update Z and N
            end

            4'hB: begin // JMP/CALL/RET/RTI
                case (ra)
                    2'b00: begin // JMP
                        is_branch = 1'b1;
                    end
                    2'b01: begin // CALL
                        is_call = 1'b1;
                        is_branch = 1'b1;
                        stack_op = 1'b1;
                        sp_dec = 1'b1;
                        mem_write = 1'b1;
                        mem_addr_src = 2'b10;
                    end
                    2'b10: begin // RET
                        is_ret = 1'b1;
                        is_branch = 1'b1;
                        stack_op = 1'b1;
                        sp_inc = 1'b1;
                        mem_read = 1'b1;
                        mem_addr_src = 2'b10;
                    end
                    2'b11: begin // RTI
                        is_rti = 1'b1;
                        is_branch = 1'b1;
                        stack_op = 1'b1;
                        sp_inc = 1'b1;
                        mem_read = 1'b1;
                        mem_addr_src = 2'b10;
                    end
                endcase
            end

            4'hC: begin // LDM/LDD/STD
                is_two_byte = 1'b1;
                case (ra)
                    2'b00: begin // LDM
                        reg_write_enable = 1'b1;
                        reg_dest = rb;
                        reg_write_src = 3'b010; // From immediate
                    end
                    2'b01: begin // LDD
                        is_load = 1'b1;
                        mem_read = 1'b1;
                        mem_addr_src = 2'b01; // Direct addressing
                        reg_write_enable = 1'b1;
                        reg_dest = rb;
                        reg_write_src = 3'b001; // From memory
                    end
                    2'b10: begin // STD
                        is_store = 1'b1;
                        mem_write = 1'b1;
                        mem_addr_src = 2'b01; // Direct addressing
                    end
                endcase
            end

            4'hD: begin // LDI
                is_load = 1'b1;
                mem_read = 1'b1;
                mem_addr_src = 2'b00; // Indirect through R[ra]
                reg_write_enable = 1'b1;
                reg_dest = rb;
                reg_write_src = 3'b001; // From memory
            end

            4'hE: begin // STI
                is_store = 1'b1;
                mem_write = 1'b1;
                mem_addr_src = 2'b00; // Indirect through R[ra]
            end

            default: begin
                // NOP
            end
        endcase
    end

endmodule