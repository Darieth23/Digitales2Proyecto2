module probadordest(
    //salidas
    output reg pop0,
    output reg pop1,
    output reg [9:0] datain_dest0,
    output reg [9:0] datain_dest1,
    output reg reset_L,
    output reg clk,
    //entradas mux dest
    input validoutdest,
    input [9:0] dataout_dest,
    //entradas Est
    input validoutdestEst,
    input [9:0] dataout_destEst  
    );
    initial begin
        $dumpfile("mux2a1_dest.vcd");
        $dumpvars;
        pop0 <= 0;
        pop1 <= 0;
        datain_dest0 <= 10'b0;
        datain_dest1 <= 10'b0;
        reset_L <= 0;
        @(posedge clk);
        reset_L <= 1;
        @(posedge clk);
        pop0 <= 1;
        datain_dest0 <= 1011011010;
        datain_dest1 <= 1101011010;
        @(posedge clk);
        pop0 <= 0;
        pop1 <= 1;
        datain_dest0 <= 1011101011;
        datain_dest1 <= 1011010110;
        @(posedge clk);
        pop0 <= 1;
        pop1 <= 0;
        datain_dest0 <= 0110101110;
        datain_dest1 <= 1011101001;
        @(posedge clk);
        pop0 <= 0;
        pop1 <= 1;
        datain_dest0 <= 1110101101;
        datain_dest1 <= 1001011011;
        @(posedge clk);
        pop0 <= 0;
        pop1 <= 0;
        datain_dest0 <= 1011101010;
        datain_dest1 <= 1011010110;
        @(posedge clk);
        datain_dest0 <= 1011011010;
        datain_dest1 <= 1111011010;
        @(posedge clk);
        datain_dest0 <= 1010100101;
        datain_dest1 <= 1111010000;
        @(posedge clk);
        datain_dest0 <= 1010010110;
        datain_dest1 <= 0001010010;
        @(posedge clk);
        pop0 <= 1;
        pop1 <= 1;
        datain_dest0 <= 1011010110;
        datain_dest1 <= 1001010110;
        @(posedge clk);
        datain_dest0 <= 1101110010;
        datain_dest1 <= 1011101010;
        @(posedge clk);
        datain_dest0 <= 1011010101;
        datain_dest1 <= 1011010110;
        @(posedge clk);
        pop0 <= 0;
        @(posedge clk);
        datain_dest1 <= 1111111111;
        repeat (2) begin
            @(posedge clk);
        end
		$finish;
    end
    // Reloj
	initial	clk <= 0;
	always	#100 clk <= ~clk;
endmodule




