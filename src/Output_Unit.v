
module Output_Unit (
    input clk,
    input rst,
    input id_ex_output_en,
    input [7:0] forwarded_b,
    input [1:0] id_ex_rb,
    output reg [7:0] output_port
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            output_port <= 8'h00;
            
        end else if (id_ex_output_en) begin
            output_port <= forwarded_b;

        end
    end

endmodule
