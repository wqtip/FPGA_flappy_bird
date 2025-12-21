module collision_detector#(
    parameter HALF_BIRD_HEIGHT = 15,
    parameter BIRD_X = 100,
    parameter HALF_PIPE_WIDTH = 20,
    parameter GAP_WIDTH = 100,
    parameter NUM_PIPES = 4
)(
    input  logic signed [9:0] bird_y,
    input  logic signed [11:0] x_pos_arr [0:NUM_PIPES-1],
    input  logic signed [9:0] gap_y_pos_arr [0:NUM_PIPES-1],
    output logic collision
);

    always_comb begin
        collision = 0;

        if (bird_y < HALF_BIRD_HEIGHT || bird_y > 480 - HALF_BIRD_HEIGHT)
            collision = 1;
        else begin
            automatic logic signed [9:0] bird_top = bird_y - HALF_BIRD_HEIGHT;
            automatic logic signed [9:0] bird_bottom = bird_y + HALF_BIRD_HEIGHT;
            automatic logic signed [9:0] bird_left = BIRD_X - HALF_BIRD_HEIGHT;
            automatic logic signed [9:0] bird_right = BIRD_X + HALF_BIRD_HEIGHT;
            for (int i = 0; i < NUM_PIPES; i++) begin
                automatic logic signed [11:0] pipe_left = x_pos_arr[i] - HALF_PIPE_WIDTH;
                automatic logic signed [11:0] pipe_right = x_pos_arr[i] + HALF_PIPE_WIDTH;
                // Horizontal overlap
                if (pipe_left <= bird_right && pipe_right >= bird_left) begin
                    // Vertical gap limits
                    automatic logic signed [9:0] gap_top = gap_y_pos_arr[i];
                    automatic logic signed [9:0] gap_bottom = gap_y_pos_arr[i] + GAP_WIDTH;
                    // Vertical collision (outside gap)
                    if (bird_top < gap_top || bird_bottom > gap_bottom)
                        collision = 1;
                end
            end
        end
    end
endmodule
