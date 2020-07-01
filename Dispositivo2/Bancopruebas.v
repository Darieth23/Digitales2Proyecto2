`include "probadordisp2.v"
//`include "serialtopar0.v"
//7`include "serialtopar1.v"
`include "serialtopar0Est.v"
`include "serialtopar1Est.v"
`include "cmos_cells.v"
module Bancopruebas;

    wire clk,clk_8f,data_in,reset_L,data_inser0;
    wire [7:0]	data_outser1, data_outser0;
    wire valid_outser1,valid_outser0;

    probador prob(
        //salidas
        .clk (clk),
        .clk_8f (clk_8f),
        .data_in (data_in),
        .data_inser0 (data_inser0),
        .reset_L (reset_L),
        //entradas
        .data_outser1 (data_outser1[7:0]),
        .data_outser0 (data_outser0[7:0]),
        .valid_outser1 (valid_outser1),
        .valid_outser0 (valid_outser0)
    );
    serialtopar ser1(
        //entradas
        .clk (clk),
        .clk_8f (clk_8f),
        .data_in (data_in),
        .reset_L (reset_L),
        //salidas
        .data_outser1 (data_outser1),
        .valid_outser1 (valid_outser1)
    );
    serialtopar0 ser0(
        //entradas
        .clk (clk),
        .clk_8f (clk_8f),
        .data_inser0 (data_inser0),
        .reset_L (reset_L),
        //salidas
        .data_outser0 (data_outser0),
        .valid_outser0 (valid_outser0)        
    );


endmodule