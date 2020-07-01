`timescale 1ns / 1ps

module RAM_memory_d0 #(
    //Parametros
    parameter DATA_SIZE = 10 ,            //cantidad de bits de entrada 
    parameter MAIN_QUEUE_SIZE = 8        //Cantiad de filas del main fifo    
)(
    //Entradas
    input                             clk,
    input                             read,         //enable del read
    input                             write,        //enable del write
    input                             reset_L,
    input       [DATA_SIZE-1:0] data_in,
    input       [MAIN_QUEUE_SIZE-1:0]       wr_ptr,
    input       [MAIN_QUEUE_SIZE-1:0]       rd_ptr,
    output  reg [DATA_SIZE-1:0] data_out
);
    //memoria a la cual se le accesa con una direccion
    reg[DATA_SIZE-1:0] ram_mem[2**MAIN_QUEUE_SIZE-1:0];

    //Se utiliza una expresion condicional para evitar latches
    //valor <= condicion ? if:else
    always@ (*) begin
        data_out = ~reset_L && read ? 'b0 : ram_mem[rd_ptr];    
    end

    always@( posedge clk ) begin
        if (write) 
            ram_mem[wr_ptr] <= data_in;          
    end

    
endmodule
