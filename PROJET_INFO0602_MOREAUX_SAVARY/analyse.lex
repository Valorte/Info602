%{
#include <stdio.h>
#include "y.tab.h"

#include "librairie/ncurses.h"
#include "librairie/liste.h"
#include "librairie/plateau.h"
#include "librairie/robot.h"

int yylex();
void yyerror(const char *erreurMsg);
%}

LARGEUR "\"largeur\""
HAUTEUR "\"hauteur\""
DEBUT "\"debut\""
X "\"x\""
Y "\"y\""
DIRECTION "\"direction\""
HAUT "\"HAUT\""
BAS "\"BAS\""
GAUCHE "\"GAUCHE\""
DROITE "\"DROITE\""
CASES "\"cases\""
TYPE "\"type\""
BLOC "\"BLOC\""
BILLE "\"BILLE\""
CAISSE "\"CAISSE\""
TROU "\"TROU\""

PROC "proc"
FINPROC "finproc"
FUNC "func"
FINFUNC "finfunc"
AVANCER "avancer"
RECULER "reculer"
AVANCE "avance"
RECULE "recule"
VARIABLE (entier|bool)
I "i"
TANTQUE "tantque"
FINTANTQUE "finttantque"
MAIN "main"
C_DROITE "droite"
C_GAUCHE "gauche"
PRENDRE "prendre"
POSER "poser"

ENTIER [0-9]+
VRAI "true"
FAUX "false"

%%

{LARGEUR} { return LARGEUR; }
{HAUTEUR} { return HAUTEUR; }
{DEBUT} { return DEBUT; }
{X} { return X; }
{Y} { return Y; }
{DIRECTION} { return DIRECTION; }
{HAUT} { return HAUT; }
{BAS} { return BAS; }
{GAUCHE} { return GAUCHE; }
{DROITE} { return DROITE; }
{CASES} { return CASES; }
{TYPE} { return TYPE; }
{BLOC} { return BLOC; }
{BILLE} { return BILLE; }
{CAISSE} { return CAISSE; }
{TROU} { return TROU; }

{PROC} { return PROC; }
{FINPROC} { return FINPROC; }
{FUNC} { return FUNC; }
{FINFUNC} { return FINFUNC; }
{AVANCER} { return AVANCER; }
{RECULER} { return RECULER; }
{AVANCE} { return AVANCE; }
{RECULE} { return RECULE; }
{VARIABLE} { return *yytext; }
{I} { return I; }
{TANTQUE} { return TANTQUE; }
{FINTANTQUE} { return FINTANTQUE; }
{MAIN} { return MAIN; }
{C_DROITE} { return DROITE; }
{C_GAUCHE} { return GAUCHE; }
{PRENDRE} { return PRENDRE; }
{POSER} { return POSER; }

{ENTIER} { yylval.entier = atoi(yytext); return ENTIER; }
{VRAI} { return VRAI; }
{FAUX} { return FAUX; }

[\:,=\n\(\)\{\}\*\+\-\/\%!] { return *yytext; }
[\t\n\r] ;

. { yyerror("Caractère non valide"); }

%%

void yyerror(const char *erreurMsg) 
{
  fprintf(stderr, "\n Erreur '%s' sur '%s'.\n", erreurMsg, yytext);
  exit(EXIT_FAILURE);
}