`timescale 	1ns	/ 100ps
`include "Mux2a1_dest.v"
`include "probadormux_dest.v" 
`include "cmos_cells.v" 
`include "Mux2a1_destEst.v" 

module BancoPruebas;
    wire pop0, pop1, validoutdest, reset_L, clk, validoutdestEst;
    wire [9:0] datain_dest0, datain_dest1, dataout_dest, dataout_destEst;
    probadordest proba(
                    //salidas
                    .pop0 (pop0),
                    .pop1 (pop1),
                    .datain_dest0 (datain_dest0[9:0]),
                    .datain_dest1 (datain_dest1[9:0]),
                    .reset_L (reset_L),
                    .clk (clk),
                    //entradas
                    .validoutdest (validoutdest),
                    .dataout_dest (dataout_dest),
                    .validoutdestEst (validoutdestEst),
                    .dataout_destEst (dataout_destEst)
    );
    mux2a1dest_cond muxdest(
                    //salidas
                    .validoutdest (validoutdest),
                    .dataout_dest (dataout_dest[9:0]),
                    //entradas
                    .pop0 (pop0),
                    .pop1 (pop1),
                    .datain_dest0 (datain_dest0[9:0]),
                    .datain_dest1 (datain_dest1[9:0]),
                    .reset_L (reset_L)
    );
    mux2a1dest_est muxestEst(
                    //salidas
                    .validoutdest (validoutdestEst),
                    .dataout_dest (dataout_destEst[9:0]),
                    //entradas
                    .pop0 (pop0),
                    .pop1 (pop1),
                    .datain_dest0 (datain_dest0[9:0]),
                    .datain_dest1 (datain_dest1[9:0]),
                    .reset_L (reset_L)
    );
    
endmodule
