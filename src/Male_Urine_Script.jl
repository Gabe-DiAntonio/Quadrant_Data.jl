using Quadrant_Data
#male urine
center = [310, 265]

filename = "C:\\Users\\diant\\OneDrive\\Documents\\Summer_Project_2021\\Quadrant_Data\\Male_Urine\\0714mouse04trajectories.mat"
quadrantdf = openmatdata(filename, center)
quadcarlo = createquadcarlo(quadrantdf)

quad1total, quad1teststat, quad1pvalue = totaltime(quadcarlo,"quad 1"), testdata(quadcarlo, "quad 1"), calculatepvalue(quadrantdf, "quad 1")
quad2total, quad2teststat, quad2pvalue = totaltime(quadcarlo,"quad 2"), testdata(quadcarlo, "quad 2"), calculatepvalue(quadrantdf, "quad 2")
quad3total, quad3teststat, quad3pvalue = totaltime(quadcarlo,"quad 3"), testdata(quadcarlo, "quad 3"), calculatepvalue(quadrantdf, "quad 3")
quad4total, quad4teststat, quad4pvalue = totaltime(quadcarlo,"quad 4"), testdata(quadcarlo, "quad 4"), calculatepvalue(quadrantdf, "quad 4")

println("Test Results")

println("Quadrant 1: Total Time = $quad1total time steps.   Test Stat = $quad1teststat   p = $quad1pvalue")
println("Quadrant 2: Total Time = $quad2total time steps.   Test Stat = $quad2teststat   p = $quad2pvalue")
println("Quadrant 3: Total Time = $quad3total time steps.   Test Stat = $quad3teststat   p = $quad3pvalue")
println("Quadrant 4: Total Time = $quad4total time steps.   Test Stat = $quad4teststat   p = $quad4pvalue")

if(quad1pvalue < 0.05)
  if(quad1teststat > 0)
    println("The mouse shows a statistically significant bias towards quadrant 1")
  else
    println("The mouse shows a statistically significant bias away from quadrant 1")
  end
end

if(quad2pvalue < 0.05)
  if(quad2teststat > 0)
    println("The mouse shows a statistically significant bias towards quadrant 2")
  else
    println("The mouse shows a statistically significant bias away from quadrant 2")
  end
end

if(quad3pvalue < 0.05)
  if(quad3teststat > 0)
    println("The mouse shows a statistically significant bias towards quadrant 3")
  else
    println("The mouse shows a statistically significant bias away from quadrant 3")
  end
end

if(quad4pvalue < 0.05)
  if(quad4teststat > 0)
    println("The mouse shows a statistically significant bias towards quadrant 4")
  else
    println("The mouse shows a statistically significant bias away from quadrant 4")
  end
end

if(quad1pvalue > 0.05 && quad2pvalue > 0.05 && quad3pvalue > 0.05 && quad4pvalue > 0.05)
  println("The mouse shows no statistically significant bias towards any quadrant")
end