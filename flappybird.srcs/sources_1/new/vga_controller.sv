module vga_controller(
		input logic clk,
		input logic reset,
		output logic hsync,
		output logic vsync,
		output logic video_on,
		output logic p_tick,
		output logic signed [10:0] x,
		output logic signed [10:0] y
	);
	
	// constant declarations for VGA sync parameters
	localparam HPIXELS = 640; // horizontal display area
	localparam HBP = 48; // horizontal left border
	localparam HFP = 16; // horizontal right border
	localparam HPULSE = 96; // horizontal retrace
	
	localparam VPIXELS = 480; // vertical display area
	localparam VFP = 10; // vertical top border
	localparam VBP = 33; // vertical bottom border
	localparam VPULSE = 2; // vertical retrace
	
	// mod-4 counter to generate 25 MHz pixel tick
	logic [1:0] pixel_reg;
	logic pixel_tick;
	
	always @(posedge clk, posedge reset)
		if(reset)
		  pixel_reg <= 0;
		else
		  pixel_reg <= pixel_reg+1;
		
	assign pixel_tick = (pixel_reg == 0); // assert tick 1/4 of the time
	
	// registers to keep track of current pixel location
	logic signed [10:0] h_count_reg, h_count_next, v_count_reg, v_count_next;
	
	// register to keep track of vsync and hsync signal states
	logic vsync_reg, hsync_reg, vsync_next, hsync_next;
 
	// infer registers
	always @(posedge clk, posedge reset)
		if(reset)
		    begin
                    v_count_reg <= 0;
                    h_count_reg <= 0;
                    vsync_reg <= 0;
                    hsync_reg <= 0;
		    end
		else
		    begin
                    v_count_reg <= v_count_next;
                    h_count_reg <= h_count_next;
                    vsync_reg <= vsync_next;
                    hsync_reg <= hsync_next;
		    end
			
	// next-state logic of horizontal vertical sync counters
	always_comb
		begin
		h_count_next = pixel_tick ? (h_count_reg == $signed(HPIXELS+HFP+HBP+HPULSE-1) ? 0 : h_count_reg + 1 ) : h_count_reg;
		v_count_next = pixel_tick && h_count_reg == $signed(HPIXELS+HFP+HBP+HPULSE-1) ? (v_count_reg == VPIXELS+VFP+VBP+VPULSE-1 ? 0 : v_count_reg + 1) : v_count_reg;
		end
		
        // hsync and vsync are active low signals
        // hsync signal asserted during horizontal retrace
        assign hsync_next = h_count_reg >= HPIXELS+HFP
                            && h_count_reg <= HPIXELS+HFP+HPULSE-1;
   
        // vsync signal asserted during vertical retrace
        assign vsync_next = v_count_reg >= VPIXELS+VFP 
                            && v_count_reg <= VPIXELS+VFP+VPULSE-1;

        // video only on when pixels are in both horizontal and vertical display region
        assign video_on = (h_count_reg < HPIXELS) 
                          && (v_count_reg < VPIXELS);

        // output signals
        assign hsync = hsync_reg;
        assign vsync = vsync_reg;
        assign x = h_count_reg;
        assign y = v_count_reg;
        assign p_tick = pixel_tick;
endmodule