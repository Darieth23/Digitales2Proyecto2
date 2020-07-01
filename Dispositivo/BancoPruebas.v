`timescale 	1ns	/ 100ps
`include "probador_class2.v" 
`include "clasificacion.v" 
`include "cmos_cells.v" 
`include "clasificacionEst.v" 
module BancoPruebas;

parameter DATA_SIZE = 10;
    wire clk;
	wire clk_8f;

    wire [7:0] datain_class;		// From probador of probador.v
    wire		pop_vc0;			// From probador of probador.v
    wire		pop_vc1;			// From probador of probador.v
    wire		reset_L;		// From probador of probador.v
    wire [DATA_SIZE-1:0] aeVC_o;	// From probador of probador.v
    wire [DATA_SIZE-1:0] afVC_o;	// From probador of probador.v
    wire [DATA_SIZE-1:0] afD_o;		// From probador of probador.v
    wire [DATA_SIZE-1:0] aeD_o;		// From probador of probador.v
    wire [DATA_SIZE-1:0] afE_o;		// From probador of probador.v
    wire [DATA_SIZE-1:0] aeE_o;		// From probador of probador.v
   //wire		push_d0;		// From probador of probador.v
	//wire		push_d1;		// From probador of probador.v
    wire 		pop_e0;
    wire 		pop_e1;
    
	wire [7:0] data_out_final0;
	wire [7:0] data_out_final1;
	wire [7:0] data_out_final0Est,data_out_final1Est;

clasificacion autoinstClasi(/*AUTOINST*/
			    // Outputs
			    .data_out_final0	(data_out_final0[7:0]),
			    .data_out_final1	(data_out_final1[7:0]),
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
			    .afE_o		(afE_o[DATA_SIZE-1:0]),
			    .aeE_o		(aeE_o[DATA_SIZE-1:0]),
			    .push_vc0		(push_vc0),
			    .push_vc1		(push_vc1),
			    //.push_d0		(push_d0),
			    .pop_e0		(pop_e0),
			    //.push_d1		(push_d1),
			    .pop_e1		(pop_e1));


clasificacionEst autoinstClasiEst(/*AUTOINST*/
			    // Outputs
			    .data_out_final0	(data_out_final0Est[7:0]),
			    .data_out_final1	(data_out_final1Est[7:0]),
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
			    .afE_o		(afE_o[DATA_SIZE-1:0]),
			    .aeE_o		(aeE_o[DATA_SIZE-1:0]),
			    .push_vc0		(push_vc0),
			    .push_vc1		(push_vc1),
			    //.push_d0		(push_d0),
			    .pop_e0		(pop_e0),
			    //.push_d1		(push_d1),
			    .pop_e1		(pop_e1));
  probadorclass2 instprobador(/*AUTOINST*/
			    // Outputs
			    .data_out_final0	(data_out_final0[7:0]),
			    .data_out_final1	(data_out_final1[7:0]),
			    .data_out_final0Est	(data_out_final0Est[7:0]),
			    .data_out_final1Est	(data_out_final1Est[7:0]),
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
			    .afE_o		(afE_o[DATA_SIZE-1:0]),
			    .aeE_o		(aeE_o[DATA_SIZE-1:0]),
			    .push_vc0		(push_vc0),
			    .push_vc1		(push_vc1),
			    //.push_d0		(push_d0),
			    .pop_e0		(pop_e0),
			    //.push_d1		(push_d1),
			    .pop_e1		(pop_e1));



endmodule


