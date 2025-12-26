module Instruction_Memory (
    input [7:0] addr,
    output reg [7:0] instr
);

    reg [7:0] ROM [0:255];
    integer i;
    // Read program from external file
    initial begin
          for (i = 0; i < 256; i = i + 1) begin
            ROM[i] = 8'h00;
        end
        
        $readmemh("program_hazard.mem", ROM);
        

    end
    
    // Asynchronous read
    always @(*) begin
        instr = ROM[addr];
    end

endmodule