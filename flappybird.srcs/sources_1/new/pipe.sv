module pipe #(
    parameter VELOCITY = 50,
    parameter START_X = 650,
    parameter RNG_SEED = 314,
    parameter GAP_WIDTH = 100
)(
    input logic clk_100mhz,
    input logic ce_60hz,
    input logic rst,
    input logic create_new_game,
    input logic move,
    output logic signed [11:0] x_pos, //middle of the pipe
    output logic signed [9:0] gap_y_pos //top of the gap
);

    // LFSR output inside 60 Hz domain
    logic [8:0] rand_val;

    lfsr lfsr_inst (
        .clk_100mhz(clk_100mhz),
        .ce_60hz(ce_60hz),
        .rst(rst),
        .seed(RNG_SEED),
        .rand_num(rand_val)
    );

    always_ff @(posedge clk_100mhz or posedge rst) begin
        if (rst) begin
            x_pos <= START_X;
            gap_y_pos <= 190;  // initial value
        end else if (create_new_game) begin
            x_pos<=START_X;
            gap_y_pos <= $signed({1'b0,rand_val % (481-GAP_WIDTH)});
        end else if(ce_60hz && move) begin
            if (x_pos > -10) begin
                x_pos <= x_pos - VELOCITY;
            end else begin
                x_pos <= 650;
                gap_y_pos <= $signed({1'b0,rand_val % (481-GAP_WIDTH)});  // latch new random gap
            end
        end
    end
endmodule
