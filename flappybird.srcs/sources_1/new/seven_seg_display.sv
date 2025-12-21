module seven_seg_display(
    input logic [3:0] digit,
    output logic [6:0] displayBits
    );
    
    always_comb begin
        case (digit)
            4'd0: begin
                displayBits=7'b1000000;
            end
            4'd1: begin
                displayBits=7'b1111001;
            end
            4'd2: begin
                displayBits=7'b0100100;
            end
            4'd3: begin
                displayBits=7'b0110000;
            end
            4'd4: begin
                displayBits=7'b0011001;
            end
            4'd5: begin
                displayBits=7'b0010010;
            end
            4'd6: begin
                displayBits=7'b0000010;
            end
            4'd7: begin
                displayBits=7'b1111000;
            end
            4'd8: begin
                displayBits=7'b0000000;
            end
            4'd9: begin
                displayBits=7'b0010000;
            end
            default: begin
                displayBits=7'b1111111;
            end            
        endcase
    end
endmodule
