module CPU (
    input clk,
    input reset,
    output reg [18:0] pc,
    input [18:0] instruction,
    output reg [18:0] alu_result
);
    reg [18:0] registers [0:7];
    reg [18:0] ir; 

    reg [18:0] src1, src2;

    reg [18:0] key;  

    wire [3:0] opcode = instruction[18:15];  
    wire [2:0] rs1 = instruction[14:12];    
    wire [2:0] rs2 = instruction[11:9];     
    wire [2:0] rd = instruction[8:6];       

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;
            key <= 19'h7FFFF; 
        end else begin
            ir <= instruction;
            pc <= pc + 1;

            src1 <= registers[rs1];
            src2 <= registers[rs2];

            case (opcode)
                4'b0000: alu_result <= src1 + src2; 
                4'b0001: alu_result <= src1 - src2; 
                4'b0010: alu_result <= src1 & src2; 
                4'b0011: alu_result <= src1 | src2; 
                4'b0100: alu_result <= src1 ^ src2;
                4'b0101: alu_result <= ~src1;      
                4'b0110: alu_result <= src1 ^ key;  
                4'b0111: alu_result <= src2 ^ key;  
                default: alu_result <= 0; 
            endcase

            registers[rd] <= alu_result;
        end
    end   
endmodule
