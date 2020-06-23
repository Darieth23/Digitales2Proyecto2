`timescale 	1ns	/ 100ps
`include "paraser.v"
`include "probador.v" 
`include "cmos_cells.v" 
`include "paraserEst.v" 
module BancoPruebas;
    wire valid_in, clk, clk_8f, reset_L, data_out_P2S, data_out_P2SEst;
    wire [7:0] data_in;
    probador proba(
                    //salidas
                    .data_in (data_in[7:0]),
                    .valid_in (valid_in),
                    .clk (clk),
                    .clk_8f (clk_8f),
                    .reset_L (reset_L),
                    //entradas
                    .data_out_P2S (data_out_P2S),
                    .data_out_P2SEst (data_out_P2SEst)
    );
    partoserial p2s(
                    //entradas
                    .data_in (data_in[7:0]),
                    .valid_in (valid_in),
                    //.clk (clk),
                    .clk_8f (clk_8f),
                    .reset_L (reset_L),
                    //salidas
                    .data_out_P2S (data_out_P2S)
    );
    partoserialEst p2sEst(
                    //entradas
                    .data_in (data_in[7:0]),
                    .valid_in (valid_in),
                    //.clk (clk),
                    .clk_8f (clk_8f),
                    .reset_L (reset_L),
                    //salidas
                    .data_out_P2S (data_out_P2SEst)        
    );
endmodule





