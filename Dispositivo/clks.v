`timescale 1ns/1ps

module gen_clk(
				input			reloj_32f,
				input			rst,
				output reg		reloj_4f,
				output reg		reloj_2f,
				output reg		reloj_f	 
				);

	
				reg [3:0] counter4f;
				reg [4:0] counter2f;
				reg [5:0] counterf;
				reg bandera;

	always@(posedge reloj_32f) begin
        
		if(!rst) begin
		    	counter4f <= 0;
			counter2f <= 0;
			counterf <= 0;
				
		    	reloj_4f <= 1'b0;
			reloj_2f <= 1'b0;
		    	reloj_f <= 1'b0;
			bandera = 0;
		end

		else begin				
				if (bandera==0) begin
		            		bandera=1;
					reloj_4f <= 1'b1;
					reloj_2f <= 1'b1;
		    			reloj_f <= 1'b1;
 	
		        	end


		        	if (counter4f < 4) begin
		            		counter4f <= counter4f + 'b1; 	
		        	end
					
		        	else begin
		            		counter4f <= 'b1;
		            		reloj_4f <= ~reloj_4f;
				end

						
				if (counter2f < 8) begin
					counter2f <= counter2f + 'b1; 
				end
				
				else begin
					counter2f <= 'b1;
					reloj_2f <= ~reloj_2f;
				end
						
				if (counterf < 16) begin
					counterf <= counterf + 'b1;
				end
			
				else begin
					counterf <= 'b1;
					reloj_f <= ~reloj_f;

				end					
        	end
	end
  


endmodule
