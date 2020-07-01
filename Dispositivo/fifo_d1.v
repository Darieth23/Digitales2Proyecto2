`timescale 1ns/1ps
`include "RAM_memory_d1.v"


module fifo_d1#(
    //Parametros
    parameter DATA_SIZE = 8, //Antes estaba en  6               //cantidad de bits de entrada
    parameter MAIN_QUEUE_SIZE = 6 //Antes estaba en  2        //Cantidad de filas del d1 fifo    
)(
    input                               clk,
    input                               reset_L,
    input                               pop_d1,
    input                               push_d1,
    input       [DATA_SIZE-1:0]         data_d1,            //datos para hacerle push
    input       [1:0]         afD_o,               //umbral almost full d1 buffer
    input       [1:0]         aeD_o,               // umbral almost empty d1 buffer
    
    //Estados del FIFO
    //output reg                          fifo_full,
    output reg                          fifo_empty_d1_cond, 
    
//  output reg  [DATA_SIZE-1:0]         data_count,           //numero de datos
    output reg [DATA_SIZE-1:0]          data_out_1_cond,            //datos para hacerle pop
    output reg                          fifo_error_d1,
    output reg                          fifo_pause_d1
);
  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire [DATA_SIZE-1:0] data_out;		// From mem0 of RAM_memory.v
  // End of automatics
    reg fifo_full;  
    reg almost_full, almost_empty;
    reg [DATA_SIZE-1:0]data_count;  
  
  /*AUTOREGINPUT*/  
    // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
    
    
    // wire [DATA_SIZE-1:0] data_d1;		// To mem0 of RAM_memory.v
    reg [MAIN_QUEUE_SIZE-1:0]	rd_ptr;			// To mem0 of RAM_memory.v
    reg [MAIN_QUEUE_SIZE-1:0]	wr_ptr;			// To mem0 of RAM_memory.v
    reg datamod;
    
    // End of automatics

    reg [DATA_SIZE-1:0] data_to_mem;
   
    RAM_memory_d1 #(DATA_SIZE,MAIN_QUEUE_SIZE) mem_d1(/*AUTOINST*/
		    // Outputs
		    .data_out		(data_out[DATA_SIZE-1:0]),
		    // Inputs
		    .clk		(clk),
		    .read		(pop_d1),
		    .write		(push_d1),
		    .reset_L		(reset_L),
		    .data_in		(data_d1),
		    .wr_ptr		(wr_ptr[MAIN_QUEUE_SIZE-1:0]),
		    .rd_ptr		(rd_ptr[MAIN_QUEUE_SIZE-1:0]));


    always@(*) begin
        fifo_empty_d1_cond = 0;
        fifo_full = 0;
        almost_full = 0;
        almost_empty = 0;
        datamod = 0;
        fifo_error_d1 = 0;
        fifo_pause_d1=0;
        if ( ~reset_L ) begin
            fifo_empty_d1_cond = 1;
            fifo_full = 0;
            almost_full = 0;
            almost_empty = 0;
            fifo_pause_d1=0;
            fifo_error_d1=0;
        end 
        
        //control de estados del fifo
 
        
        else begin
            if ( data_count == 0 )begin
                fifo_empty_d1_cond = 1;
                fifo_pause_d1=0;
            end

            if( data_count ==( (2**MAIN_QUEUE_SIZE)) )begin            //Es decir 2**(DATA_SIZE-1)
                fifo_full = 1;
                // fifo_pause_d1=1;
            end

            if( data_count >= afD_o)begin
                almost_full = 1;
                fifo_pause_d1=1;
            end

            if( (data_count <= aeD_o)&&(data_count!=0) )begin
                almost_empty = 1;
                fifo_pause_d1=0;
            end
            
            if( push_d1 && fifo_full )begin
                fifo_error_d1 = 1;
            end

            if( pop_d1 && fifo_empty_d1_cond )begin
                fifo_error_d1 = 1;
            end
        end

    end

    
    always@( posedge clk)begin
        if ( !reset_L ) begin
            data_count <= 'b0;
            data_out_1_cond <= 'b0;
            wr_ptr          <= 'b0;
            rd_ptr          <= 'b0;
            datamod         <= 'b0;
            // fifo_pause_d1     <= 'b0;
        end else begin
            if(pop_d1 && push_d1) begin
              	data_out_1_cond <= data_out;
              	rd_ptr <= rd_ptr + 1;                   //rd_ptr incrementa
              	wr_ptr <= wr_ptr + 1;                   //wr_ptr incrementa

            end 
            if( !fifo_full && push_d1 )begin
                wr_ptr <= wr_ptr + 1;                   //wr_ptr incrementa
                
                if ( !fifo_empty_d1_cond && pop_d1 )begin
                    rd_ptr <= rd_ptr + 1;               //rd_ptr incrementa
                    data_count <= data_count;
                end else begin
                    rd_ptr <= rd_ptr;
                    data_count <= data_count + 1;
                end
            end else if( !fifo_empty_d1_cond && pop_d1 ) begin
                rd_ptr <= rd_ptr + 1;                   //rd_ptr incrementa
                wr_ptr <= wr_ptr;                       //wr_ptr es el mismo
                data_count  <= data_count - 1;
                data_out_1_cond    <= data_out;
            end else begin
                rd_ptr <= rd_ptr;                       //rd_ptr incrementa
                wr_ptr <= wr_ptr;                       //wr_ptr es el mismo
                
                data_count  <= data_count;
            end
        end
    end

endmodule
