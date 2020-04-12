#ifndef PLATEAU_H
#define PLATEAU_H

#include <stdio.h>
#include "liste.h"

typedef struct plateau_type {
    int largeur_plateau;
    int hauteur_plateau;
    int* obstacle_plateau;
} plateau_t;

void initialiser_plateau(plateau_t* plateau, liste_t* liste);
void afficher_plateau(plateau_t* plateau);

#endif