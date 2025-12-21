module binary_to_ssd (
    input logic [$clog2(10000)-1:0] binary_in, // up to 9999
    output logic [6:0] display_out [3:0] // 4 arrays of 7 bits
);
    logic [3:0] ones,tens,hundreds,thousands;
    assign ones=binary_in%10;
    assign tens=(binary_in/10)%10;
    assign hundreds=(binary_in/100)%10;
    assign thousands=(binary_in/1000)%10;
    
    
    seven_seg_display ssd_inst_ones(
        .digit(ones),
        .displayBits(display_out[0])
    );
    seven_seg_display ssd_inst_tens(
        .digit(tens),
        .displayBits(display_out[1])
    );
    seven_seg_display ssd_inst_hundreds(
        .digit(hundreds),
        .displayBits(display_out[2])
    );
    seven_seg_display ssd_inst_thousands(
        .digit(thousands),
        .displayBits(display_out[3])
    );
endmodule
