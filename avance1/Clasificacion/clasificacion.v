`include "RAM_memory.v"
`include "Demux1a2_class.v"
`include "fifo_vc0.v"
`include "fifo_vc1.v"

module clasificacion#(parameter DATA_SIZE=10)(

input clk,
input reset_L,
input [9:0] datain_class,
output [DATA_SIZE-1:0] data_mux_0,	// From vc0 of fifo_vc0.v
output [DATA_SIZE-1:0] data_mux_1,	// From vc1 of fifo_vc1.v
	input [DATA_SIZE-1:0] 	afVC_o,
	input [DATA_SIZE-1:0] 	aeVC_o,	
	input 		push_vc0,
	input 		pop_vc0,
	input 		push_vc1,
	input 		pop_vc1
);
	
	wire [9:0] 	outclass0;
	wire [9:0] 	outclass1;
	wire		fifo_empty_vc0;		// From vc0 of fifo_vc0.v
	wire		fifo_empty_vc1;		// From vc1 of fifo_vc1.v
	wire		fifo_error_vc0;		// From vc0 of fifo_vc0.v
	wire		fifo_error_vc1;		// From vc1 of fifo_vc1.v
	wire		fifo_pause_vc0;		// From vc0 of fifo_vc0.v
	wire		fifo_pause_vc1;		// From vc1 of fifo_vc1.v



   demux1a2class_cond instDemux(/*AUTOINST*/
				// Outputs
				.outclass0	(outclass0[9:0]),
				.outclass1	(outclass1[9:0]),
				// Inputs
				.datain_class	(datain_class[9:0]),
				.reset_L	(reset_L),
				.clk		(clk));

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

endmodule
