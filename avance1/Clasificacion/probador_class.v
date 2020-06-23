module probadorclass#(    //Parametros
    parameter DATA_SIZE = 10             //cantidad de bits de entrada 
  //  parameter MAIN_QUEUE_SIZE=4,        //Cantiad de filas del main fifo    
)(

    //entradas class
    input [9:0] data_mux_0,
    input [9:0] data_mux_1,

    // input                           almost_full_cond,
    // input                           almost_empty_cond,
    input                           fifo_empty_vc0,
    input                           fifo_empty_vc1, 
    // input  [DATA_SIZE-1:0]         data_count_cond,         //numero de datos
    //input  [DATA_SIZE-1:0]         buffer_out_cond,            //datos para hacerle pop

    
    input fifo_error_vc0,
    input fifo_pause_vc0,
    input fifo_error_vc1,
    input fifo_pause_vc1,
    output reg                              clk,
    output reg                              reset_L,
    output reg                              pop_vc0,
    output reg                              pop_vc1,
    output reg                              push_vc0,
    output reg                              push_vc1,
    output reg       [DATA_SIZE-1:0]       datain_class,            //datos para hacerle push
    output reg       [DATA_SIZE-1:0]       afVC_o,    //umbral almost 
    output reg       [DATA_SIZE-1:0]       aeVC_o
);
 

 initial begin

    $dumpfile("bancopruebas.vcd");        //Dumpfile to make in current folder
    $dumpvars;
    push_vc0<='b0;
    pop_vc0<='b0;
    datain_class<='b0;
    aeVC_o= 'h3;
    afVC_o='h6;

    reset_L <= 	'b0;                    //a relojes se resetean            
    pop_vc0    <=  'b0;
    push_vc0   <=  'b0;
    pop_vc1    <=  'b0;
    push_vc1   <=  'b0;

    //prueba de escritura
    #4;
    @(posedge clk)
    reset_L <= 	'b1;
    datain_class <= 'h3;
    
    repeat(6)begin
        @(posedge clk)
        datain_class<=datain_class+1;
    end

    
    @(posedge clk)
    datain_class<=datain_class+1;
    repeat(260)begin
        @(posedge clk)
        push_vc0 <= 1;  
	push_vc1 <= 1;   
        datain_class <= datain_class + 1;
        
    end

    
    @(posedge clk)
        push_vc0<=0;
        // pop_vc0 <= 1;
        

    repeat(2)begin
        @(posedge clk)
        //mandar direcciones random a wr_ptr
        pop_vc0 <= 1;
    end
        
    repeat(2)begin
        @(posedge clk)
            push_vc0<=0;
            pop_vc0 <= 0;
    end

    repeat(4)begin
        @(posedge clk)
            //mandar direcciones random a wr_ptr
            pop_vc0<=0; 
    end

    repeat(7)begin
        @(posedge clk)
            pop_vc0 <= 1;
	    pop_vc1 <= 1; 
    end
    @(posedge clk)
        pop_vc0 <= 0;

    // @(posedge clk)
    //     //mandar direcciones random a wr_ptr
    //     pop_vc0<=1;

    repeat(4)begin
        @(posedge clk)
        pop_vc0<=0;
        push_vc0 <= 0;
        // datain_class<='h4;
    end

    $finish;
end
    initial clk <= 0;
    always # 2 clk <= ~clk;       //genera señal 4 ns 

endmodule
