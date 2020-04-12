#include "plateau.h"

void initialiser_plateau(plateau_t* plateau, liste_t* liste)
{
    int i, j;

    for(i = 0; i < plateau->hauteur_plateau; i++)
    {
        for(i = 0; i < plateau->largeur_plateau; i++)
        {
            plateau->obstacle_plateau[j * plateau->largeur_plateau + i];
        }

        while(liste->tete != NULL)
        {
            plateau->obstacle_plateau[liste->tete->cellule_y * plateau->largeur_plateau + liste->tete->cellule_x] = liste->tete->cellule_type;
            liste->tete = liste->tete->suivant;
        }
    }
}

void afficher_plateau(plateau_t* plateau)
{
    int i, j;

    for(i = 0; i < plateau->hauteur_plateau; i++)
    {
        for(i = 0; i < plateau->largeur_plateau; i++)
        {
            printf("%d", plateau->obstacle_plateau[j * plateau->largeur_plateau + i]);
        }

        printf("\n");
    }
}