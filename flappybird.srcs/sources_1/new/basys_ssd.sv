module basys_ssd(
    input logic clk, // 100MHz system clock
    input logic ce_1khz,
    input logic rst, // Active High reset
    input logic [6:0] ssd_in [3:0], // The four digits to display
    output logic [3:0] an, // Which display to drive
    output logic [6:0] seg // The number to display
);
    logic [1:0] digit_to_display;
    
    assign an = (4'b1110 << digit_to_display) | (4'b1110 >> (4 - digit_to_display));
    assign seg=ssd_in[digit_to_display];
    
    
    always_ff @(posedge clk)
    begin
        if(rst) 
            digit_to_display<=0;
        else if(ce_1khz) begin
            digit_to_display<=digit_to_display+1;
        end
    end
endmodule