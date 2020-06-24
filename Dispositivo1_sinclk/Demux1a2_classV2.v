module demux1a2class_cond(
    //entradas
    input [7:0] datain_class,
    input class,
    input dest,
    input reset_L,
    input clk,
    //salidas
    output reg [9:0] outclass0,
    output reg [9:0] outclass1
    );
    reg [9:0] data_reg0, data_reg1;
    //logica combinacional
    always @ (*) begin 
        outclass0 = 10'b0;
        outclass1 = 10'b0;
        if(!reset_L) begin //para setear las salidas
            outclass0 = 10'b0;
            outclass1 = 10'b0;
        end
        else if(!class) begin //es de clase 0
            outclass0[7:0] = datain_class;
            outclass0[8] = dest;
            outclass0[9] = class;
            outclass1 = data_reg1;//almacena el valor anterior
        end
        else if(class) begin //es de la clase 1
            outclass1[7:0] = datain_class;
            outclass1[8] = dest;
            outclass1[9] = class;
            outclass0 = data_reg0;//almacena el valor anterior
        end
    end
    //logica secuencial
    always @ (posedge clk) begin
        if(!reset_L) begin //para setear los regs, evitar LATCH
            data_reg0 <= 0;
            data_reg1 <= 0;
        end
        else begin //almacena el valor que se agregó en la entrada
            data_reg0 <= outclass0;
            data_reg1 <= outclass1;
        end
    end
endmodule



