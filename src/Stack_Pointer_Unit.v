module Stack_Pointer_Unit (
    // Inputs
    input clk,
    input rst,
    input ex_mem_sp_inc,
    input ex_mem_sp_dec,
    input interrupt_sp_dec,          
    input mem_wb_reg_write_enable,
    input [1:0] mem_wb_reg_dest,
    input [7:0] write_back_data,
    
    // Outputs
    output reg [7:0] sp_current
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sp_current <= 8'hFF;
           
        end else begin
            
            if (interrupt_sp_dec) begin
                sp_current <= sp_current - 8'd1;
                
            end
            else if (ex_mem_sp_dec) begin
                sp_current <= sp_current - 8'd1;
                
            end 
            else if (ex_mem_sp_inc) begin
                sp_current <= sp_current + 8'd1;
               
            end
            else if (mem_wb_reg_write_enable && (mem_wb_reg_dest == 2'b11)) begin
                sp_current <= write_back_data;
                
            end
        end
    end

endmodule