module probador(
    //salidas
    output reg [7:0]data_in,
    output reg valid_in,
    output reg reset_L,
    output reg clk_8f,
    output reg clk,
    //entradas conductual
    input data_out_P2S,
    //entradas estructural
    input data_out_P2SEst
    );
    initial begin
        $dumpfile("paraser.vcd");
        $dumpvars;
        data_in <= 8'b0;
        reset_L <= 0;
        valid_in <= 0;
        @(posedge clk);
        reset_L <= 1;
        @(posedge clk);
        data_in <= 10110101;
        valid_in <= 1;
        @(posedge clk);
        data_in <= 10111011;
        @(posedge clk);
        data_in <= 11010110;
        valid_in <= 0;
        @(posedge clk);
        data_in <= 11011110;
        @(posedge clk);
        data_in <= 11010010;
        valid_in <= 1;
        @(posedge clk);
        data_in <= 110010101;
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

