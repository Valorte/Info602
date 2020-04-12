#include "cellule.h"

int initialiser_cellule(cellule_t* c, int cellule_x, int cellule_y, int cellule_type)
{
  c->cellule_x = cellule_x;
  c->cellule_y = cellule_y;
  c->cellule_type = cellule_type;
  c->precedent = NULL;
  c->suivant = NULL;
}