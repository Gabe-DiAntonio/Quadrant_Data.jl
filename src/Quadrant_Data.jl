module Quadrant_Data
using MAT
using Plots
using DataFrames
using StatsBase

export calculatepvalue
export openmatdata
export midpoint
export totaltime
export testdata
export createquadcarlo

include("utils.jl")
# Write your package code here.

### Currently Needs F and G to be defined ###
function midpoint(pos1, pos2)
    x = (pos1[1] + pos2[1])/2
    y = (pos1[2]+pos2[2])/2
    return [x, y]
end
 
 function slope(pos1, pos2)
   m = (pos1[2]-pos2[2])/(pos1[1]-pos1[1])
   return m
end 

function openmatdata(file_name, center)
    file = matread(file_name)
    file = file["trajectories"]
    quadrantdf = DataFrame(x = file[:,1,1], y = file[:,1,2])
    filter!(isfinite ∘ sum, quadrantdf)
    array = quadrantarray(quadrantdf, center)
    quadrantdf[!, :quadrant] = array
    return quadrantdf
end
  
function quadrantarray(dataframe, center)
    array = []
    for z in 1:length(dataframe[!,1])
        if(dataframe[z,1] > center[1] && dataframe[z,2] > center[2])
            push!(array, "quad 1")
        elseif(dataframe[z,1] <= center[1] && dataframe[z,2] > center[2])
            push!(array, "quad 2")
        elseif(dataframe[z,1] <= center[1] && dataframe[z,2] <= center[2])
            push!(array, "quad 3")
        elseif(dataframe[z,1] > center[1] && dataframe[z,2] <= center[2])
            push!(array, "quad 4")
        else
            throw(DomainError("Not in a Quadrant"))
        end
    end
    return array
end
    
function createquadcarlo(dataframe) #creates a data frame with the time spent in each quadrant before moving to the next quadrant
    quadcarlo = DataFrame(quadrant = String[], time = Float64[])   
    current = 0
    previous = dataframe[1,3] 
    time = 0
    for z in 1:length(dataframe[!,1])
        current = dataframe[z,3]
        if current == previous
            time = time + 1
        else 
            push!(quadcarlo, (previous, time))
            time = 1
        end
        previous = dataframe[z,3]
    end  
    push!(quadcarlo, (previous, time))
    return quadcarlo
end
      
function randomizequadcarlo(dataframe)  #randomizes the amount of time spent in each quadrant
    randorder = sample(1:nrow(dataframe), nrow(dataframe), replace = false)
    temp = DataFrame(time = dataframe[!,2], randorder = randorder)
    sort!(temp, 2)
    randquadcarlo = DataFrame(quadrant = dataframe[!,1], time = temp[!,1])
    return randquadcarlo
end
    
function testdata(quadcarlo, quad) #looks at a dataframe and returns a test statistic based on difference between the overall average and the chosen quadrant's average
    quad1, quad2, quad3, quad4 = groupby(quadcarlo, [:quadrant], sort = true)    
    quad1sum, quad2sum, quad3sum, quad4sum = sum(quad1[!,2]), sum(quad2[!,2]), sum(quad3[!,2]), sum(quad4[!,2])
    if(quad=="quad 1")
        teststat = quad1sum - (quad1sum + quad2sum + quad3sum + quad4sum)/4
    elseif(quad=="quad 2")
        teststat = quad2sum - (quad1sum + quad2sum + quad3sum + quad4sum)/4
    elseif(quad=="quad 3")
        teststat = quad3sum - (quad1sum + quad2sum + quad3sum + quad4sum)/4
    elseif(quad=="quad 4")
        teststat = quad4sum - (quad1sum + quad2sum + quad3sum + quad4sum)/4
    else
        throw(DomainError("Invalid Quadrant"))
    end
    return teststat
end
  
function createdist(quadcarlo, quad)  #creates a 10000 point distribution random test statistics for a certain quadrant
    distribution = []
    for z in 1:10000
        randquadcarlo = randomizequadcarlo(quadcarlo)
        push!(distribution, testdata(randquadcarlo, quad))
    end
    return distribution
end      
  
function totaltime(quadcarlo, quad) #looks at a dataframe and returns the total time spent in a specified quadrant
    quad1, quad2, quad3, quad4 = groupby(quadcarlo, [:quadrant], sort = true)    
    quad1sum, quad2sum, quad3sum, quad4sum = sum(quad1[!,2]), sum(quad2[!,2]), sum(quad3[!,2]), sum(quad4[!,2])
    if(quad=="quad 1")
        return quad1sum
    elseif(quad=="quad 2")
        return quad2sum
    elseif(quad=="quad 3")
        return quad3sum
    elseif(quad=="quad 4")
        return quad4sum
    else
        throw(DomainError("Invalid Quadrant"))
    end
end

function calculatepvalue(quadrantdf, quad)
    quadcarlo = createquadcarlo(quadrantdf)
    expvalue = testdata(quadcarlo, quad)    
    dist = createdist(quadcarlo, quad)   
    function twosided(x)
        if(x > 0) 
            return x >= abs(expvalue)
        elseif(x <= 0)
            return abs(x) >= abs(expvalue)    
        else
            throw(DomainError("Not a valid input"))  
        end
    end
    expormore = filter(twosided, dist) 
    pvalue = length(expormore)/length(dist)      
    return pvalue
end

end
