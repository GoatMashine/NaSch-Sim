module NaSch
using Random


export Simulation_Parameters, run_simulation

struct Simulation_Parameters
    road_length::Int
    cars::Int  
    v_max::Int
    p_slow::Float64
    steps::Int
end

function run_simulation(params::Simulation_Parameters)
    road = initialize_road(params)
    step!(road, params)
    return road
end

function initialize_road(params::Simulation_Parameters)
    road = fill(-1, params.road_length)
    car_positions = randperm(params.road_length)[1:params.cars]

    for pos in car_positions
        road[pos] = 0 
    end
    
    return road
end

function step!(road::Vector{Int}, params::Simulation_Parameters)
    steps = params.steps
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
        steps -=1      
    end    
    
    return road
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

end