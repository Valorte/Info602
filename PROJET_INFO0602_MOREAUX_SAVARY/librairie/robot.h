#ifndef ROBOT_H
#define ROBOT_H

#include <stdio.h>

typedef struct robot_type {
    int x;
    int y;
    int direction;
} robot_t;

void initialiser_robot(robot_t* robot);

#endif