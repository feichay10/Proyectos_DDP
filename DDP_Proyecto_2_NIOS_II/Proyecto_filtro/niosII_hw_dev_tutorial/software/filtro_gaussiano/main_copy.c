#include <ctype.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "sys/alt_timestamp.h"
#include "alt_types.h"

#include "pgm.h"
#include "pgm.c"

// #define INPUT_FILE "/mnt/host/boat.512.pgm"
// #define OUTPUT_FILE "/mnt/host/output_boat_v5.pgm"

#define INPUT_FILE "boat.512.pgm"
#define OUTPUT_FILE "output_boat_v5.pgm"

// Anotaciones: la imagen tendria que ser mas pequeña

// Se crea una matriz de salida con un tamaño menor que la original para no
// sobrepasar los bordes de la imagen al aplicar el filtro Gaussiano
// Esto se hace restando 2 a las dimensiones de la imagen original
// ya que para aplicar el filtro Gaussiano se necesitan al menos 2 pixeles
// de margen en cada borde de la imagen para no sobrepasar los bordes
// ya que el calculo del filtro se hace con un kernel de 3x3
// y se hace sobre los pixeles vecinos de cada pixel en la imagen.

// Bucle para calcular la convolución entre el kernel y la imagen. Se
// suman los productos de los valores de los pixeles vecinos y los valores
// del kernel, si el (1,1) es en la matriz original, en la nueva matriz
// sera la (0,0) y si es el (510,510) en la nueva matriz seria (509,509)

// Restarle los indices para la nueva matriz. La nueva imagen 
// tendria que ser de menor tamaño quitando la primera y ultima fila; 
// y la primera y ultima columna, osea 510x510

// Medidas:
// Que cosas podriamos hacer tocando QSYS
// jugando con la memoria on chip si dedicamos cache, tipo cache, etc

// Kernel para el filtro Gaussiano que se utiliza para calcular el valor de cada
// pixel en la imagen filtrada
int kernel[3][3] = {{1, 2, 1}, 
                    {2, 4, 2}, 
                    {1, 2, 1}};

void gaussian_filter(char* input_image, char* output_image) {
  int row, col;
  alt_u32 time1;
  alt_u32 time2;
  unsigned char** data = pgmread2(input_image, &row, &col);
  if (!data) {
    printf("Error abriendo imagen\n");
    return;
  }

  unsigned char** output = (unsigned char**)malloc((row - 2) * sizeof(unsigned char*));
  int i, j, k, l;
  for (i = 0; i < row - 2; i++) {
    output[i] = (unsigned char*)malloc((col - 2) * sizeof(unsigned char));
  }

  // Bucle para recorrer la imagen y aplicar el filtro Gaussiano y no sobrepasar los bordes de la imagen
  printf("Procesando...\n");
  if (alt_timestamp_start() < 0) {
    printf ("No timestamp device available\n");
  } else {
    time1 = alt_timestamp();
    for (i = 1; i < row - 1; i++) {
      for (j = 1; j < col - 1; j++) {
        int sum = 0;
        for (k = 0; k < 3; k++) {
          for (l = 0; l < 3; l++) {
            sum += data[i - 1 + k][j - 1 + l] * kernel[k][l];
          }
        }
        output[i - 1][j - 1] = sum / 16;  // Asigna el valor del pixel en la imagen de salida dividiendo la suma por la suma de los valores del kernel (16)
      }
    }
    time2 = alt_timestamp();
    printf ("Tiempo de ejecución = %u\n", (unsigned int)(time2 - time1));
  }

  printf("Guardando imagen...\n");
  pgmwrite2(output_image, row - 2, col - 2, output, "Filtro Gaussiano aplicado", 1);
  for (i = 0; i < row - 2; i++) {
    free(data[i]);
    free(output[i]);
  }
  free(data);
  free(output);
}

// int main() {
//   printf("Aplicando filtro Gaussiano...\n");
//   gaussian_filter(INPUT_FILE, OUTPUT_FILE);
//   printf("Terminado...\n");
//   return 0;
// }