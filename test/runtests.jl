using Quadrant_Data
using Test

@testset "Quadrant_Data.jl" begin
    # Write your tests here.
    xtraj = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    ytraj = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,]
    arraylist = ["quad 1", "quad 2", "quad 2", "quad 3", "quad 4", "quad 2", "quad 2", "quad 1", "quad 2", "quad 2", "quad 3", "quad 3", "quad 3", "quad 4", "quad 2", "quad 2", "quad 2", "quad 1", "quad 1", "quad 2", "quad 2", "quad 2", "quad 2", "quad 4", "quad 1", "quad 3", "quad 4", "quad 2", "quad 2", "quad 3", "quad 1", "quad 2", "quad 2", "quad 3", "quad 2", "quad 1", "quad 2", "quad 3", "quad 2", "quad 4", "quad 2", "quad 4", "quad 2", "quad 2", "quad 2", "quad 2", "quad 2", "quad 2", "quad 1", "quad 3", "quad 4", "quad 2", "quad 2", "quad 2", "quad 2", "quad 2", "quad 1", "quad 2", "quad 4"]
    quadrantdf = DataFrame(x = xtraj, y = ytraj, array = arraylist)
    @test calculatepvalue(quadrantdf, "quad 2") <= 0.05
end
