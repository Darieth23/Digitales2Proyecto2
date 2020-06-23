#Makefile para ejecutar yosys, gtkwave, cambiarle el nombre del modulo
#al archivo alarma_desc_conductual_SED y mostrar la simulacion de probador.v
########################################################################
#Para ejecutar el make, ir a la carpeta donde se encuentra el archivo y
#en la terminal, escribir make
#Si desea ejecutar solo un target, escriba en la terminal make + target
########################################################################
all: yosys verilog gtkwave

verilog:
	iverilog -o salida.o Bancopruebas.v
	vvp salida.o

yosys:
	yosys yosys.ys
	sed -i 's/mux2a1dest_cond/mux2a1dest_est/m' Mux2a1_destEst.v

gtkwave:
	gtkwave mux2a1_dest.vcd
