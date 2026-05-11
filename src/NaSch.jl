module NaSch
using Random
using Plots


export Simulation_Parameters, run_simulation

struct Simulation_Parameters
    road_length::Int
    cars::Int  
    v_max::Int
    p_slow::Float64
    steps::Int
end

function run_simulation(params::Simulation_Parameters)
    history = []
    road = initialize_road(params)
    step!(road, params, history)
    return road, history
end

function initialize_road(params::Simulation_Parameters)
    road = fill(-1, params.road_length)
    car_positions = randperm(params.road_length)[1:params.cars]

    for pos in car_positions
        road[pos] = 0 
    end
    
    return road
end

function step!(road::Vector{Int}, params::Simulation_Parameters, history::Vector)
    steps = params.steps
    history_array = history
    while steps > 0

        for i in eachindex(road)        # Step 1
            if road[i] < params.v_max && road[i] != -1
                road[i] += 1
            end
        end

        for i in eachindex(road)        # Step 2
            if road[i] != -1
                road[i] = min(find_gap(i, road, params), road[i])
            end     
        end        

        for i in eachindex(road)        # Step 3
            if rand() < params.p_slow && road[i] > 0
                road[i] -= 1
            end
        end         
        new_road = fill(-1, params.road_length)
        for i in eachindex(road)        # Step 4
            if road[i] != -1
                new_road[mod1(i + road[i], params.road_length)] = road[i]
            end    
        end
        road .= new_road
        push!(history_array, copy(road))
        steps -=1      
    end    
    visualize_history(history_array)
    return road, history_array
end

function find_gap(position::Int, road::Vector{Int}, params::Simulation_Parameters)
    steps_ahead = 1
    while true
        checked_position = mod1(position + steps_ahead, params.road_length)
        if road[checked_position] != -1
            return steps_ahead - 1
        end
        if steps_ahead >= params.road_length
            return params.road_length - 1
        end
        steps_ahead += 1
    end
end    

function visualize_history(history::Vector)
    xs = Int[]      # timestep
    ys = Int[]      # position/index
    colors = Symbol[]

    for t in eachindex(history)
        road = history[t]

        for i in eachindex(road)
            v = road[i]

            if v == -1
                continue
            end

            push!(xs, t)
            push!(ys, i)
            push!(colors, v == 0 ? :red : :blue)
        end
    end

    p = scatter(
        xs,
        ys,
        markercolor = colors,
        markerstrokewidth = 0,
        markersize = 1.5,
        legend = false,
        xlabel = "time step",
        ylabel = "road index",
        xlims = (1, length(history)),
        ylims = (1, length(history[1])),
        size = (1600, 300),
        dpi = 800,
    )
    savefig(p, "./plots/150_50_5_02_1000.png")
end    

end