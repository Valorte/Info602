#include "liste.h"

void initialiser_liste(liste_t* l)
{
  l->tete = NULL;
}

void detruire_liste(liste_t* l)
{
  while(l->tete != NULL)
  {
    supprimer(l, l->tete);
  }
}

void inserer(liste_t* l, cellule_t* c)
{
  c->suivant = l->tete;

  if(l->tete != NULL)
  {
    l->tete->precedent = c;
  }

  l->tete = c;
  c->precedent = NULL;
}

void afficher_liste(liste_t* l)
{
  cellule_t* cellule = malloc(sizeof(cellule_t));
  cellule = l->tete;

  if(cellule == NULL)
  {
    printf("La liste est vide.");
  }

  while(cellule != NULL)
  {
    if(cellule->suivant == NULL)
    {
      printf("%d, %d", cellule->cellule_x, cellule->cellule_y);
    } 
    else 
    {
      printf("%d, %d -> ", cellule->cellule_x, cellule->cellule_y);
    }
    cellule = cellule->suivant;
  }

  printf("\n\n");
}

cellule_t* rechercher(liste_t* l, int cellule_x, int cellule_y)
{
  cellule_t* cellule = malloc(sizeof(cellule_t));
  cellule = l->tete;

  while(cellule != NULL && cellule->cellule_x != cellule_x && cellule->cellule_x != cellule_y)
  {
    cellule = cellule->suivant;
  }

  return cellule;
}

void supprimer(liste_t* l, cellule_t* c)
{
  if(c->precedent != NULL)
  {
    c->precedent->suivant = c->suivant;
  }
  else
  {
    l->tete = c->suivant;
  }
  if(c->suivant != NULL)
  {
    c->suivant->precedent = c->precedent;
  }

  c = NULL;
}
