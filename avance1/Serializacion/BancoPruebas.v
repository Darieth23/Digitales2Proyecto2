`timescale 	1ns	/ 100ps
`include "serializacion.v"
`include "Probador.v" 
`include "cmos_cells.v" 
`include "serializacionEst.v" 
module BancoPruebas;
    wire valid_in1, valid_in0, clk, clk_8f, reset_L, data_out_P2S0, data_out_P2S1, data_out_P2S0Est, data_out_P2S1Est;
    wire [7:0] data_in0, data_in1;
    probador proba(
                    //salidas
                    .data_in0 (data_in0[7:0]),
                    .data_in1 (data_in1[7:0]),
                    .valid_in0 (valid_in0),
                    .valid_in1 (valid_in1),
                    .clk (clk),
                    .clk_8f (clk_8f),
                    .reset_L (reset_L),
                    //entradas
                    .data_out_P2S0 (data_out_P2S0),
                    .data_out_P2S1 (data_out_P2S1),
                    .data_out_P2S0Est (data_out_P2S0Est),
                    .data_out_P2S1Est (data_out_P2S1Est)
    );
    serializacion ser(
                    //entradas
                    .data_in0 (data_in0[7:0]),
                    .data_in1 (data_in1[7:0]),
                    .valid_in0 (valid_in0),
                    .valid_in1 (valid_in1),
                    //.clk (clk),
                    .clk_8f (clk_8f),
                    .reset_L (reset_L),
                    //salidas
                    .data_out_P2S0 (data_out_P2S0),
                    .data_out_P2S1 (data_out_P2S1)
    );
    serializacionEst serEst(
                    //entradas
                    .data_in0 (data_in0[7:0]),
                    .data_in1 (data_in1[7:0]),
                    .valid_in0 (valid_in0),
                    .valid_in1 (valid_in1),
                    //.clk (clk),
                    .clk_8f (clk_8f),
                    .reset_L (reset_L),
                    //salidas
                    .data_out_P2S0 (data_out_P2S0Est),
                    .data_out_P2S1 (data_out_P2S1Est)
    );
endmodule




