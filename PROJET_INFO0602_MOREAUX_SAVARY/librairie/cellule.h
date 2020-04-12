#ifndef CELLULE_H
#define CELLULE_H

#include <stdio.h>

typedef struct cellule_type {
  int cellule_x;
  int cellule_y;
  int cellule_type;
  struct cellule_type* precedent;
  struct cellule_type* suivant;
} cellule_t;

int initialiser_cellule(cellule_t* c, int cellule_x, int cellule_y, int cellule_type);

#endif