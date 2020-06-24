module probadorclass#(    //Parametros
    parameter DATA_SIZE = 10             //cantidad de bits de entrada 
  //  parameter MAIN_QUEUE_SIZE=4,       //Cantiad de filas del main fifo 
)(

    //entradas class
    input dataout_0,
    input dataout_1,
    input dataout_0Est,
    input dataout_1Est,
    // input                           almost_full_cond,
    // input                           almost_empty_cond,
    input                           fifo_empty_vc0,
    input                           fifo_empty_vc1, 
    // input  [DATA_SIZE-1:0]         data_count_cond,         //numero de datos
    //input   [DATA_SIZE-1:0]         buffer_out_cond,            //datos para hacerle pop

    

    output reg                              clk,
    output reg                              clk_8f,
    output reg                              reset_L,
    output reg				    dest,
    output reg				    class,
    output reg                              push_vc0,
    output reg                              push_vc1,

   // output reg                              push_d0,//ahorita poner valores iniciales
    output reg                              pop_d0,//ahorita poner valores iniciales
    //output reg                              push_d1,//ahorita poner valores iniciales
    output reg                              pop_d1, //ahorita poner valores iniciales

    output reg       [7:0]       datain_class,            //datos para hacerle push
    output reg       [DATA_SIZE-1:0]       afVC_o,    //umbral almost vc0 y vc1
    output reg       [DATA_SIZE-1:0]       aeVC_o,      //umbral almost vc0 y vc1  
    output reg       [DATA_SIZE-1:0]       afD_o,    //umbral almost d0 y d1
    output reg       [DATA_SIZE-1:0]       aeD_o      //umbral almost d0 y d1  
);
 

 initial begin

    $dumpfile("bancopruebas.vcd");        //Dumpfile to make in current folder
    $dumpvars;
    push_vc0<='b0;

    datain_class<='b0;
    aeVC_o= 'h4;
    afVC_o='h6;
    aeD_o= 'h3; //comprobar tamaño
    afD_o='h5; //comprobar tamaño
    class <= 'b0;
    dest <= 'b0;
    reset_L <= 	'b0;                    //a relojes se resetean            
    push_vc0   <=  'b0;
    push_vc1   <=  'b0;


    pop_d0   <=  'b0;
    pop_d1   <=  'b0;

    //prueba de escritura
    #4;
    @(posedge clk)
    
    datain_class <= 'h3;
    
    repeat(6)begin
        @(posedge clk)
        datain_class<=datain_class+1;
    end

    
    @(posedge clk)
    datain_class<=datain_class+1;
	class <= 'b0;
    @(posedge clk)
    datain_class<=datain_class+1;
	class <= 'b1;
    @(posedge clk)
    datain_class<=datain_class+1;
	class <= 'b0;

repeat(4)begin
        @(posedge clk)
reset_L <= 	'b1;
        push_vc0 <= 1;  
	push_vc1 <= 0; 
    	pop_d0   <=  'b0;
    	pop_d1   <=  'b1;
        datain_class <= datain_class + 1;
	dest <= 'b1;
class <= 'b0;
        end

repeat(4)begin
        @(posedge clk)
        push_vc0 <= 0;  
	push_vc1 <= 1; 
    	pop_d0   <=  'b1;
    	pop_d1   <=  'b0;
        datain_class <= datain_class + 1;
	dest <= 'b0;
class <= 'b1;
        end
/*
repeat(4)begin
        @(posedge clk)
reset_L <= 	'b1;
        push_vc0 <= 1;  
	push_vc1 <= 1; 
   	push_d0   <=  'b1;
   	push_d1   <=  'b1;
    	pop_d0   <=  'b1;
    	pop_d1   <=  'b1;
        datain_class <= datain_class + 1;
	dest <= 'b0;
class <= 'b0;
        end

repeat(4)begin
        @(posedge clk)
        push_vc0 <= 1;  
	push_vc1 <= 1; 
   	push_d0   <=  'b1;
   	push_d1   <=  'b1;
    	pop_d0   <=  'b1;
    	pop_d1   <=  'b1;
        datain_class <= datain_class + 1;
	dest <= 'b1;
class <= 'b1;
        end*/

    
    @(posedge clk)
        push_vc0<=0;
       @(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
@(posedge clk)
        

    repeat(4)begin
        @(posedge clk)
        push_vc0 <= 0;
        // datain_class<='h4;
    end

    $finish;
end
    initial clk <= 0;
    always # 16 clk <= ~clk;       //genera señal 4 ns 
    initial clk_8f <= 0;
    always # 2 clk_8f <= ~clk_8f;       //genera señal 4 ns 

endmodule
