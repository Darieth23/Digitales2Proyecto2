`timescale 1ns / 1ps

module RAM_memory_vc1 #(
    //Parametros
    parameter DATA_SIZE_vc11 = 10 ,            //cantidad de bits de entrada 
    parameter MAIN_QUEUE_SIZE_vc11 = 8        //Cantiad de filas del main fifo    
)(
    //Entradas
    input                             clk,
    input                             read_vc1,         //enable del read
    input                             write_vc1,        //enable del write
    input                             reset_L,
    input       [DATA_SIZE_vc11-1:0] data_in,
    input       [MAIN_QUEUE_SIZE_vc11-1:0]       wr_ptr_vc1,
    input       [MAIN_QUEUE_SIZE_vc11-1:0]       rd_ptr_vc1,
    output  reg [DATA_SIZE_vc11-1:0] data_out
);
    //memoria a la cual se le accesa con una direccion
    reg[DATA_SIZE_vc11-1:0] ram_mem[2**MAIN_QUEUE_SIZE_vc11-1:0];

    //Se utiliza una expresion condicional para evitar latches
    //valor <= condicion ? if:else
    always@ (*) begin
        data_out = ~reset_L && read_vc1 ? 'b0 : ram_mem[rd_ptr_vc1];    
    end

    always@( posedge clk ) begin
        if (write_vc1) 
            ram_mem[wr_ptr_vc1] <= data_in;          
    end

    
endmodule
