module PC_Unit (
    input clk,
    input rst,
    input pc_stall,
    input interrupt_trigger,
    input pc_branch_taken,
    input [7:0] branch_target,
    input [7:0] instr_fetched,
    input [7:0] interrupt_vector,  
    output reg [7:0] pc_current
);

    
    wire [3:0] opcode = instr_fetched[7:4];
    wire is_two_byte = (opcode == 4'hC); // LDM, LDD, STD
    
    // PC increment amount
    wire [7:0] pc_increment = is_two_byte ? 8'd2 : 8'd1;
    
  
    wire [7:0] pc_next;
    
    
    assign pc_next = interrupt_trigger ? interrupt_vector : // Highest priority: Interrupt
                     pc_branch_taken ? branch_target :       // Second: Branch/Jump
                     pc_stall ? pc_current :                 // Third: Stall (keep same PC)
                     (pc_current + pc_increment);            // Default: Increment

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_current <= 8'h00;
            
        end else begin
            pc_current <= pc_next;
            
            
            
        end
    end

endmodule