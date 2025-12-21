module score#(
    parameter NUM_PIPES = 4,
    parameter BIRD_X = 100,
    parameter VELOCITY = 2
    )(
    input logic clk_100mhz,
    input logic ce_60hz,
    input logic rst,
    input logic create_new_game,
    input logic score_en,
    logic signed [11:0] x_pos_arr [0:NUM_PIPES-1],
    output logic [$clog2(9999)-1:0] score
    );
    
    logic [31:0] count_since_last_score [0:NUM_PIPES-1];
    localparam logic [31:0] counter_limit=(BIRD_X/VELOCITY)<<1;
    
    
    always_ff @(posedge clk_100mhz) begin
        if(rst || create_new_game) begin
            score<=0;
            for(int i=0;i<NUM_PIPES;i++) begin
                count_since_last_score[i]<=0;
            end
        end else if(ce_60hz && score_en) begin
            for(int i=0;i<NUM_PIPES;i++) begin
                if(x_pos_arr[i]<BIRD_X && count_since_last_score[i]>counter_limit) begin
                    count_since_last_score[i]<=0;
                    score<=score+1;
                end else begin
                    count_since_last_score[i]<=count_since_last_score[i]+1;
                end
            end
        end
    end
endmodule
