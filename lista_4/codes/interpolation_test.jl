#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.12.2023r.

include("interpolation.jl")
using .Interpolation
using Plots
using Test

@testset "Z_5_L_4_2" begin
  x::Vector{Float64} = [-1.0, 0.0, 1.0, 2.0]
  f::Vector{Float64} = [2.0, 1.0, 2.0, -7.0]
  fx::Vector{Float64} = differencesQuotients(x, f)
  @test fx == [2.0, -1.0, 1.0, -2.0]
  @test NewtonPolynomial(x, fx, -1.0) == 2.0
  @test NewtonPolynomial(x, fx, 0.0) == 1.0
  @test NewtonPolynomial(x, fx, 1.0) == 2.0
  @test NewtonPolynomial(x, fx, 2.0) == -7.0
  natural = naturalForm(x, fx)
  @test natural == [1.0, 2.0, 1.0, -2.0]
end

@testset "Z_5_L_4_2" begin
  x::Vector{Float64} = [-1.0, 0.0, 1.0, 2.0, 3.0]
  f::Vector{Float64} = [2.0, 1.0, 2.0, -7.0, 10.0]
  fx::Vector{Float64} = differencesQuotients(x, f)
  @test fx == [2.0, -1.0, 1.0, -2.0, 2.0]
  @test NewtonPolynomial(x, fx, -1.0) == 2.0
  @test NewtonPolynomial(x, fx, 0.0) == 1.0
  @test NewtonPolynomial(x, fx, 1.0) == 2.0
  @test NewtonPolynomial(x, fx, 2.0) == -7.0
  @test NewtonPolynomial(x, fx, 3.0) == 10.0
  natural = naturalForm(x, fx)
  @test natural == [1.0, 6.0, -1.0, -6.0, 2.0]
end
