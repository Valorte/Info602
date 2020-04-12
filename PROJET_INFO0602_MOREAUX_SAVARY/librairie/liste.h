#ifndef LISTE_H
#define LISTE_H

#include <stdio.h>
#include <stdlib.h>
#include "cellule.h"

typedef struct liste_type {
  cellule_t* tete;
} liste_t;

void initialiser_liste(liste_t* l);
void detruire_liste(liste_t* l);
void inserer(liste_t* l, cellule_t* c);
void afficher_liste(liste_t* l);
cellule_t* rechercher(liste_t* l, int cellule_x, int cellule_y);
void supprimer(liste_t*, cellule_t* c);

#endif