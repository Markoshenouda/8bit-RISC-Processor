module reg_file (
    input clk,
    input rst,
    input WE,
    input [1:0] ra,
    input [1:0] rb,
    input [1:0] w_add,
    input [7:0] wd,
    input [7:0] sp_value,     
    input sp_write_enable,   
    output [7:0] a_out,
    output [7:0] b_out
);

    // 4 registers, 8-bit wide
    reg [7:0] RF [0:3];

    integer i;
  
    // Synchronous write
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            for (i=0; i<3; i=i+1) begin
                RF[i] <= 8'h00;
            end
            RF[3] <= 8'hFF;  // SP 
        end
        else begin
           
            if (WE && w_add != 2'b11) begin
                RF[w_add] <= wd;
                
            end
            else 
            
            // SP (R3) is managed by SP unit ONLY
            if (sp_write_enable) begin
                RF[3] <= sp_value;
            end
        end
    end

    // Asynchronous read
    assign a_out = RF[ra];
    assign b_out = RF[rb];

endmodule