# NaSch-Sim
This code is a small implementation of the basic Nagel-Schreckenberg Modell (NaSch). It does not take into account things like Velocity-Dependend-Randomization or braking lights or parallel execution.

## The Modell itself
NaSch is a modell that predicts how traffic jams can appear for apparently no reason. How it works is described in greater detail on the Wikipedia page: https://de.wikipedia.org/wiki/Nagel-Schreckenberg-Modell. The german page also has a great simple visualization on how the modell works. I used this heavily when implementing this software. 

## How to Run
At the moment I need to clean up some stuff because this is still a work in progress. But if you want to run this yourself you need to have Julia installed (https://julialang.org/downloads/). Also you need to install the packages Plots.jl and Revise.jl. Easiest way is to run the REPL (open CMD/Terminal and type *julia*) and then run:

```julia
using Pkg
Pkg.add("Revise")
Pkg.add("Plots")
```

To run the function open up */scripts/run_simulation.jl* and run the file. This will automatically save a visualization in the */plots* Directory. The parameters you can give are the following and in order:

- road_length::Int  -> how many cells does the road contain
- cars::Int         -> how many cars on randomly placed on the road 
- v_max::Int        -> what is the maximum speed
- p_slow::Float64   -> how likely do cars randomly slow down
- steps::Int        -> how often does the simulation run

Already in the plots directory are 4 simple plots. The names follow the order of parameters that the algorithm was run with. 

## Open Points:
- add better checks for data consistency
- maybe minor performance/readability improvements 
- make module structure easier for end user/include a how to run
- make README not s*ck