#include <stdio.h>
#include "sys/alt_timestamp.h"
#include "alt_types.h"
#include <time.h>

// Escribir un buffer de 1024 palabras
// VAR global de tipo int (array), que escribe 1024 palabras // int array[1024]; -> tomar tiempos
// Pruebas:
// - Escribir (32 bits, int), (8 bits, char)
// - Leer (32 bits, int), (8 bits, char)

// Lo hago en:
// - On chip -> Cache de codigo o tighly coupled memory (memoria que va directa al procesador, como si tuviera un bus exclusivo que va directo a la CPU)
// - SRAM
// - SDRAM

// En onchip y sdram -> usar un puntero inicializando al principio de la memoria

// Hacer un programa que lea lo mas rapido posible y escriba lo mas rapido posible

// int * pepe = (int)0x0080000 (direccion inicial de la memoria)

// Lectura
// for (i -> 1024)
// 	dato = *pepe++; Lectura -> IORD

// Escritura
// for (i -> 1024);
//	*pepe++ = dato; Escritura -> IOWR

// IORD y IOWR para evitar el cache de datos

// Resultados aprox:
/*TimeStartSRAM = 86
TimeEndSRAM = 29033
SRAM TimeEnd - TimeStart = 28947

TimeStart OnChip = 96
TimeEnd OnChip = 26265
OnChip TimeEnd - TimeStart = 26169

TimeStartSDRAM = 86
TimeEndSDRAM = 34320
SDRAM TimeEnd - TimeStart = 34234*/

#define PALABRAS 1024

char memoria[PALABRAS];

int main(void)
{
	alt_u32 timeStartOnChip;
	alt_u32 timeEndOnChip;

	char dato;
	int i;
	char *buffer = memoria;

	if (alt_timestamp_start() != 0) {
		printf("No timestamp device available\n");
	} else {
		alt_timestamp_start();
		timeStartOnChip = alt_timestamp();
		for (i = 0; i < PALABRAS / 16; i++) {
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
		}
		timeEndOnChip = alt_timestamp();
		/*for (int i = 0; i < PALABRAS; i++) {
			*buffer++ = dato;
		}*/
	}

	printf("TimeStartSRAM = %u\n", (unsigned int)timeStartOnChip);
	printf("TimeEndSRAM = %u\n", (unsigned int)timeEndOnChip);
	printf("SRAM TimeEnd - TimeStart = %u\n\n", (unsigned int)timeEndOnChip - timeStartOnChip);

	// On Chip
	buffer = (char*)0x01108000;
	if (alt_timestamp_start() != 0) {
		printf("No timestamp device available\n");
	} else {
		alt_timestamp_start();
		timeStartOnChip = alt_timestamp();
		// Lectura On Chip
		for (i = 0; i < PALABRAS / 16; i++) {
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
		}
		timeEndOnChip = alt_timestamp();
		// Escritura On Chip
		/*for (int i = 0; i < PALABRAS; i++) {
			*buffer++ = dato;
		}*/
	}

	printf("TimeStart OnChip = %u\n", (unsigned int)timeStartOnChip);
	printf("TimeEnd OnChip = %u\n", (unsigned int)timeEndOnChip);
	printf("OnChip TimeEnd - TimeStart = %u\n\n", (unsigned int)timeEndOnChip - timeStartOnChip);


	buffer = (char*)0x00800000;
	if (alt_timestamp_start() != 0) {
		printf("No timestamp device available\n");
	} else {
		alt_timestamp_start();
		timeStartOnChip = alt_timestamp();
		// Lectura On Chip
		for (i = 0; i < PALABRAS / 16; i++) {
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
			dato = *buffer++;
		}
		timeEndOnChip = alt_timestamp();
		// Escritura On Chip
		/*for (int i = 0; i < PALABRAS; i++) {
			*buffer++ = dato;
		}*/
	}

	printf("TimeStartSDRAM = %u\n", (unsigned int)timeStartOnChip);
	printf("TimeEndSDRAM = %u\n", (unsigned int)timeEndOnChip);
	printf("SDRAM TimeEnd - TimeStart = %u\n", (unsigned int)timeEndOnChip - timeStartOnChip);
}
