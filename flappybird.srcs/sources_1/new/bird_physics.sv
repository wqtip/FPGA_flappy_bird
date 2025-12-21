module bird_physics(
    input  logic ce_60hz,
    input  logic clk_100mhz,
    input  logic rst,
    input  logic create_new_game,
    input  logic alive,
    input  logic flap,
    output logic signed [9:0] bird_y
);

    //100mhz domain flap detect+sync
    logic flap_sync1, flap_sync2, prev_flap;
    logic flap_pos_edge;

    always_ff @(posedge clk_100mhz or posedge rst) begin
        if (rst || create_new_game) begin
            flap_sync1 <= 1'b0;
            flap_sync2 <= 1'b0;
            prev_flap  <= 1'b0;
        end else begin
            flap_sync1 <= flap;
            flap_sync2 <= flap_sync1;
            prev_flap  <= flap_sync2;
        end
    end

    assign flap_pos_edge = flap_sync2 & ~prev_flap;


    // cross from 100mhz to 60 hz
    logic flap_toggle;

    always_ff @(posedge clk_100mhz or posedge rst) begin
        if (rst || create_new_game)
            flap_toggle <= 1'b0;
        else if (flap_pos_edge)
            flap_toggle <= ~flap_toggle;
    end


    // 60hz domain flap detect+sync
    logic ft_sync1, ft_sync2;
    
    always_ff @(posedge clk_100mhz or posedge rst) begin
        if (rst || create_new_game) begin
            ft_sync1 <= 1'b0;
            ft_sync2 <= 1'b0;
        end else if(ce_60hz) begin
            ft_sync1 <= flap_toggle;
            ft_sync2 <= ft_sync1;
        end
    end

    logic flap_edge_60hz;
    assign flap_edge_60hz = ft_sync1 ^ ft_sync2;


    //fixed point physics
    //Q6.4 fixed point
    logic signed [11:0] velocity_fp;

    //(Q6.4)
    localparam signed [11:0] GRAVITY_FP = 12'sd6;    // 6/16=0.375 px/frame^2
    localparam signed [11:0] FLAP_VEL_FP = -12'sd96;  // -96/16=-6.0 px/frame
    localparam signed [11:0] MAX_FALL_VEL_FP = 12'sd96;   // 96/16=6.0 px/frame

    always_ff @(posedge clk_100mhz or posedge rst) begin
        if (rst || create_new_game) begin
            velocity_fp <= 12'sd0;
            bird_y <= 10'sd240;   // start near middle
        end else if (ce_60hz && alive) begin
            if (flap_edge_60hz) velocity_fp <= FLAP_VEL_FP;
            else velocity_fp <= (velocity_fp + GRAVITY_FP > MAX_FALL_VEL_FP) ? MAX_FALL_VEL_FP : velocity_fp + GRAVITY_FP;
            bird_y <= bird_y + (velocity_fp >>> 4);
        end
    end
endmodule
