module probadordest(
    //salidas
    output reg reset_L,
    output reg clk,
    output reg [7:0] datain_dest,
    output reg class,
    output reg dest,
    //entradas class
    input [7:0] outdest0,
    input [7:0] outdest1,
    //entradas Est
    input [7:0] outdest0Est,
    input [7:0] outdest1Est    
    );
    initial begin
        $dumpfile("demux1a2dest.vcd");
        $dumpvars;
        reset_L <= 0;
        datain_dest <= 0;
        class <= 0;
        dest <= 0;
        @(posedge clk);
        reset_L <= 1;
        @(posedge clk);
        datain_dest <= 00001111;
        class <= 0;
        dest <= 1;
        @(posedge clk);
        datain_dest <= 00000001;
        class <= 0;
        dest <= 0;
        @(posedge clk);        
        datain_dest <= 00000001;
        class <= 0;
        dest <= 1;
        @(posedge clk);
        datain_dest <= 0000000011;
        class <= 0;
        dest <= 0;
        @(posedge clk);
        datain_dest <= 0100000011;
        class <= 0;
        dest <= 1;
        @(posedge clk);
        datain_dest <= 00000111;
        class <= 0;
        dest <= 0;
        @(posedge clk);
        datain_dest <= 0100000111;
        class <= 0;
        dest <= 1;
        @(posedge clk);
        datain_dest <= 0000001111;
		class <= 0;
        dest <= 0;
        repeat (2) begin
            @(posedge clk);
        end
		$finish;
    end
    // Reloj
	initial	clk <= 0;
	always	#100 clk <= ~clk;
endmodule

