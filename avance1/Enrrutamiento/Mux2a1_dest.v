module mux2a1dest_cond(
    //entradas
    input pop0,//valid0 y prioridad absoluta para este
    input pop1,//valid1 y prioridad baja
    input [9:0] datain_dest0,
    input [9:0] datain_dest1,
    input reset_L,
    //salidas
    output reg validoutdest,
    output reg [9:0] dataout_dest
    );
    reg [9:0] temp;
    reg validtemp;
    always @ (*) begin
        temp = 10'b0;
        validtemp = 0;
        if(pop0 == 1 && pop1 == 0) begin
            validtemp = pop0;
            temp = datain_dest0;
        end
        else if(pop0 == 0 && pop1 == 1) begin
            validtemp = pop1;
            temp = datain_dest1;
        end
        else if(pop0 == 1 && pop1 == 1) begin
            validtemp = pop0;
            temp = datain_dest0;
        end
        else begin
            validtemp = 0;
            temp = 10'b0;
        end   
    end
    always @ (*) begin
        if(!reset_L) begin
            dataout_dest <= 10'b0;
            validoutdest <= 0;
        end
        else begin
            dataout_dest <= temp;
            validoutdest <= validtemp;
        end
    end
endmodule






