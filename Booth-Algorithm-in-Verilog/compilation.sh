#!/bin/bash

opcion=

iverilog -o ActPrevia multiplicador_tb.v multiplicador.v uc.v caminosdatos.v componentes.v 
vvp ActPrevia

echo
echo
echo -n "¿Quieres ejecutar el GTKWAVE? [Y/n]: "
read opcion

if [ "$opcion" == "y" ] || [ "$opcion" == "Y" ] ; then
    gtkwave multiplicador_tb.vcd
elif [ "$opcion" == "n" ] || [ "$opcion" == "N" ]; then
    echo
    echo "No se ha abierto el GTKWAVE"
else
    exit 0
fi