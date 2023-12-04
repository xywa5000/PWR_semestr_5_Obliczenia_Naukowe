#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.11.2023r.

function next(n::Integer, x::AbstractFloat, c::AbstractFloat)::Float64
    if n == 0
        return x
    end

    xn::Float64 = next(n - 1, x, c)

    return xn^2 + c
end

# Wartości początkowe z zadania
tuples::Vector{Tuple{Float64,Float64}} = [(-2.0, 1.0), (-2.0, 2.0), (-2.0, 1.99999999999999), (-1.0, 1.0), (-1.0, -1.0), (-1.0, 0.75), (-1.0, 0.25)]
result::Float64 = zero(Float64)
c::Float64 = zero(Float64)
x::Float64 = zero(Float64)

for tuple in tuples
    # Kolejne wartości początkowe
    c = tuple[1]
    x = tuple[2]

    print("Results for (c = $c, x = $x):\n")
    print("n; value\n")
    for n in 0:40
        result = next(n, x, c)
        print("$n; $result\n")
    end
    print("_______________________________________________________\n\n")
end