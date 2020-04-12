%{
#include <stdio.h>
#include <stdlib.h>

#include "librairie/ncurses.h"
#include "librairie/liste.h"
#include "librairie/plateau.h"
#include "librairie/robot.h"

extern FILE* yyin;

int yylex();
void yyerror(const char *erreurMsg);

FILE* fichier;
plateau_t* plateau;
robot_t* robot;
liste_t* liste;
%}

%union {
    char* string;
    int entier;
}

%token <entier> ENTIER 
%token VRAI FAUX
%token LARGEUR HAUTEUR DEBUT X Y DIRECTION HAUT BAS GAUCHE DROITE CASES TYPE BLOC BILLE CAISSE TROU
%token PROC FINPROC FUNC FINFUNC AVANCER RECULER AVANCE RECULE VARIABLE I TANTQUE FINTANTQUE MAIN PRENDRE POSER

%type <string> json
%type <string> element
%type <string> objetdebut
%type <string> direction
%type <string> tableaucases
%type <string> objetcases
%type <string> objettype

%%

json:
    '{' element ',' element ',' element ',' element '}' {};

element:
    LARGEUR ':' ENTIER {
        plateau->largeur_plateau = $3;
    }
    |
    HAUTEUR ':' ENTIER {
        plateau->hauteur_plateau = $3;
    }
    |
    DEBUT ':' objetdebut {}
    |
    CASES ':' tableaucases {};

objetdebut:
    '{' X ':' ENTIER',' Y ':' ENTIER',' DIRECTION ':' direction '}' {
        cellule_t* cellule;
        cellule->cellule_x = $4;
        cellule->cellule_y = $8;
        cellule->cellule_type = 5;
        cellule->precedent = NULL;
        cellule->suivant = NULL;
        inserer(liste, cellule);
    };

direction:
    HAUT {
        $$ = 1;
    }
    |
    BAS {
        $$ = 2;
    }
    |
    GAUCHE {
        $$ = 3;
    }
    |
    DROITE {
        $$ = 4;
    };

tableaucases:
    '['objetcases']' {};

objetcases:
    '{' X ':' ENTIER',' Y ':' ENTIER',' TYPE ':' objettype '}' {
        cellule_t* cellule;
        cellule->cellule_x = $4;
        cellule->cellule_y = $8;
        cellule->cellule_type = $12;
        cellule->precedent = NULL;
        cellule->suivant = NULL;
        inserer(liste, cellule);
    };

objettype:
    BLOC { 
        $$ = 1;
    }
    |
    BILLE {
        $$ = 2;
    }
    |
    CAISSE {
        $$ = 3;
    }
    |
    TROU {
        $$ = 4;
    };

%%

int main(int argc, char* argv[])
{
    WINDOW *fenetre_simulation;
    WINDOW *sous_fenetre_simulation;

    plateau = malloc(sizeof(plateau_t));
    robot = malloc(sizeof(robot_t));

    if(argc != 3)
    {
        fprintf(stderr, "Erreur lors du passage d'argument.");
        exit(EXIT_FAILURE);
    }
    else
    {
        if(!(yyin = fopen(argv[1], "r")))
        {
            fprintf(stderr, "Erreur lors de l'ouverture du fichier.");
            exit(EXIT_FAILURE);
        }
        
        yyparse();
        
        if(fclose(yyin) == EOF)
        {
            fprintf(stderr, "Erreur lors de la fermeture du fichier.");
            exit(EXIT_FAILURE);
        }

        if(!(yyin = fopen(argv[2], "r")))
        {
            fprintf(stderr, "Erreur lors de l'ouverture du fichier.");
            exit(EXIT_FAILURE);
        }
        
        yyparse();
        
        if(fclose(yyin) == EOF)
        {
            fprintf(stderr, "Erreur lors de la fermeture du fichier.");
            exit(EXIT_FAILURE);
        }

        if(plateau->largeur_plateau <= 0)
        {
            fprintf(stderr, "La largeur du plateau est incorrecte.");
            exit(EXIT_FAILURE);
        }

        if(plateau->hauteur_plateau <= 0)
        {
            fprintf(stderr, "La hauteur du plateau est incorrecte.");
            exit(EXIT_FAILURE);
        }

        plateau->obstacle_plateau = malloc(sizeof(int) * plateau->largeur_plateau * plateau->hauteur_plateau);
        initialiser_plateau(plateau, liste);

        ncurses_initialisation();

        fenetre_simulation = creer_fenetre(plateau->hauteur_plateau + 2, plateau->largeur_plateau + 2, 5, 0, 1);
        wbkgd(fenetre_simulation, COLOR_PAIR(1));
        mvwprintw(fenetre_simulation, 0, 1, argv[2]);

        sous_fenetre_simulation = creer_sous_fenetre(fenetre_simulation, plateau->hauteur_plateau, plateau->largeur_plateau, 1, 1);
    }
    
    return EXIT_SUCCESS;
}