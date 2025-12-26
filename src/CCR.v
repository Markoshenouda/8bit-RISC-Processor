
module CCR ( 
    input        clk,
    input        rst,
    input        write_en,         // Enable flag updates
    input  [3:0] flag_write_mask,  
    input  [3:0] flags_in,         // New flag values 
    input        restore_en,       // Restore flags (RTI)
    input  [3:0] restore_value,    // Flags from stack

    output reg [3:0] flags_out     // Current flags {V, C, N, Z}
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            flags_out <= 4'b0000;  // Reset all flags
           
        end
        else if (restore_en) begin
            // RTI: Restore all flags from stack
            flags_out <= restore_value;
           
        end
        else if (write_en) begin
            
            if (flag_write_mask[0]) flags_out[0] <= flags_in[0]; // Z
            if (flag_write_mask[1]) flags_out[1] <= flags_in[1]; // N
            if (flag_write_mask[2]) flags_out[2] <= flags_in[2]; // C
            if (flag_write_mask[3]) flags_out[3] <= flags_in[3]; // V
            
         
        end
    end

endmodule