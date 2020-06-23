module partoserial(
    //entradas
    input [7:0]data_in,
    input valid_in,
    input reset_L,
    input clk_8f,
    //salidas
    output reg data_out_P2S
    );

reg [7:0]data2send;
reg [3:0]contador;
always @(*)begin //Se verifica si pasa o no el valor dependiendo del bit de válido
    if(reset_L==0)begin //Todo apagado, se pasa el valor por defecto
        data2send='hBC;
    end
    else begin 
       if (valid_in==1)
            data2send=data_in;
        else //Valor por defecto
            data2send='hBC; 
    end
end
always @(posedge clk_8f)begin
    if(reset_L==0)begin
        data_out_P2S<='b0;
        contador<=0;
    end
    else begin    //Lógica para reconocer los valores del arreglo de bits
        data_out_P2S<=data2send[7-contador];
        contador<=contador+1;
        if(contador==7)begin
            contador<='b0;
        end
    end
end
endmodule
