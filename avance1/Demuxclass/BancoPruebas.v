`timescale 	1ns	/ 100ps
`include "Demux1a2_class.v"
`include "probador_class.v" 
`include "cmos_cells.v" 
`include "Demux1a2_classEst.v" 
module BancoPruebas;
    wire clk, reset_L, class, dest;
    wire [9:0] outclass0, outclass1, outclass0Est, outclass1Est;
    wire [7:0] datain_class;
    probadorclass probador(
                    //salidas
                    .clk (clk),
                    .reset_L (reset_L),
                    .datain_class (datain_class[7:0]),
                    .class (class),
                    .dest (dest),
                    //entradas
                    .outclass0 (outclass0[9:0]),
                    .outclass1 (outclass1[9:0]),
                    .outclass0Est (outclass0Est[9:0]),
                    .outclass1Est (outclass1Est[9:0])
    );

    demux1a2class_cond demuxclass(
                    //entradas
                    .clk (clk),
                    .reset_L (reset_L),
                    .datain_class (datain_class[7:0]),
                    .class (class),
                    .dest (dest),
                    //salidas
                    .outclass0 (outclass0[9:0]),
                    .outclass1 (outclass1[9:0])
    );

    demux1a2class_est demuxclassestr(                    
                    //entradas
                    .clk (clk),
                    .reset_L (reset_L),
                    .datain_class (datain_class[7:0]),
                    .class (class),
                    .dest (dest),
                    //salidas
                    .outclass0 (outclass0Est[9:0]),
                    .outclass1 (outclass1Est[9:0])
    );
endmodule


