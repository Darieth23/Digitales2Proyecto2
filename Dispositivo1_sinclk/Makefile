#Makefile para ejecutar yosys, gtkwave, cambiarle el nombre del modulo
#al archivo alarma_desc_conductual_SED y mostrar la simulacion de probador.v
########################################################################
#Para ejecutar el make, ir a la carpeta donde se encuentra el archivo y
#en la terminal, escribir make
#Si desea ejecutar solo un target, escriba en la terminal make + target
########################################################################
all: yosys verilog gtkwave

verilog:
	iverilog -o prueba BancoPruebas.v
	vvp prueba

yosys:
	yosys yosys.ys
	sed -i 's/clasificacion/clasificacionEst/m' clasificacionEst.v
	sed -i 's/demux1a2class_cond/demux1a2class_condEst/m' clasificacionEst.v
	sed -i 's/demux_d/demux_dEst/m' clasificacionEst.v
	sed -i 's/fifo_d0/fifo_d0Est/m' clasificacionEst.v
	sed -i 's/fifo_d1/fifo_d1Est/m' clasificacionEst.v
	sed -i 's/fifo_vc0/fifo_vc0Est/m' clasificacionEst.v
	sed -i 's/fifo_vc1/fifo_vc1Est/m' clasificacionEst.v
	sed -i 's/mux2a1dest_cond/mux2a1dest_Est/m' clasificacionEst.v
	sed -i 's/output_flow/output_flowEst/m' clasificacionEst.v
	sed -i 's/partoserial0/partoserial0Est/m' clasificacionEst.v
	sed -i 's/partoserial1/partoserial1Est/m' clasificacionEst.v
	
gtkwave:
	gtkwave bancopruebas.vcd
