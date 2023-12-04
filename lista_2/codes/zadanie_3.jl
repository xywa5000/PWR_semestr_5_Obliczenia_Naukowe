#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.11.2023r.

using LinearAlgebra

# Pliki podane przez prowadzącego
include("sources/matcond.jl")
include("sources/hilb.jl")


# Metoda eliminacji Gaussa
function gaussmethod(matrix::Matrix{<:AbstractFloat},
    vector::Vector{<:AbstractFloat})::Vector{Float64}
    return matrix \ vector
end

# Metoda odwrotności macierzy
function invmethod(matrix::Matrix{<:AbstractFloat},
    vector::Vector{<:AbstractFloat})::Vector{Float64}
    return inv(matrix) * vector
end

# Błąd względny wyniku
function approxerror(approx::Vector{<:AbstractFloat},
    real::Vector{<:AbstractFloat})::Float64
    return norm(approx - real) / norm(real)
end

# Poniżej wyświetlanie wyników
# Nazwy zmiennych zgodnych z zadaniem

println("Hilbert matrix test:")
println("| size | rank(a) | cond(a) | gauss error | inv error |")
println("|------|---------|---------|-------------|-----------|")

for n in 1:20
    a::Matrix{Float64} = hilb(n)
    x::Vector{Float64} = ones(Float64, n)
    b::Vector{Float64} = a * x

    a_rank::Int = rank(a)
    a_cond::Float64 = cond(a)

    gauss_error::Float64 = approxerror(gaussmethod(a, b), b)
    inv_error::Float64 = approxerror(invmethod(a, b), b)

    print("| $n\t| $a_rank\t| $a_cond\t| $gauss_error\t| $inv_error|\n")
end

print("_______________________________________________________________________\n\n")

println("Random matrix test:")
println("| size | condition | rank(a) | cond(a) | gauss error | inv error |")
println("|------|-----------|---------|---------|-------------|-----------|")

#wartości z zadania
size::Vector{Int} = [5, 10, 20]
con::Vector{Float64} = [1.0, 10.0, 10.0^3.0, 10.0^7.0, 10.0^12.0, 10.0^16.0]

for n in size
    for c in con
        a::Matrix{Float64} = matcond(n, c)
        x::Vector{Float64} = ones(Float64, n)
        b::Vector{Float64} = a * x

        a_rank::Int = rank(a)
        a_cond::Float64 = cond(a)

        gauss_error::Float64 = approxerror(gaussmethod(a, b), b)
        inv_error::Float64 = approxerror(invmethod(a, b), b)

        print("| $n\t| $c\t| $a_rank\t| $a_cond\t| $gauss_error\t| $inv_error|\n")
    end
end