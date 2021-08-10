
filter((x) -> length(x) >= row, trial)

for x in 1:length(quadrantdf[:, 1])
    if quadrantdf[x, 3] == "quad 1"
        push!(quad1, quadrantdf[x, :])        
    elseif quadrantdf[x, 3] == "quad 2"
        push!(quad2, quadrantdf[x, :])       
    elseif quadrantdf[x, 3] == "quad 3"
        push!(quad3, quadrantdf[x, :])
    elseif quadrantdf[x, 3] == "quad 4"
        push!(quad4, quadrantdf[x, :])
    else 
    end
end