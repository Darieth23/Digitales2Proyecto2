module mux_final(
    //inputs
    input [7:0] data_in,
    //outputs
    output reg [7:0] data_out
);
    always @ (*) begin
        data_out = 8'b0;
        if(data_in == xxxxxxxx) begin
            data_out = 8'b0;
        end
        else begin
            data_out = data_in;
        end
    end
endmodule