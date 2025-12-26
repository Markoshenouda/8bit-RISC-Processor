 
 
module alu (
    input  wire [7:0] a_in,      // R[ra]
    input  wire [7:0] b_in,      // R[rb]
    input  wire [3:0] opcode,    //3bit opcode i[7:4]
    input  wire [1:0] ra,        // i[3:2]
    input  wire [1:0] rb,        // i[1:0]
    input  wire       C_in,      // cin 
    input  wire       Z_in, N_in, V_in, // old flags
    output reg  [7:0] result,
    output reg        Z, N, C, V //output flages
);

    //Intermediate wires for arithmetic
    wire [8:0] add9 = {1'b0, a_in} + {1'b0, b_in};
    wire [8:0] sub9 = {1'b0, a_in} - {1'b0, b_in};
    wire [8:0] inc9 = {1'b0, b_in} + 9'h001;
    wire [8:0] dec9 = {1'b0, b_in} - 9'h001;

    always @(*) begin
        // hold previous flags
        Z = Z_in;
        N = N_in;
        C = C_in;
        V = V_in;
        result = 8'h00;

        case (opcode)
            // 0: NOP
            4'h0: begin
                result = a_in;
            end
            
            // 1: MOV 
            4'h1: begin
                result = b_in;
            end
            
            // 2: ADD
            4'h2: begin
                result = add9[7:0];
                C = add9[8];
                V = (a_in[7] == b_in[7]) && (result[7] != a_in[7]);
                Z = (result == 8'h00);
                N = result[7];
            end
            
            // 3: SUB
            4'h3: begin
                result = sub9[7:0];
                C = ~sub9[8];  // C=1 means no borrow
                V = (a_in[7] != b_in[7]) && (result[7] != a_in[7]);
                Z = (result == 8'h00);
                N = result[7];
            end
            
            // 4: AND
            4'h4: begin
                result = a_in & b_in;
                Z = (result == 8'h00);
                N = result[7];
            end
            
            // 5: OR
            4'h5: begin
                result = a_in | b_in;
                Z = (result == 8'h00);
                N = result[7];
            end
            
            // 6: RLC/RRC/SETC/CLRC
            4'h6: begin
                case(ra)
                    2'b00: begin // RLC
                        C = b_in[7];
                        result = {b_in[6:0], b_in[7]};
                        Z = (result == 8'h00);
                        N = result[7];
                    end
                    2'b01: begin // RRC
                        C = b_in[0];
                        result = {b_in[0], b_in[7:1]};
                        Z = (result == 8'h00);
                        N = result[7];
                    end
                    2'b10: begin // SETC
                        C = 1'b1;
                        result = a_in;
                    end
                    2'b11: begin // CLRC
                        C = 1'b0;
                        result = a_in;
                    end
                endcase
            end
            
            // 7: PUSH/POP/OUT/IN
            4'h7: begin
                result = a_in;
            end
            

            // 8: NOT/NEG/INC/DEC
            4'h8: begin
                case(ra)
                    2'b00: begin // NOT
                        result = ~b_in;
                        Z = (result == 8'h00);
                        N = result[7];
                    end
                    2'b01: begin // NEG
                        result = (~b_in) + 8'h01;
                        Z = (result == 8'h00);
                        N = result[7];
                    end
                    2'b10: begin // INC 
                        result = inc9[7:0];
                        C = inc9[8];  
                        V = (b_in == 8'h7F);  
                        Z = (result == 8'h00);
                        N = result[7];
                    end
                    2'b11: begin // DEC 
                        result = dec9[7:0];
                        C = ~dec9[8];  
                        V = (b_in == 8'h80);  
                        Z = (result == 8'h00);
                        N = result[7];
                    end
                endcase
            end
            
            // 10: LOOP 
            4'hA: begin
                result = a_in - 8'h01;  // Decrement R[ra]
                Z = (result == 8'h00);
                N = result[7];
            end
            
            default: begin
                result = a_in;
            end
        endcase
    end

endmodule
