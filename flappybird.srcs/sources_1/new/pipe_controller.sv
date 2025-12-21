module pipe_controller#(
    parameter NUM_PIPES = 4,
    parameter VELOCITY = 2,
    parameter GAP_WIDTH = 100
)(
    input logic clk_100mhz,
    input logic ce_60hz,
    input logic rst,
    input logic create_new_game,
    input logic move,
    output logic signed [11:0] x_pos_arr [0:NUM_PIPES-1],
    output logic signed [9:0] gap_y_pos_arr [0:NUM_PIPES-1]
    );
    
    
    pipe#(
    .VELOCITY(VELOCITY),
    .START_X(650+0*640/NUM_PIPES),
    .RNG_SEED(50),
    .GAP_WIDTH(GAP_WIDTH)
    )pipe0(
    .clk_100mhz(clk_100mhz),
    .ce_60hz(ce_60hz),
    .rst(rst),
    .create_new_game(create_new_game),
    .move(move),
    .x_pos(x_pos_arr[0]), //middle of the pipe
    .gap_y_pos(gap_y_pos_arr[0]) //top of the gap
    );
    
    pipe#(
    .VELOCITY(VELOCITY),
    .START_X(650+1*640/NUM_PIPES),
    .RNG_SEED(100),
    .GAP_WIDTH(GAP_WIDTH)
    )pipe1(
    .clk_100mhz(clk_100mhz),
    .ce_60hz(ce_60hz),
    .rst(rst),
    .create_new_game(create_new_game),
    .move(move),
    .x_pos(x_pos_arr[1]), //middle of the pipe
    .gap_y_pos(gap_y_pos_arr[1]) //top of the gap
    );
    
    pipe#(
    .VELOCITY(VELOCITY),
    .START_X(650+2*640/NUM_PIPES),
    .RNG_SEED(150),
    .GAP_WIDTH(GAP_WIDTH)
    )pipe2(
    .clk_100mhz(clk_100mhz),
    .ce_60hz(ce_60hz),
    .rst(rst),
    .create_new_game(create_new_game),
    .move(move),
    .x_pos(x_pos_arr[2]), //middle of the pipe
    .gap_y_pos(gap_y_pos_arr[2]) //top of the gap
    );
    
    pipe#(
    .VELOCITY(VELOCITY),
    .START_X(650+3*640/NUM_PIPES),
    .RNG_SEED(200),
    .GAP_WIDTH(GAP_WIDTH)
    )pipe3(
    .clk_100mhz(clk_100mhz),
    .ce_60hz(ce_60hz),
    .rst(rst),
    .create_new_game(create_new_game),
    .move(move),
    .x_pos(x_pos_arr[3]), //middle of the pipe
    .gap_y_pos(gap_y_pos_arr[3]) //top of the gap
    );
    
    
endmodule
