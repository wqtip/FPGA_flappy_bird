module lfsr(
    input logic clk_100mhz,
    input logic ce_60hz,
    input logic rst,
    input logic [8:0] seed,
    output logic [8:0] rand_num
    );
    
    logic [8:0] shift_reg;
    logic feedback;
    assign feedback=shift_reg[8] ^ shift_reg[3];
    assign rand_num=shift_reg;
    
    always_ff @(posedge clk_100mhz or posedge rst)
    begin
        if(rst) begin
            shift_reg<=seed;
        end else if(ce_60hz) begin
            shift_reg<={shift_reg[7:0],feedback};
        end
    end
endmodule
