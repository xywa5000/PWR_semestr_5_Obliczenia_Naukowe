include("./find_zero_place.jl")

using Test
using .fzp

# Testy dla metody bisekcji
@testset "Bisection Method Tests" begin
    @test bisect(x -> x^4 - 4*x^2 + 1, -3.0, -1.0, 0.01, 0.01)[1] ≈ -1.9375 atol=0.01
    @test bisect(x -> cos(x), 0.0, 2.0, 0.01, 0.01)[1] ≈ π/2 atol=0.01
end

# Testy dla metody Newtona
@testset "Newton's Method Tests " begin
    @test newton(x -> x^2 - 4, x -> 2x, 3.0, 0.01, 0.01, 100)[1] ≈ 2.0 atol=0.01
    @test newton(x -> cos(x), x -> -sin(x), 1.0, 0.01, 0.01, 100)[1] ≈ π/2 atol=0.01
end

# Testy dla metody siecznych
@testset "Secant Method Tests   " begin
    @test secant(x -> x^2 - 4, 1.0, 3.0, 0.01, 0.01, 10)[1] ≈ 2.0 atol=0.01
    @test secant(x -> cos(x), 1.0, 2.0, 0.01, 0.01, 10)[1] ≈ π/2 atol=0.01
end
