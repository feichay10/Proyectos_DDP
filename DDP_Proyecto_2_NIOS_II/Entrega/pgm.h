/*
 * pgm4.h
 *
 *
 *
 */

#ifndef PGM4_H_

#define PGM4_H_

#include <ctype.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned char** pgmread(char* filename, int* w, int* h);
int pgmwrite(char* filename, int w, int h, unsigned char** data, char* comment_string, int binsave);

unsigned char** pgmread2(char* filename, int* row, int* col);

int pgmwrite2(char* filename, int row, int col, unsigned char** data, char* comment_string, int binsave);

int ppmwrite2(char* filename, int row, int col, unsigned char** datar, unsigned char** datag, unsigned char** datab,
              char* comment_string, int binsave);

#endif /* PGM4_H_ */
