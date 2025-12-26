module Interrupt_Unit (
    // Inputs
    input clk,
    input rst,
    input interrupt,             // External interrupt pin
    input [7:0] pc_next,        // PC+1 (to save on stack)
    input [3:0] current_flags,  // Current flags to save
    input [7:0] mem_wb_instr,   // For detecting RTI completion
    
    // Outputs
    output reg interrupt_active,
    output reg [7:0] saved_pc,
    output reg [3:0] saved_flags,
    output reg interrupt_trigger
);

    reg interrupt_latched;
    reg interrupt_servicing;
    

    wire is_rti_completed = (mem_wb_instr[7:4] == 4'hB) && (mem_wb_instr[3:2] == 2'b10);
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            interrupt_latched <= 1'b0;
            interrupt_servicing <= 1'b0;
            interrupt_active <= 1'b0;
            saved_pc <= 8'h00;
            saved_flags <= 4'b0000;
            interrupt_trigger <= 1'b0;
           
        end else begin
            
            interrupt_trigger <= 1'b0;
            
            
            if (interrupt && !interrupt_latched && !interrupt_servicing) begin
                interrupt_latched <= 1'b1;
                
            end
            
            
            if (interrupt_latched && !interrupt_servicing && !interrupt_trigger) begin
                interrupt_trigger <= 1'b1;
                saved_pc <= pc_next;
                saved_flags <= current_flags;
                interrupt_servicing <= 1'b1;
                interrupt_latched <= 1'b0;
                interrupt_active <= 1'b1;
              
            end
            
            // Clear on RTI completion
            if (is_rti_completed) begin
                interrupt_servicing <= 1'b0;
                interrupt_active <= 1'b0;
                
            end
        end
    end

endmodule