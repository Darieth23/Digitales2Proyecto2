//`include "RAM_memory.v"
`include "Mux2a1_dest.v"
`include "output_flow.v"
`include "output_flow_2.v"
`include "demux_d.v"
`include "Demux1a2_classV2.v"
`include "fifo_vc0.v"
`include "fifo_vc1.v"
`include "fifo_d0.v"
`include "fifo_d1.v"
`include "fifo_e0.v"
`include "fifo_e1.v"
`include "paraser_0.v"
`include "paraser_1.v"
`include "serialtopar0.v"
`include "serialtopar1.v"

//`include "clks.v"

module clasificacion#(parameter DATA_SIZE=10)(

input clk,
input clk_8f,
input reset_L,
input dest,
input class,
input [7:0] datain_class,
output [7:0] data_out_final0,	// From sertopar0
output [7:0] data_out_final1,

	input [DATA_SIZE-1:0] 	afVC_o,
	input [DATA_SIZE-1:0] 	aeVC_o,	

	input [DATA_SIZE-1:0] 	afD_o,
	input [DATA_SIZE-1:0] 	aeD_o,	
	input [DATA_SIZE-1:0] 	afE_o,
	input [DATA_SIZE-1:0] 	aeE_o,
	input 		push_vc0,
	input 		push_vc1,
	//input 		push_d0,
	input 		pop_e0,
	//input 		push_d1,
	input 		pop_e1
);
	
	wire [9:0] 	outclass0;
	wire [9:0] 	outclass1;
	wire		fifo_empty_vc0;		// From vc0 of fifo_vc0.v
	wire		fifo_empty_vc1;		// From vc1 of fifo_vc1.v
	wire		fifo_error_vc0;		// From vc0 of fifo_vc0.v
	wire		fifo_error_vc1;		// From vc1 of fifo_vc1.v
	wire		fifo_pause_vc0;		// From vc0 of fifo_vc0.v
	wire		fifo_pause_vc1;		// From vc1 of fifo_vc1.v

	wire		fifo_empty_d0_cond;		// From fifo_d0.v
	wire		fifo_empty_d1_cond;		// From fifo_d1.v
	wire		fifo_error_d0;		// From vc0 of fifo_vd0.v
	wire		fifo_error_d1;		// From vc1 of fifo_vd1.v
	wire		fifo_pause_d0;		// From vc0 of fifo_vd0.v
	wire		fifo_pause_d1;		// From vc1 of fifo_vd1.v
	wire [DATA_SIZE-1:0] data_mux_0;	// From vc1 of fifo_vd0.v
	wire [DATA_SIZE-1:0] data_mux_1;	// From vc1 of fifo_vc1.v

	wire [DATA_SIZE-1:0] data_d0;
	wire [DATA_SIZE-1:0] data_d1;

	wire  validoutdest;
	wire  [9:0] dataout_dest;

	wire   pop_vc0;
	wire   pop_vc1;
	wire   pop0;
	wire   pop1;
	wire push_d0;
	wire push_d1;

	wire [7:0] dataout_0_FIFO2;
	wire [7:0] dataout_1_FIFO2;
	wire dataout_0;
	wire dataout_1;
	wire pop_d0;
	wire pop_d1;
	wire [7:0] data_outser0;	// From sertopar0
	wire [7:0] data_outser1;	// From sertopar1
	wire valid_outser0;		// From sertopar0
	wire valid_outser1;		// From sertopar1



   demux1a2class_cond instDemux(/*AUTOINST*/
				// Outputs
				.outclass0	(outclass0[9:0]),
				.outclass1	(outclass1[9:0]),
				// Inputs
				.datain_class	(datain_class[7:0]),
				.reset_L	(reset_L),
				.clk		(clk),
				.dest		(dest),
				.class		(class));

   fifo_vc0 instFifo0(/*AUTOINST*/
		      // Outputs
		      .fifo_empty_vc0	(fifo_empty_vc0),
		      .data_mux_0	(data_mux_0[DATA_SIZE-1:0]),
		      .fifo_error_vc0	(fifo_error_vc0),
		      .fifo_pause_vc0	(fifo_pause_vc0),
		      // Inputs
		      .clk		(clk),
		      .reset_L		(reset_L),
		      .pop_vc0		(pop_vc0),
		      .push_vc0		(push_vc0),
		      .data_vc0		(outclass0[9:0]),
		      .afVC_o		(afVC_o[3:0]),
		      .aeVC_o		(aeVC_o[3:0]));

   fifo_vc1 instFifo1(/*AUTOINST*/
		      // Outputs
		      .fifo_empty_vc1	(fifo_empty_vc1),
		      .data_mux_1	(data_mux_1[DATA_SIZE-1:0]),
		      .fifo_error_vc1	(fifo_error_vc1),
		      .fifo_pause_vc1	(fifo_pause_vc1),
		      // Inputs
		      .clk		(clk),
		      .reset_L		(reset_L),
		      .pop_vc1		(pop_vc1),
		      .push_vc1		(push_vc1),
		      .data_vc1		(outclass1[9:0]),
		      .afVC_o		(afVC_o[3:0]),
		      .aeVC_o		(aeVC_o[3:0]));

    output_flow of(/*autoinst*/
		   // Outputs
		   .pop_vc0		(pop_vc0),
		   .pop_vc1		(pop_vc1),
		   .pop_delay_vc0	(pop_delay_vc0),
		   .pop_delay_vc1	(pop_delay_vc1),
		   // Inputs
		   .fifo_empty_vc0	(fifo_empty_vc0),
		   .fifo_empty_vc1	(fifo_empty_vc1),
		   .fifo_pause_d0	(fifo_pause_d0),
		   .fifo_pause_d1	(fifo_pause_d1));


   mux2a1dest_cond instMux(/*AUTOINST*/
			   // Outputs
			   .validoutdest	(validoutdest),
			   .dataout_dest	(dataout_dest[9:0]),
			   // Inputs
			   .pop0		(pop_delay_vc0),
			   .pop1		(pop_delay_vc1),
			   .datain_dest0	(data_mux_0[DATA_SIZE-1:0]),
			   .datain_dest1	(data_mux_1[DATA_SIZE-1:0]),
			   .reset_L		(reset_L));

    demux_d demux_d(/*autoinst*/
		    // Outputs
		    .push_d0		(push_d0),
		    .push_d1		(push_d1),
		    .data_d0		(data_d0[DATA_SIZE-1:0]),
		    .data_d1		(data_d1[DATA_SIZE-1:0]),
		    // Inputs
		    .clk		(clk),
		    .data_demux	(dataout_dest[9:0]),
		    .dest		(dest),
		    .valid_demux	(validoutdest));

    fifo_d0 d0(/*autoinst*/
	       // Outputs
	       .fifo_empty_d0_cond	(fifo_empty_d0_cond),
	       .data_out_0_cond		(dataout_0_FIFO2[7:0]),
	       .fifo_error_d0		(fifo_error_d0),
	       .fifo_pause_d0		(fifo_pause_d0),
	       // Inputs
	       .clk			(clk),
	       .reset_L			(reset_L),
	       .pop_d0			(pop_d0),
	       .push_d0			(push_d0),
	       .data_d0			(data_d0[7:0]),
	       .afD_o			(afD_o[1:0]),
	       .aeD_o			(aeD_o[1:0]));

    fifo_d1 d1(/*autoinst*/
	       // Outputs
	       .fifo_empty_d1_cond	(fifo_empty_d1_cond),
	       .data_out_1_cond		(dataout_1_FIFO2[7:0]),
	       .fifo_error_d1		(fifo_error_d1),
	       .fifo_pause_d1		(fifo_pause_d1),
	       // Inputs
	       .clk			(clk),
	       .reset_L			(reset_L),
	       .pop_d1			(pop_d1),
	       .push_d1			(push_d1),
	       .data_d1			(data_d1[7:0]),
	       .afD_o			(afD_o[1:0]),
	       .aeD_o			(aeD_o[1:0]));

	partoserial0 par0(/*AUTOINST*/
			// Outputs
			.data_out_P2S_0 (dataout_0),
			// Inputs
			.data_in_0 (dataout_0_FIFO2[7:0]),
			.clk_8f (clk_8f),
			.reset_L (reset_L),
			.valid_in_0 (pop_d0)
	);

	partoserial1 par1(/*AUTOINST*/
			// Outputs
			.data_out_P2S (dataout_1),
			// Inputs
			.data_in (dataout_1_FIFO2[7:0]),
			.clk_8f (clk_8f),
			.reset_L (reset_L),
			.valid_in (pop_d1)
	);

  	serialtopar0 instSP0(/*AUTOINST*/
			    // Outputs
			    .data_outser0	(data_outser0[7:0]),
			    .valid_outser0	(valid_outser0),
			    // Inputs
			    .clk		(clk),
			    .clk_8f		(clk_8f),
			    .reset_L		(reset_L),
			    .data_inser0	(dataout_0));

   	serialtopar instSP1(/*AUTOINST*/
		       // Outputs
		       .data_outser1	(data_outser1[7:0]),
		       .valid_outser1	(valid_outser1),
		       // Inputs
		       .clk		(clk),
		       .clk_8f		(clk_8f),
		       .reset_L		(reset_L),
		       .data_in		(dataout_1));


    fifo_e0 e0(/*autoinst*/
	       // Outputs
	       .fifo_empty_e0_cond	(fifo_empty_e0_cond),
	       .data_out_e0_cond	(data_out_final0[7:0]),
	       .fifo_error_e0		(fifo_error_e0),
	       .fifo_pause_e0		(fifo_pause_e0),
	       // Inputs
	       .clk			(clk),
	       .reset_L			(reset_L),
	       .pop_e0			(pop_e0),
	       .push_e0			(valid_outser0),
	       .data_e0			(data_outser0[7:0]),
	       .afE_o			(afE_o[1:0]),
	       .aeE_o			(aeE_o[1:0]));

    fifo_e1 e1(/*autoinst*/
	       // Outputs
	       .fifo_empty_e1_cond	(fifo_empty_e1_cond),
	       .data_out_e1_cond	(data_out_final1[7:0]),
	       .fifo_error_e1		(fifo_error_e1),
	       .fifo_pause_e1		(fifo_pause_e1),
	       // Inputs
	       .clk			(clk),
	       .reset_L			(reset_L),
	       .pop_e1			(pop_e1),
	       .push_e1			(valid_outser1),
	       .data_e1			(data_outser1[7:0]),
	       .afE_o			(afE_o[1:0]),
	       .aeE_o			(aeE_o[1:0]));

    output_flow_2 of2(/*autoinst*/
		   // Outputs
		   .pop_d0		(pop_d0),
		   .pop_d1		(pop_d1),
		   // Inputs
		   .fifo_empty_e0	(fifo_empty_d0_cond),
		   .fifo_empty_e1	(fifo_empty_d1_cond),
		   .fifo_pause_e0	(fifo_pause_e0),
		   .fifo_pause_e1	(fifo_pause_e1));


endmodule