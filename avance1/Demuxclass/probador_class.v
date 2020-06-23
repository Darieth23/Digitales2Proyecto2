module probadorclass(
    //salidas
    output reg reset_L,
    output reg clk,
    output reg [7:0] datain_class,
    output reg class,
    output reg dest,
    //entradas class
    input [9:0] outclass0,
    input [9:0] outclass1,
    //entradas Est
    input [9:0] outclass0Est,
    input [9:0] outclass1Est    
    );
    initial begin
        $dumpfile("demux1a2class.vcd");
        $dumpvars;
        reset_L <= 0;
        datain_class <= 0;
        class <= 0;
        dest <= 0;
        @(posedge clk);
        reset_L <= 1;
        @(posedge clk);
        datain_class <= 00000000;
        class <= 1;
        dest <= 0;
        @(posedge clk);
        class <= 1;
        dest <= 0;
        datain_class <= 00000001;
        @(posedge clk);
        class <= 0;
        dest <= 0;
        datain_class <= 00000001;
        @(posedge clk);
        class <= 1;
        dest <= 0;
        datain_class <= 00000011;
        @(posedge clk);
        class <= 0;
        dest <= 0;
        datain_class <= 00000111;
        @(posedge clk);
        class <= 0;
        dest <= 0;
        datain_class <= 00000111;
        @(posedge clk);
        class <= 0;
        dest <= 0;
        datain_class <= 00001111;
		repeat (2) begin
            @(posedge clk);
        end
		$finish;
    end
    // Reloj
	initial	clk <= 0;
	always	#100 clk <= ~clk;
endmodule

