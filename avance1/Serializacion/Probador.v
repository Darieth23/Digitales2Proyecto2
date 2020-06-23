module probador(
    //salidas
    output reg [7:0] data_in0,
    output reg [7:0] data_in1,
    output reg valid_in0,
    output reg valid_in1,
    output reg reset_L,
    output reg clk_8f,
    output reg clk,
    //entradas cond
    input data_out_P2S0,
    input data_out_P2S1,
    //entradas est
    input data_out_P2S0Est,
    input data_out_P2S1Est
    );
    initial begin
        $dumpfile("serializacion.vcd");
        $dumpvars;
        data_in0 <= 8'b0;
        data_in1 <= 8'b0;
        reset_L <= 0;
        valid_in0 <= 0;
        valid_in1 <= 0;
        @(posedge clk);
        reset_L <= 1;
        @(posedge clk);
        data_in0 <= 10110101;
        data_in1 <= 11010010;
        valid_in0 <= 1;
        valid_in1 <= 1;
        @(posedge clk);
        data_in0 <= 11010110;
        data_in1 <= 10110110;
        valid_in1 <= 0;
        @(posedge clk);
        data_in0 <= 11101000;
        data_in1 <= 11110101;
        valid_in0 <= 0;
        valid_in1 <= 1;
        @(posedge clk);
        data_in0 <= 11111110;
        data_in1 <= 11010010;
        @(posedge clk);
        data_in0 <= 10110101;
        data_in1 <= 11010010;
        valid_in0 <= 1;
        @(posedge clk);
        data_in0 <= 11100011;
        data_in1 <= 11100011;     
        repeat (2) begin
            @(posedge clk);
        end
		$finish;
    end
    // Reloj
	initial	clk <= 0;
	always	#200 clk <= ~clk;
    initial clk_8f <= 0;
    always #25 clk_8f <= ~clk_8f;
endmodule

