module demux1a2dest_cond(
    //entradas
    input [7:0] datain_dest,
    input reset_L,
    input clk,
    input class,
    input dest,
    //salidas
    output reg [7:0] outdest0,
    output reg [7:0] outdest1
    );
    reg [7:0] data_reg0dest, data_reg1dest;
    //logica combinacional
    always @ (*) begin 
        outdest0 = 7'b0;
        outdest1 = 7'b0;
        if(!reset_L) begin //para setear las salidas
            outdest0 = 7'b0;
            outdest1 = 7'b0;
        end
        else if(!dest) begin //es de clase 0
            outdest0 = datain_dest;
            outdest1 = data_reg1dest;//almacena el valor anterior
        end
        else if(dest) begin //es de la clase 1
            outdest1 = datain_dest;
            outdest0 = data_reg0dest;//almacena el valor anterior
        end
    end
    //logica secuencial
    always @ (posedge clk) begin
        if(!reset_L) begin //para setear los regs, evitar LATCH
            data_reg0dest <= 0;
            data_reg1dest <= 0;
        end
        else begin //almacena el valor que se agregó en la entrada
            data_reg0dest <= outdest0;
            data_reg1dest <= outdest1;
        end
    end
endmodule




