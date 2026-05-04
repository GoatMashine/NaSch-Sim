# NaSch-Sim
This code is a small implementation of the basic Nagel-Schreckenberg Modell (NaSch). It does not take into account things like Velocity-Dependend-Randomization or braking lights or parallel execution.

## The Modell itself
NaSch is a cellular automata. Thats a fancy way of saying we are looking at a 
grid of "cells". Each cell can contain some state from a finite list of possible states. 

In my implementation I use a one dimensional grid that represents a road. This road then contains cars, identified by their speed or empty spaces. To initialize my implementation I am looking at the following parameters:

- road_length -> This tells the programm how long the array is
- cars -> Sets the amount of cars that are placed on the array
- v_max -> The maximum Speed a car can have at any time
- p_slow -> How likely a car is to randomly slow down
- steps -> The amount of time the simulation is run

NaSch contains 4 simple steps that are as follows that all loop once over every car:

### Step 1:
If a car is not yet at v_max then the speed will increase by 1.

### Step 2:
Check how much space is ahead, if the space ahead is smaller then the current speed reduce the current speed to the gap.

### Step 3:
There is always a random chance that a car will slow down for no apparent reason, this will simulate this. A basic checks that slows down a given car by 1 if the random check is passed.

### Step 4:
Move the cars according to their speed value. If a car has speed 4 then it will move 4 spaces in this pass of the modell.

## Open Points:
- add a history and plots
- add better checks for data consistency
- maybe minor performance/readability improvements 
- make module structure easier for end user/include a how to run
- make README not s*ck