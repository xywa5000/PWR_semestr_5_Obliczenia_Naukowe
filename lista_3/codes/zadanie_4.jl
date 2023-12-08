include("./find_zero_place.jl")

using .fzp

function func(x)
    sin(x) - (1/4)x^2
end

function d_func(x)
    cos(x) - (1/2)x
end

# delta
d = (1/2)*10^(-5)
# epsilon
e = (1/2)*10^(-5)

println("\nMetoda Bisekcji:")
println(bisection(func, 1.5, 2.0, d, e))
println("\nMetoda Newtona:")
println(newton(func, d_func, 1.5, d, e, 100))
println("\nMetoda Siecznych:")
println(secant(func, 1.0, 2.0, d, e, 100))