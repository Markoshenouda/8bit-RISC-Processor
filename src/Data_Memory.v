module Data_Memory (
    input clk,
    input rst,
    input mem_read,
    input mem_write,
    input [7:0] addr,
    input [7:0] data_in,
    output [7:0] data_out,
    output [7:0] interrupt_vector
);

    reg [7:0] RAM [0:255];
    
    integer i;
    
    // Initialization
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            RAM[i] = 8'h00;
        end
        
        // System vectors
        RAM[0] = 8'h00;  // Reset vector (program starts at 0)
        RAM[1] = 8'h3C;  // Interrupt vector = 0x3C (ISR location)
    end
    
    // Synchronous write
    always @(posedge clk) begin
        if (mem_write) begin
            RAM[addr] <= data_in;
            
        end
    end
    
    // Asynchronous read
    assign data_out = RAM[addr];
    
    // Always provide interrupt vector
    assign interrupt_vector = RAM[1];
    

endmodule