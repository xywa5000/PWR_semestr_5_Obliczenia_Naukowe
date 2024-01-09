#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#08.01.2024r.

include("utils.jl")
include("matrixgen.jl")
include("sparsematrix.jl")
using .matrixgen
using .blocksys
using .utilsModule
using .sparsematrixModule
using Test
using Random

blockmat(1000, 10, 10.0, "tmp.txt")
A = read_matrix("tmp.txt")
x = ones(Float64, A.size)
b = generate_rhs(A)

@testset "$(rpad("gauss_method", 10))" begin
    @test isapprox(gauss_method(deepcopy(A), deepcopy(b)), x)
end

@testset "$(rpad("gauss_method_pivot", 10))" begin
    @test isapprox(gauss_method_pivot(deepcopy(A), deepcopy(b)), x)
end

@testset "$(rpad("lu_method", 10))" begin
    @test isapprox(lu_method(deepcopy(A), deepcopy(b)), x)
end

@testset "$(rpad("lu_generate_pivot", 10))" begin
    @test isapprox(lu_method_pivot(deepcopy(A), deepcopy(b)), x)
end

rm("tmp.txt")