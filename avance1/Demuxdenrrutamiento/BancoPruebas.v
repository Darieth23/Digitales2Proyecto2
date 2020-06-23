`timescale 	1ns	/ 100ps
`include "Demux1a2_dest.v"
`include "probador_dest.v" 
`include "cmos_cells.v" 
`include "Demux1a2_destEst.v" 
module BancoPruebas;
    wire clk, reset_L, class, dest;
    wire [7:0] datain_dest, outdest0, outdest1, outdest0Est, outdest1Est;
    probadordest probador(
                    //salidas
                    .clk (clk),
                    .reset_L (reset_L),
                    .datain_dest (datain_dest[7:0]),
                    .class (class),
                    .dest (dest),
                    //entradas
                    .outdest0 (outdest0[7:0]),
                    .outdest1 (outdest1[7:0]),
                    .outdest0Est (outdest0Est[7:0]),
                    .outdest1Est (outdest1Est[7:0])
    );

    demux1a2dest_cond demuxdest(
                    //entradas
                    .clk (clk),
                    .reset_L (reset_L),
                    .datain_dest (datain_dest[7:0]),
                    .class (class),
                    .dest (dest),
                    //salidas
                    .outdest0 (outdest0[7:0]),
                    .outdest1 (outdest1[7:0])
    );

    demux1a2dest_est demuxdestestr(                    
                    //entradas
                    .clk (clk),
                    .reset_L (reset_L),
                    .datain_dest (datain_dest[7:0]),
                    .class(class),
                    .dest (dest),
                    //salidas
                    .outdest0 (outdest0Est[7:0]),
                    .outdest1 (outdest1Est[7:0])
    );
endmodule


