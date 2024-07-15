
#include "count_binary.h"

void lectura(char *mem_base, char dato, unsigned num_pruebas) {
	alt_u32 time1;
	alt_u32 time2;
	int i;
	if (alt_timestamp_start() < 0)
	{
		printf ("No timestamp device available\n");
	}
	else
	{
		time1 = alt_timestamp();
		for (i = 0; i < num_pruebas; i++) {
			mem_base = dato;
			mem_base++;
		}
		time2 = alt_timestamp();

		printf ("time rd memory = %u ticks\n", (unsigned int) (time2 - time1));
	}
}

void escritura(char* mem_base, char dato, unsigned num_pruebas) {
	alt_u32 time1;
	alt_u32 time2;
	int i;
	if (alt_timestamp_start() < 0)
	{
		printf ("No timestamp device available\n");
	}
	else
	{
		time1 = alt_timestamp();
		for (i = 0; i < 1000; i++) {
			dato = *mem_base;
			mem_base++;
		}
		time2 = alt_timestamp();

		printf ("time wr memory = %u ticks\n", (unsigned int) (time2 - time1));
	}
}


int main(void)
{ 
	unsigned n_pruebas = 1000;

	char *sram_base = (char*)(0x00000000);
	char *sdram_base = (char*)(0x00800000);
	char* on_chip_base = (char*)malloc(n_pruebas);
	char dato = 0;

	int j;
	printf("\nsram\n\n");
	for (j = 0; j < 4; j++) {
		lectura(sram_base, dato, n_pruebas);
		escritura(sram_base, dato, n_pruebas);
	}

	printf("\nsdram\n\n");
	for (j = 0; j < 4; j++) {
		lectura(sdram_base, dato, n_pruebas);
		escritura(sdram_base, dato, n_pruebas);
	}

	printf("\non chip\n\n");
	for (j = 0; j < 4; j++) {
		lectura(on_chip_base, dato, n_pruebas);
		escritura(on_chip_base, dato, n_pruebas);
	}

    return 0;
}