# Algoritmo de Booth en Verilog
![Camino de Datos](https://github.com/feichay10/Booth-Algorithm-in-Verilog/blob/70920594e56f60ddfdc3edd10f67fb061fde136d/assets/2022-03-02_09-21.png)

## Objetivo
El objetivo de este algoritmo es la multiplicación de dos números con signo (3 bits en Complemento a 2). Para ello, el sistema se compone de una Unidad de Control, 
implementada como un autómata de estados finito (máquina tipo Mealy) y un camino de datos que representa las conexiones necesarias para hacer el algoritmo de multiplicación (Algoritmo de Booth).

## Esquema del funcionamiento de la Maquina de Estados
![Maquina de Estados](https://github.com/feichay10/Booth-Algorithm-in-Verilog/blob/d177db168d7c8db160f49bb09e13f028b3057ef7/assets/Diagrama%20de%20Estados.jpg)

## Compilación
Para compilar el programa, es recomendable usar el Script de Bash `compilation.sh`. Este script se encarga de hacer la compilación de forma automática y también genera el fichero `ActPrevia` para mostrar los resultados del test. Además, genera otro fichero llamado `multiplicador_tb.vcd` para posterior análisis en el programa GTKWAVE. Desde el Script de Bash tras la compilacion y la ejecución del programa te pregunta si se quiere ejecutar el programa GTKWAVE.

![Ejecucion](https://github.com/feichay10/Booth-Algorithm-in-Verilog/blob/5e2ee1501580a66070a032f487a698850f38aa77/assets/Compilacion.png)

El comando utilizado para compilar es:
```bash

iverilog -o ActPrevia multiplicador_tb.v multiplicador.v uc.v caminosdatos.v componentes.v

```
Si queremos directamente compilar el programa, mostrar los resultados, generar los ficheros y acceder al GTKWAVE, podemos utilizar el programa `compilation.sh`. Solo hay que ejecutar el siguiente comando:
```bash

./compilation.sh

```
## Problemas
Los problemas que tuve al realizar la actividad fueron las interconexiones de los diferentes módulos y realizar el camino de datos en código Verilog. Además, no me acordaba mucho de este lenguaje de descripción de hardware que eso hizo que se me complicara un poco más la realizacion de ella. 
