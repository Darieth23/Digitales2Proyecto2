`timescale 	1ns	/ 100ps
//`include "Demux1a2_class.v"
`include "probador_class.v" 
`include "clasificacion.v" 
//`include "cmos_cells.v" 
//`include "Demux1a2_classEst.v" 
module BancoPruebas;

parameter DATA_SIZE = 10;
    wire clk;
    wire [9:0] data_mux_0, data_mux_1;

    wire [DATA_SIZE-1:0] datain_class;		// From probador of probador.v
    wire [DATA_SIZE-1:0] buffer_out_cond;	// From cond of fifo.v
    wire		fifo_empty_cond;	// From cond of fifo.v
    wire		fifo_error_cond;	// From cond of fifo.v
    wire		fifo_pause_cond;	// From cond of fifo.v
    wire		pop_vc0;			// From probador of probador.v
    wire		pop_vc1;			// From probador of probador.v
    wire		reset_L;		// From probador of probador.v
    wire [DATA_SIZE-1:0] aeVC_o;	// From probador of probador.v
    wire [DATA_SIZE-1:0] afVC_o;	// From probador of probador.v
    wire		push_vc0;		// From probador of probador.v
    wire		push_vc1;		// From probador of probador.v
    



   clasificacion instDemux(/*AUTOINST*/
			   // Outputs
			   .data_mux_0		(data_mux_0[DATA_SIZE-1:0]),
			   .data_mux_1		(data_mux_1[DATA_SIZE-1:0]),
			   // Inputs
			   .clk			(clk),
			   .reset_L		(reset_L),
			   .datain_class	(datain_class[9:0]),
			   .afVC_o		(afVC_o[DATA_SIZE-1:0]),
			   .aeVC_o		(aeVC_o[DATA_SIZE-1:0]),
			   .push_vc0		(push_vc0),
			   .push_vc1		(push_vc1),
			   .pop_vc0		(pop_vc0),
			   .pop_vc1		(pop_vc1)
);


  probadorclass instprobador(/*AUTOINST*/
			      // Inputs
			      .clk		(clk),
			      .reset_L		(reset_L),

			      .datain_class	(datain_class[DATA_SIZE-1:0]),
			   .afVC_o		(afVC_o[DATA_SIZE-1:0]),
			   .aeVC_o		(aeVC_o[DATA_SIZE-1:0]),
			   .push_vc0		(push_vc0),
			   .pop_vc0		(pop_vc0),
			   .push_vc1		(push_vc1),
			   .pop_vc1		(pop_vc1),
			      // Outputs
			      .data_mux_0	(data_mux_0[9:0]),
			      .data_mux_1	(data_mux_1[9:0]),
			      .fifo_empty_vc0	(fifo_empty_vc0),
			      .fifo_empty_vc1	(fifo_empty_vc1),
			      .fifo_error_vc0	(fifo_error_vc0),
			      .fifo_pause_vc0	(fifo_pause_vc0),
			      .fifo_error_vc1	(fifo_error_vc1),
			      .fifo_pause_vc1	(fifo_pause_vc1)
);



endmodule


