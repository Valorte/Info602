ARGUMENTS = plateau.json code.txt
SORTIE = code.c
EXECUTABLE = prog

prog : y.tab.o lex.yy.o ncurses.o liste.o cellule.o plateau.o robot.o
	gcc -o prog y.tab.o lex.yy.o ncurses.o liste.o cellule.o plateau.o robot.o -lm -lfl -lncurses

y.tab.o : y.tab.h y.tab.c
	gcc -c y.tab.c

y.tab.c y.tab.h : analyse.yacc.y
	yacc -vd analyse.yacc.y

lex.yy.o : lex.yy.c y.tab.h
	gcc -c lex.yy.c

lex.yy.c : analyse.lex
	flex analyse.lex

ncurses.o : librairie/ncurses.h librairie/ncurses.c
	gcc -c -g librairie/ncurses.c

liste.o : librairie/liste.h librairie/liste.c
	gcc -c -g librairie/liste.c

cellule.o : librairie/cellule.h librairie/cellule.c
	gcc -c -g librairie/cellule.c

plateau.o : librairie/plateau.h librairie/plateau.c
	gcc -c -g librairie/plateau.c

robot.o : librairie/robot.h librairie/robot.c
	gcc -c -g librairie/robot.c

clean:
	rm -f y.tab.*
	rm -f lex.yy.*
	rm -f ncurses.o
	rm -f plateau.o
	rm -f robot.o
	rm -f cellule.o
	rm -f liste.o
	rm -f prog prog.exe
	rm -f *~
	rm -f *.stackdump