#include <stdio.h>
#include "alt_types.h"
#include "sys/alt_timestamp.h"

#define PALABRAS 1024

int memoria[PALABRAS];

void escritura(char* mem_base, char dato) {
  alt_u32 time1;
  alt_u32 time2;
  int i;
  if (alt_timestamp_start() < 0) {
    printf("No timestamp device available\n");
  } else {
    time1 = alt_timestamp();
    for (i = 0; i < PALABRAS; i++) {
      dato = *mem_base;
      mem_base++;
    }
    time2 = alt_timestamp();
    printf("time memory = %u\n", (unsigned int)(time2 - time1));
  }
}

int main(void) {
  register dato = 0;

  int i;
  printf("\nsram\n\n");
  int* buffer = memoria;
  for (i = 0; i < 4; i++) {
    escritura(buffer, dato);
  }

  buffer = (int*)0x01108000;
  printf("\non chip\n\n");
  for (i = 0; i < 4; i++) {
    escritura(buffer, dato);
  }

  buffer = (int*)0x00800000;
  printf("\nsdram\n\n");
  for (i = 0; i < 4; i++) {
    escritura(buffer, dato);
  }

  return 0;
}