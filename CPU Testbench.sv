module CPU_tb();
    reg clk;
    reg reset;
    reg [18:0] instruction;

    wire [18:0] pc;
    wire [18:0] alu_result;

    CPU uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .alu_result(alu_result)
    );

    always #10 clk = ~clk;  

    initial begin
        clk = 0;
        reset = 1;
        instruction = 19'b0;

        #2 reset = 0;
        
        instruction = 19'b0000_001_010_011;  
        #5;
        instruction = 19'b0110_001_000_100;  
        #5;
        instruction = 19'b0111_100_000_101;  
        #5;
        instruction = 19'b0100_001_010_110;  
        #5;
        #25 $stop;
    end
endmodule
