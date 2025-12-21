
module top#(
    parameter NUM_PIPES=4,
    parameter VELOCITY=2,
    parameter GAP_WIDTH=160,
    parameter HALF_BIRD_HEIGHT = 15,
    parameter BIRD_X = 100,
    parameter HALF_PIPE_WIDTH  = 20
    )(
    input logic clk,
    input logic rst,
    input logic new_game,
    input logic i_flap,
    output logic [3:0] o_r,
    output logic [3:0] o_g,
    output logic [3:0] o_b,
    output logic hsync,
    output logic vsync,
    output logic [3:0] an,
    output logic [6:0] seg
    );

    logic move;
    logic alive;
    logic collision;
    logic ce_60hz;
    logic ce_1khz;
    logic signed [9:0] bird_y;
    logic signed [11:0] x_pos_arr [0:NUM_PIPES-1];
    logic signed [9:0] gap_y_pos_arr [0:NUM_PIPES-1];
    logic [6:0] display_digits [3:0];
    logic [$clog2(9999)-1:0] score;
    logic debounced_flap;
    logic signed [10:0] hc;
    logic signed [10:0] vc;
    logic video_on;
    logic score_en;
    logic create_new_game;
    
    
    
    typedef enum logic [1:0] {
        RESET = 2'b00,
        PLAYING = 2'b01,
        GAME_OVER = 2'b10
    } state_t;

    state_t current_state, next_state;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= RESET;
        else
            current_state <= next_state;
    end
    
    assign create_new_game=(current_state!=PLAYING && new_game);
    
    //state logic 
    always_comb begin
        next_state = current_state;
        
        case (current_state)
            RESET: begin
                if (debounced_flap)
                    next_state = PLAYING;
            end
            
            PLAYING: begin
                if(collision) next_state = GAME_OVER;
            end
            
            GAME_OVER: begin
                if(new_game) next_state=RESET;
            end
        endcase
    end
    
    //control signals based on state
    
    always_comb begin
        move=0;
        alive=0;
        score_en=0;
        case (current_state)
            RESET: begin
                move=0;
                alive=0;
                score_en=0;
            end
            
            PLAYING: begin
                move=1;
                alive=1;
                score_en=1;
            end
            
            GAME_OVER: begin
                move=0;
                alive=0;
                score_en=0;
            end
        endcase
    end
    
    vga_controller vga_controller_inst(
        .clk(clk),
		.reset(rst),
		.hsync(hsync),
		.vsync(vsync),
		.video_on(video_on),
		.x(hc),
		.y(vc)
    );
    renderer#(
        .HALF_BIRD_HEIGHT(HALF_BIRD_HEIGHT),
        .BIRD_X(BIRD_X),
        .HALF_PIPE_WIDTH(HALF_PIPE_WIDTH),
        .GAP_WIDTH(GAP_WIDTH),
        .NUM_PIPES(NUM_PIPES)
    )renderer_inst(
        .bird_y(bird_y),
        .pixel_x(hc),
        .pixel_y(vc),
        .video_on(video_on),
        .x_pos_arr(x_pos_arr),
        .gap_y_pos_arr(gap_y_pos_arr),
        .r(o_r),
        .g(o_g),
        .b(o_b)
    );        
    bird_physics bird_physics_inst(
        .ce_60hz(ce_60hz),
        .clk_100mhz(clk),
        .rst(rst),
        .create_new_game(create_new_game),
        .alive(alive),
        .flap(debounced_flap),
        .bird_y(bird_y)
    );
    pipe_controller#(
        .NUM_PIPES(NUM_PIPES),
        .VELOCITY(VELOCITY),
        .GAP_WIDTH(GAP_WIDTH)
    )pipe_controller_inst(
        .clk_100mhz(clk),
        .ce_60hz(ce_60hz),
        .rst(rst),
        .create_new_game(create_new_game),
        .move(move),
        .x_pos_arr(x_pos_arr),
        .gap_y_pos_arr(gap_y_pos_arr)
    );
    collision_detector#(
        .HALF_BIRD_HEIGHT(HALF_BIRD_HEIGHT),
        .BIRD_X(BIRD_X),
        .HALF_PIPE_WIDTH(HALF_PIPE_WIDTH),
        .GAP_WIDTH(GAP_WIDTH),
        .NUM_PIPES(NUM_PIPES)
    )collision_detector_inst(
        .bird_y(bird_y),
        .x_pos_arr(x_pos_arr),
        .gap_y_pos_arr(gap_y_pos_arr),
        .collision(collision)
    );
    input_debounce #(
        .STABLE_COUNT(100000)  // 1 ms at 100 MHz
    )input_debounce_inst(
        .clk(clk),
        .rst(rst),
        .noisy_in(i_flap),       
        .debounced_out(debounced_flap)
    );
    clk_div clk_div_inst(
        .i_clk(clk),
        .rst(rst),
        .o_ce_60hz(ce_60hz),
        .o_ce_1khz(ce_1khz)
    );
    score#(
        .NUM_PIPES(NUM_PIPES),
        .BIRD_X(BIRD_X),
        .VELOCITY(VELOCITY)
    )score_inst(
        .clk_100mhz(clk),
        .ce_60hz(ce_60hz),
        .rst(rst),
        .create_new_game(create_new_game),
        .score_en(score_en),
        .x_pos_arr(x_pos_arr),
        .score(score)
    );
    binary_to_ssd binary_to_ssd_inst (
        .binary_in(score),
        .display_out(display_digits)
    );
    
    basys_ssd basys_ssd_inst (
        .clk(clk),
        .ce_1khz(ce_1khz),
        .rst(rst),
        .ssd_in(display_digits),
        .an(an),
        .seg(seg)
    );
    
endmodule
