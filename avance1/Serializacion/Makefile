#Makefile para ejecutar yosys, gtkwave, cambiarle el nombre del modulo
#al archivo alarma_desc_conductual_SED y mostrar la simulacion de probador.v
########################################################################
#Para ejecutar el make, ir a la carpeta donde se encuentra el archivo y
#en la terminal, escribir make
#Si desea ejecutar solo un target, escriba en la terminal make + target
########################################################################
all: yosys verilog gtkwave

verilog:
	iverilog -o salida.o BancoPruebas.v
	vvp salida.o

yosys:
	yosys yosys.ys
	sed -i 's/serializacion/serializacionEst/m' serializacionEst.v
	sed -i 's/partoserial/partoserialEst/m' serializacionEst.v

gtkwave:
	gtkwave serializacion.vcd
