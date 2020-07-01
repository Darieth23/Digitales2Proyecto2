module probadorclass#(    //Parametros
    parameter DATA_SIZE = 10             //cantidad de bits de entrada 
  //  parameter MAIN_QUEUE_SIZE=4,       //Cantiad de filas del main fifo 
)(
    //entradas class
    input [7:0] data_out_final0,
    input [7:0] data_out_final1,
    input [7:0] data_out_final0Est,
    input [7:0] data_out_final1Est,
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
    output reg                              pop_e0,//ahorita poner valores iniciales
    //output reg                              push_d1,//ahorita poner valores iniciales
    output reg                              pop_e1, //ahorita poner valores iniciales
    output reg       [7:0]       datain_class,            //datos para hacerle push
    output reg       [DATA_SIZE-1:0]       afVC_o,    //umbral almost vc0 y vc1
    output reg       [DATA_SIZE-1:0]       aeVC_o,      //umbral almost vc0 y vc1  
    output reg       [DATA_SIZE-1:0]       afD_o,    //umbral almost d0 y d1
    output reg       [DATA_SIZE-1:0]       aeD_o,      //umbral almost d0 y d1  
    output reg       [DATA_SIZE-1:0]       afE_o,    //umbral almost d0 y d1
    output reg       [DATA_SIZE-1:0]       aeE_o      //umbral almost d0 y d1 
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
    aeE_o= 'h1; //comprobar tamaño
    afE_o='h3; //comprobar tamaño
    class <= 'b0;
    dest <= 'b0;
    reset_L <= 	'b0;                    //a relojes se resetean            
    push_vc0   <=  'b0;
    push_vc1   <=  'b0;
    pop_e0   <=  'b0;
    pop_e1   <=  'b0;
    //prueba de escritura
    #4;
    //reset
    @(posedge clk)
    reset_L <= 'b1;
    //se mandan datos sin hacer push
    datain_class <= datain_class + 1;
    dest <= 'b1;    
    class <= 'b0;
    repeat(8)begin
        @(posedge clk)
        datain_class <= datain_class + 1;
        class <= class + 1;
        dest <= dest +1; 
    end
    //se inicia el uso de push, este es intercalado, igual que dest y class
    @(posedge clk)
    push_vc0 <= push_vc0+1; 
    datain_class <= 'hAB;
    repeat(8)begin
        @(posedge clk)
        push_vc0 <= push_vc0+1;  
        push_vc1 <= push_vc1+1; 
        datain_class <= datain_class + 1;
        class <= class + 1;
        dest <= dest +1;   
    end
    //mismo destino y misma clase, igual push intercalados
    repeat(5)begin
        @(posedge clk)
        push_vc0 <= push_vc0+1;  
        push_vc1 <= push_vc1+1;
        datain_class <= datain_class + 1;
	dest <= 'b1;
        class <= 'b1;
    end
    //se cambia de clase y dest, estos son iguales
    repeat(4)begin
        @(posedge clk)
        push_vc0 <= push_vc0+1;  
        push_vc1 <= push_vc1+1;
        datain_class <= datain_class + 1;
	dest <= 'b1;
        class <= 'b1;
    end 
    //se envian algunas señales conocidas, con los pop activados, dest y class aleatorios
    push_vc1 <= 1;
    push_vc0 <= 1;
    @(posedge clk)
    datain_class <= 'hFF;
    dest <= 1;
    class <= 0;
    @(posedge clk)
    datain_class <= 'hFA;
    dest <= 1;
    class <= 1;       
    @(posedge clk)
    datain_class <= 'hBB;
    dest <= 0;
    class <= 0;        
    @(posedge clk)    
    datain_class <= 'hAA;
    dest <= 0;
    class <= 1;        
    @(posedge clk)
    datain_class <= 'hDA;
    dest <= 1;
    class <= 0; 
    @(posedge clk) 
    datain_class <= 'hCC;
    dest <= 1;
    class <= 1; 
    @(posedge clk)
    datain_class <= 'hFA;
    dest <= 0;
    class <= 0; 
    @(posedge clk)
    datain_class <= 'hAA;
    dest <= 0;
    class <= 0; 
    //se activan los pop y se desactivan los push
    repeat(4)begin
        @(posedge clk)
    	pop_e0   <=  'b1;
    	pop_e1   <=  'b1;
    end
    @(posedge clk)
    @(posedge clk)    
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    //se vuelve a hacer push intercalado, con los pop activados
    push_vc0 <= 0;  
    repeat(8)begin
        @(posedge clk)
        push_vc1 <= push_vc1+1;
        push_vc0 <= push_vc0+1;  
        class <= class + 1;
        dest <= dest +1;   
        datain_class <= datain_class + 1;
    end
    //se intenta vacearlos todos
    push_vc0 <= 0;
    push_vc1 <= 0;
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
    $finish;
    end
    initial clk <= 0;
    always # 16 clk <= ~clk;       //genera señal 4 ns 
    initial clk_8f <= 0;
    always # 2 clk_8f <= ~clk_8f;       //genera señal 4 ns 
endmodule
