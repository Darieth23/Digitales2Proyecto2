module serialtopar(
	output reg[7:0]	data_outser1,			// salida en paralelo de 8b
	output reg valid_outser1,
	input 			clk,			// señal de clock del modulo
	input			clk_8f,			// señal de clock a 8f
	input 			reset_L,		// señal de reset del modulo
	input 			data_in 		// entrada de datos serial
	);
	reg 			active;		 	// regs internos de 1 bit
	reg [7:0]		buffer;			// reg desplazante que recibe los datos
	reg [2:0]		bc_cnt;			// reg que cuenta la cantidad de datos de control bc
	wire [7:0]		shift_reg;

	assign shift_reg = {buffer[7:0],data_in};

	always @(posedge clk_8f) begin			// bloque sincrono
		if (!reset_L) begin			// reset de los flops 
			buffer <= 0;
	
		end
		else begin
			buffer <= shift_reg;
		end
    end	

    always @(posedge clk) begin			// bloque sincrono
		if (!reset_L) begin			// reset de los flops 
			data_outser1 <= 0;
			valid_outser1 <= 0;
			bc_cnt <= 0;
			active <= 0;
		end
		else begin					// asignacion de los flops de manera sincrona
			data_outser1<=shift_reg;			
			if (shift_reg==8'hbc)begin
				bc_cnt <= bc_cnt +1;
				valid_outser1 <= 0;
			end
			else begin
				bc_cnt <= 0;
			end
			if (bc_cnt >= 4) begin
				active = 1;
			end
			if (active && shift_reg!=8'hbc)begin
				valid_outser1 <= 1;
			end
		end	
    end
endmodule 
