#include <ctype.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "pgm.h"

#define INPUT_FILE "/mnt/host/boat.512.pgm"
#define OUTPUT_FILE "/mnt/host/output_boat.510.pgm"

#define REPETICIONES 5

int kernel[3][3] = {{1, 2, 1},
                    {2, 4, 2},
                    {1, 2, 1}};

void gaussian_filter(char* input_image, char* output_image) {
  int row, col;

  printf("Leyendo imagen\n");
  clock_t start_read_image = clock();
  unsigned char** data = pgmread2(input_image, &row, &col);
  clock_t end_read_image = clock();
  printf("Tiempo que tardo en leer la imagen: %2.3f seg\n", (double)(end_read_image - start_read_image) / CLOCKS_PER_SEC);
  if (!data) {
    printf("Error abriendo imagen\n");
    return;
  }

  clock_t start_filtro = clock();
  unsigned char** output = (unsigned char**)malloc((row - 2) * sizeof(unsigned char*));
  int i, j, k, l;
  for (i = 0; i < row - 2; i++) {
    output[i] = (unsigned char*)malloc((col - 2) * sizeof(unsigned char));
  }

  // Bucle para recorrer la imagen y aplicar el filtro Gaussiano y no sobrepasar los bordes de la imagen
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
  clock_t end_filtro = clock();

  double tiempo_filtro = (double)(end_filtro - start_filtro) / CLOCKS_PER_SEC;
  double minutos_filtro = tiempo_filtro / 60;
  printf("Tiempo ejecucion de solo el filtro: %2.3f segundos y %.2f minutos\n", tiempo_filtro, minutos_filtro);

  printf("Guardando imagen...\n");
  clock_t start_write_image = clock();
  pgmwrite2(output_image, row - 2, col - 2, output, "Filtro Gaussiano aplicado", 1);
  clock_t end_write_image = clock();
  printf("Tiempo que tardo en leer la imagen: %2.3f seg\n", (double)(end_write_image - start_write_image) / CLOCKS_PER_SEC);

  for (i = 0; i < row - 2; i++) {
    free(data[i]);
    free(output[i]);
  }
  free(data);
  free(output);
}

int main() {
  // vector para guardar los tiempos de ejecución
  double tiempos[REPETICIONES];

  int i;

  for (i = 0; i < REPETICIONES; i++) {
    printf("Aplicando filtro Gaussiano en la repetición %d...\n", i + 1);
    clock_t start = clock();
    gaussian_filter(INPUT_FILE, OUTPUT_FILE);
    clock_t end = clock();
    tiempos[i] = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Tiempo en la repeticion %d: %2.3f", i + 1, tiempos[i]);
    printf("\nTerminado en la repetición %d...\n\n", i + 1);
  }

  // Calcular el tiempo promedio
  double tiempo_promedio = 0;
  for (i = 0; i < REPETICIONES; i++) {
	tiempo_promedio += tiempos[i];
  }
  tiempo_promedio /= REPETICIONES;
  double minutos_promedio = tiempo_promedio / 60;
  printf("Tiempo promedio de ejecución del programa: %2.3f segundos y %.2f minutos\n", tiempo_promedio, minutos_promedio);

  return 0;
}

