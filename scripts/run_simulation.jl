using Revise
includet("../src/NaSch.jl") 
using .NaSch

params= Simulation_Parameters(150,50,5,0.2,1000)
end_pos, history = run_simulation(params)
println(end_pos)
