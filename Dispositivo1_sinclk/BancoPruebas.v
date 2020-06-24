`timescale 	1ns	/ 100ps
//`include "Demux1a2_class.v"
`include "probador_class.v" 
`include "clasificacion.v" 
`include "cmos_cells.v" 
`include "clasificacionEst.v" 
module BancoPruebas;

parameter DATA_SIZE = 10;
    wire clk;
	wire clk_8f;

    wire [7:0] datain_class;		// From probador of probador.v
    wire [DATA_SIZE-1:0] buffer_out_cond;	// From cond of fifo.v
    wire		fifo_empty_cond;	// From cond of fifo.v
    wire		fifo_error_cond;	// From cond of fifo.v
    wire		fifo_pause_cond;	// From cond of fifo.v
    wire		pop_vc0;			// From probador of probador.v
    wire		pop_vc1;			// From probador of probador.v
    wire		reset_L;		// From probador of probador.v
    wire [DATA_SIZE-1:0] aeVC_o;	// From probador of probador.v
    wire [DATA_SIZE-1:0] afVC_o;	// From probador of probador.v
    wire [DATA_SIZE-1:0] afD_o;		// From probador of probador.v
    wire [DATA_SIZE-1:0] aeD_o;		// From probador of probador.v
   //wire		push_d0;		// From probador of probador.v
	//wire		push_d1;		// From probador of probador.v
    wire 		pop_d0;
    wire 		pop_d1;
    
	wire dataout_0;
	wire dataout_1;
	wire dataout_1Est,dataout_0Est;

clasificacion autoinstClasi(/*AUTOINST*/
			    // Outputs
			    .dataout_0	(dataout_0),
			    .dataout_1	(dataout_1),
			    // Inputs
			    .clk		(clk),
				.clk_8f		(clk_8f),
			    .reset_L		(reset_L),
			    .dest		(dest),
			    .class		(class),
			    .datain_class	(datain_class[7:0]),
			    .afVC_o		(afVC_o[DATA_SIZE-1:0]),
			    .aeVC_o		(aeVC_o[DATA_SIZE-1:0]),
			    .afD_o		(afD_o[DATA_SIZE-1:0]),
			    .aeD_o		(aeD_o[DATA_SIZE-1:0]),
			    .push_vc0		(push_vc0),
			    .push_vc1		(push_vc1),
			    //.push_d0		(push_d0),
			    .pop_d0		(pop_d0),
			    //.push_d1		(push_d1),
			    .pop_d1		(pop_d1));


clasificacionEst autoinstClasiEst(/*AUTOINST*/
			    // Outputs
			    .dataout_0	(dataout_0Est),
			    .dataout_1	(dataout_1Est),
			    // Inputs
			    .clk		(clk),
				.clk_8f		(clk_8f),
			    .reset_L		(reset_L),
			    .dest		(dest),
			    .class		(class),
			    .datain_class	(datain_class[7:0]),
			    .afVC_o		(afVC_o[DATA_SIZE-1:0]),
			    .aeVC_o		(aeVC_o[DATA_SIZE-1:0]),
			    .afD_o		(afD_o[DATA_SIZE-1:0]),
			    .aeD_o		(aeD_o[DATA_SIZE-1:0]),
			    .push_vc0		(push_vc0),
			    .push_vc1		(push_vc1),
			    //.push_d0		(push_d0),
			    .pop_d0		(pop_d0),
			    //.push_d1		(push_d1),
			    .pop_d1		(pop_d1));


  probadorclass instprobador(/*AUTOINST*/
			    // Outputs
			    .dataout_0	( dataout_0),
			    .dataout_1	( dataout_1),
				.dataout_0Est	( dataout_0Est),
			    .dataout_1Est	( dataout_1Est),
			    // Inputs
			    .clk		(clk),
				.clk_8f		(clk_8f),
			    .reset_L		(reset_L),
			    .dest		(dest),
			    .class		(class),
			    .datain_class	(datain_class[7:0]),
			    .afVC_o		(afVC_o[DATA_SIZE-1:0]),
			    .aeVC_o		(aeVC_o[DATA_SIZE-1:0]),
			    .afD_o		(afD_o[DATA_SIZE-1:0]),
			    .aeD_o		(aeD_o[DATA_SIZE-1:0]),
			    .push_vc0		(push_vc0),
			    .push_vc1		(push_vc1),
			    //.push_d0		(push_d0),
			    .pop_d0		(pop_d0),
			    //.push_d1		(push_d1),
			    .pop_d1		(pop_d1));



endmodule


