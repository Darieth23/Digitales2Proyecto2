`timescale 1ns/1ps
`include "RAM_memory_vc1.v"


module fifo_vc1#(
    //Parametros
    parameter DATA_SIZE_vc1 = 10,    //Antes estaba en 6           //cantidad de bits de entrada
    parameter MAIN_QUEUE_SIZE_vc1 = 8 //Antes estaba en  4        //Cantidad de filas del vc1 fifo    
)(
    input                               clk,
    input                               reset_L,
    input                               pop_vc1,
    input                               push_vc1,
    input       [DATA_SIZE_vc1-1:0]         data_vc1,            //datos para hacerle push
    input       [3:0]         afVC_o,               //umbral almost full vc1 buffer
    input       [3:0]         aeVC_o,               // umbral almost empty vc1 buffer
    
    //Estados del FIFO
    //output reg                          fifo_full_vc1,
    output reg                          fifo_empty_vc1, 
    
//  output reg  [DATA_SIZE_vc1-1:0]         data_count,           //numero de datos
    output [DATA_SIZE_vc1-1:0]          data_mux_1,            //datos para hacerle pop
    output reg                          fifo_error_vc1,
    output reg                          fifo_pause_vc1
);
  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire [DATA_SIZE_vc1-1:0] data_out;		// From mem0 of RAM_memory.v
  // End of automatics
    reg fifo_full_vc1;  
    reg almost_full_vc1, almost_empty_vc1;
    reg [DATA_SIZE_vc1-1:0]data_count_vc1;  
  
  /*AUTOREGINPUT*/  
    // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
    
    
    // wire [DATA_SIZE_vc1-1:0] data_vc1;		// To mem0 of RAM_memory.v
    reg [MAIN_QUEUE_SIZE_vc1-1:0]	rd_ptr_vc1;			// To mem0 of RAM_memory.v
    reg [MAIN_QUEUE_SIZE_vc1-1:0]	wr_ptr_vc1;			// To mem0 of RAM_memory.v
    reg datamod_vc1;
    
    // End of automatics

    reg [DATA_SIZE_vc1-1:0] data_to_mem_vc1;
   
    RAM_memory_vc1 #(DATA_SIZE_vc1,MAIN_QUEUE_SIZE_vc1) mem_vc1(/*AUTOINST*/
		    // Outputs
		    .data_out		(data_mux_1[DATA_SIZE_vc1-1:0]),
		    // Inputs
		    .clk		(clk),
		    .read_vc1		(pop_vc1),
		    .write_vc1		(push_vc1),
		    .reset_L		(reset_L),
		    .data_in		(data_vc1),
		    .wr_ptr_vc1		(wr_ptr_vc1[MAIN_QUEUE_SIZE_vc1-1:0]),
		    .rd_ptr_vc1		(rd_ptr_vc1[MAIN_QUEUE_SIZE_vc1-1:0]));


    always@(*) begin
        fifo_empty_vc1 = 0;
        fifo_full_vc1 = 0;
        almost_full_vc1 = 0;
        almost_empty_vc1 = 0;
        datamod_vc1 = 0;
        fifo_error_vc1 = 0;
        fifo_pause_vc1=0;
        if ( ~reset_L ) begin
            fifo_empty_vc1 = 1;
            fifo_full_vc1 = 0;
            almost_full_vc1 = 0;
            almost_empty_vc1 = 0;
            fifo_pause_vc1=0;
            fifo_error_vc1=0;
        end 
        
        //control de estados del fifo
 
        
        else begin
            if ( data_count_vc1 == 0 )begin
                fifo_empty_vc1 = 1;
                fifo_pause_vc1=0;
            end

            if( data_count_vc1 ==( (2**MAIN_QUEUE_SIZE_vc1)) )begin            //Es decir 2**(DATA_SIZE_vc1-1)
                fifo_full_vc1 = 1;
                // fifo_pause_vc1=1;
            end

            if( data_count_vc1 >= afVC_o )begin
                almost_full_vc1 = 1;
                fifo_pause_vc1=1;
            end

            if( (data_count_vc1 <= aeVC_o)&&(data_count_vc1!=0) )begin
                almost_empty_vc1 = 1;
                fifo_pause_vc1=0;
            end
            
            if( push_vc1 && fifo_full_vc1 )begin
                fifo_error_vc1 = 1;
            end

            if( pop_vc1 && fifo_empty_vc1 )begin
                fifo_error_vc1 = 1;
            end
        end

    end

    
    always@( posedge clk)begin
        if ( !reset_L ) begin
            data_count_vc1 <= 'b0;
            // data_mux_1 <= 'b0;
            wr_ptr_vc1          <= 'b0;
            rd_ptr_vc1          <= 'b0;
            datamod_vc1         <= 'b0;
            // fifo_pause_vc1     <= 'b0;
        end else begin
            

            if( !fifo_full_vc1 && push_vc1 )begin
                wr_ptr_vc1 <= wr_ptr_vc1 + 1;                   //wr_ptr incrementa
                
                if ( !fifo_empty_vc1 && pop_vc1 )begin
                    rd_ptr_vc1 <= rd_ptr_vc1 + 1;               //rd_ptr incrementa
                    data_count_vc1 <= data_count_vc1;
                end else begin
                    rd_ptr_vc1 <= rd_ptr_vc1;
                    data_count_vc1 <= data_count_vc1 + 1;
                end
            end else if( !fifo_empty_vc1 && pop_vc1 ) begin
                rd_ptr_vc1 <= rd_ptr_vc1 + 1;                   //rd_ptr incrementa
                wr_ptr_vc1 <= wr_ptr_vc1;                       //wr_ptr es el mismo
                data_count_vc1  <= data_count_vc1 - 1;
                // data_mux_1    <= data_out; 
            end else begin
                rd_ptr_vc1 <= rd_ptr_vc1;                       //rd_ptr incrementa
                wr_ptr_vc1 <= wr_ptr_vc1;                       //wr_ptr es el mismo
                
                data_count_vc1  <= data_count_vc1;
            end
        end
    end

endmodule
