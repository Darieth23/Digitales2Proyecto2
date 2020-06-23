`include "paraser.v"
module serializacion(
    //entradas
    input [7:0] data_in0,
    input [7:0] data_in1,
    input valid_in0,
    input valid_in1,
    input reset_L,
    input clk_8f,
    //salidas
    output wire data_out_P2S0,
    output wire data_out_P2S1
    );
    partoserial p2s0(data_in0,valid_in0,reset_L,clk_8f,data_out_P2S0);
    partoserial p2s1(data_in1,valid_in1,reset_L,clk_8f,data_out_P2S1);
endmodule