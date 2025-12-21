
module clk_div(
    input  logic i_clk,   // 100 MHz
    input  logic rst,
    output logic o_ce_60hz,
    output logic o_ce_1khz
);
    

    // 60 Hz enable (NOT a clock)
    logic [$clog2(1666667)-1:0] div60;

    always_ff @(posedge i_clk) begin
        if (rst)
            div60 <= 0;
        else if (div60 == 1666666)
            div60 <= 0;
        else
            div60 <= div60 + 1;
    end

    assign o_ce_60hz = (div60 == 1666666); // pulse enable
    
    
    // 1khz enable (NOT a clock)
    logic [$clog2(1000)-1:0] div1000;

    always_ff @(posedge i_clk) begin
        if (rst)
            div1000 <= 0;
        else if (div1000 == 999)
            div1000 <= 0;
        else
            div1000 <= div1000 + 1;
    end

    assign o_ce_1khz = (div1000 == 999); // pulse enable

endmodule

