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

  unsigned char** output = (unsigned char**)malloc((row - 2) * sizeof(unsigned char*));
  int i, j, k, l;
  for (i = 0; i < row - 2; i++) {
    output[i] = (unsigned char*)malloc((col - 2) * sizeof(unsigned char));
  }

  for (i = 1; i < row - 1; i++) {
    for (j = 1; j < col - 1; j++) {
      int sum = 0;
      for (k = 0; k < 3; k++) {
        for (l = 0; l < 3; l++) {
          sum += data[i - 1 + k][j - 1 + l] * kernel[k][l];
        }
      }
      output[i - 1][j - 1] = sum / 16;
    }
  }

  pgmwrite2(output_image, row - 2, col - 2, output, "Filtro Gaussiano aplicado", 1);

  for (i = 0; i < row - 2; i++) {
    free(data[i]);
    free(output[i]);
  }
  free(data);
  free(output);
}