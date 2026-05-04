using Revise
includet("../src/NaSch.jl") 
using .NaSch

params = Simulation_Parameters(15,4,5,0.2,1000)
run_simulation(params)