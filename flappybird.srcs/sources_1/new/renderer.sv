
module renderer#(
    parameter HALF_BIRD_HEIGHT = 15,
    parameter BIRD_X = 100,
    parameter HALF_PIPE_WIDTH = 20,
    parameter GAP_WIDTH = 100,
    parameter NUM_PIPES = 4
    )(
    input logic signed [9:0] bird_y,
    input logic signed [10:0] pixel_x,
    input logic signed [10:0] pixel_y,
    input logic video_on,
    input logic signed [11:0] x_pos_arr [0:NUM_PIPES-1],
    input logic signed [9:0] gap_y_pos_arr [0:NUM_PIPES-1],
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b
    );
    
    
    always_comb begin
        if(video_on) begin
            //background
            r=15;
            g=5;
            b=8;
            
            //if pipe is hit
            for(int i=0;i<NUM_PIPES;i++) begin
                automatic logic signed [11:0] pipe_left  = x_pos_arr[i] - HALF_PIPE_WIDTH;
                automatic logic signed [11:0] pipe_right = x_pos_arr[i] + HALF_PIPE_WIDTH;
                automatic logic signed [9:0] gap_top = gap_y_pos_arr[i];
                automatic logic signed [9:0] gap_bottom = gap_y_pos_arr[i] + GAP_WIDTH;
                    
                if(pixel_x>=pipe_left && pixel_x<=pipe_right) begin
                    if(pixel_y<=gap_top || pixel_y>=gap_bottom) begin
                        r=0;
                        g=15;
                        b=0;
                    end
                end
            end
            //if bird
            if(pixel_x>=BIRD_X-HALF_BIRD_HEIGHT &&
               pixel_x<=BIRD_X+HALF_BIRD_HEIGHT &&
               pixel_y>=bird_y-HALF_BIRD_HEIGHT &&
               pixel_y<=bird_y+HALF_BIRD_HEIGHT) 
            begin
                r=15;
                g=15;
                b=0;
            end
        end else begin
            r=0;
            g=0;
            b=0;
        end
    end
endmodule
