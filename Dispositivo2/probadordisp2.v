module probador(
    //salidas
    output reg clk,
    output reg clk_8f,
    output reg data_in,
    output reg data_inser0,
    output reg reset_L,
    //entradas
    input [7:0]	data_outser1,
	input valid_outser1,
	input valid_outser0,
    input [7:0]	data_outser0
);

	initial begin
		$dumpfile("disp2.vcd");				// archivo "dump"
		$dumpvars;					// dumping de variables

		// Pruebas
		data_in <= 0;
        data_inser0 <= 0; 					
		// Pruebas #1: Reset bajo. 
		reset_L <= 0;
		// Prueba #2: Reset alto. Valido primer dato
		@(posedge clk);
		reset_L <= 1;
		// Prueba #3: Envía BC 4 veces
		repeat(4) begin
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 0;
            data_inser0 <= 0;
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 0;
            data_inser0 <= 0;
			@(posedge clk_8f);
			data_in <= 0;
            data_inser0 <= 0;
		end
		// Prueba #4: Envía 3 datos validos
		repeat(8) begin // envía FF
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
		end
		// envia EE
		repeat(2) begin
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 0;
            data_inser0 <= 0;
		end
		//envia DD
		repeat(2) begin
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 0;
            data_inser0 <= 0;
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
		end
		// Prueba #5: Envía BC de nuevo. Se espera valid_out = 0
		@(posedge clk_8f);
		data_in <= 1;
        data_inser0 <= 1;
		@(posedge clk_8f);
		data_in <= 0;
        data_inser0 <= 0;
		@(posedge clk_8f);
		data_in <= 1;
        data_inser0 <= 1;
		@(posedge clk_8f);
		data_in <= 1;
        data_inser0 <= 1;
		@(posedge clk_8f);
		data_in <= 1;
        data_inser0 <= 1;
		@(posedge clk_8f);
		data_in <= 1;
        data_inser0 <= 1;
		@(posedge clk_8f);
		data_in <= 0;
        data_inser0 <= 0;
		@(posedge clk_8f);
		data_in <= 0;
        data_inser0 <= 0;
		// Prueba 6: Vuelve a enviar otro dato valido
		// envia AA
		repeat(4) begin
			@(posedge clk_8f);
			data_in <= 1;
            data_inser0 <= 1;
			@(posedge clk_8f);
			data_in <= 0;
            data_inser0 <= 0;
		end
		// Prueba 7: Reset alto y termina de almacenar señales
		repeat(7) begin
			@(posedge clk_8f);
		end
		reset_L <= 0;
		@(posedge clk);
		$finish;	
	end
	// Generador del clk
	initial	begin
		clk <= 0;				// Valor inicial del clk_4f
		clk_8f <= 0;				// Valor inicial del clk_32f
	end
	always #1 clk_8f <= ~clk_8f;		// toggle cada 1ns -> 8f = 500MHz
	always #8 clk <= ~clk;			// toggle cada 8ns -> f = 62,5MHz
endmodule