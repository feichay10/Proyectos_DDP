#include <stdio.h>
#include <ctype.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "pgm.h"
#include "pgm.c"

#define INPUT_FILE "/mnt/host/boat.512.pgm"
#define OUTPUT_FILE "/mnt/host/output_boat.pgm"

//#define INPUT_FILE "boat.512.pgm"
//#define OUTPUT_FILE "output.pgm"

// Kernel para el filtro Gaussiano que se utiliza para calcular el valor de cada pixel en la imagen filtrada
int kernel[3][3] = {{1, 2, 1}, 
										{2, 4, 2}, 
										{1, 2, 1}};

void gaussian_filter(char* input_image, char* output_image) {
  int row, col;
  unsigned char** data = pgmread2(input_image, &row, &col);
  if (!data) {
    printf("Error abriendo imagen\n");
    return;
  }

  // Se reserva memoria para la imagen de salida
  unsigned char** output = (unsigned char**)malloc(row * sizeof(unsigned char*)); 
  // Bucle que recorre la imagen y reserva memoria para cada fila de la imagen de salida
  for (int i = 0; i < row; i++) {
    output[i] = (unsigned char*)malloc(col * sizeof(unsigned char)); 
  }

  clock_t start = clock();
  // Bucle para recorrer la imagen y aplicar el filtro Gaussiano y no sobrepasar los bordes de la imagen
  for (int i = 1; i < row - 1; i++) { 
    for (int j = 1; j < col - 1; j++) {
      int sum = 0;
      // Bucle para calcular la convolución entre el kernel y la imagen. Se suman los productos de los valores de los pixeles vecinos y los valores del kernel
      for (int k = -1; k <= 1; k++) {
        for (int l = -1; l <= 1; l++) {
          sum += data[i + k][j + l] * kernel[k + 1][l + 1]; // Se multiplica el valor del pixel vecino por el valor del kernel y se suma al total
        }
      }
      output[i][j] = sum / 16; // Asigna el valor del pixel en la imagen de salida dividiendo la suma por la suma de los valores del kernel (16)
    }
  }
  clock_t end = clock();

  printf("Tiempo de ejecución: %f\n", (double)(end - start) / CLOCKS_PER_SEC);
  printf("Guardando imagen...\n");
  pgmwrite2(output_image, row, col, output, "Filtro Gaussiano aplicado", 1);
  for (int i = 0; i < row; i++) {
    free(data[i]);
    free(output[i]);
  }
  free(data);
  free(output);
}

int main() {
  printf("Aplicando filtro Gaussiano...\n");
  gaussian_filter(INPUT_FILE, OUTPUT_FILE);
  printf("Terminado...\n");
  return 0;
}
