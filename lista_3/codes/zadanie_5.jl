include("./find_zero_place.jl")

using .fzp


function func(x)
    exp(x) - 3x
end

# delta
d = 10^(-4)
# epsilon
e = 10^(-4)

println("\nMetoda Bisekcji dla przedzialu poczatkowego (0.0, 1.0):")
println(bisection(func, 0.0, 1.0, d, e))
println("\nMetoda Bisekcji dla przedzialu poczatkowego (1.0, 2.0):")
println(bisection(func, 1.0, 2.0, d, e))