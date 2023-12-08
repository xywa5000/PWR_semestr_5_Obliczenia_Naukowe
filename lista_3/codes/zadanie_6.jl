include("./find_zero_place.jl")

using .fzp

function func_1(x)
    exp(1-x) - 1
end

function d_func_1(x)
    -exp(1-x)
end

function func_2(x)
    x*exp(-x)
end

function d_func_2(x)
    -exp(-x)*(x-1)
end

# delta
d = 10^(-5)
# epsilon
e = 10^(-5)

println("\nMetoda Bisekcji:")
println(bisection(func_1, 0.2, 2.0, d, e))
println(bisection(func_2, -0.8, 1.0, d, e))

println("\nMetoda Newtona:")
println(newton(func_1, d_func_1, 0.1, d, e, 100))
println(newton(func_2, d_func_2, -1.1, d, e, 100))

println("\nMetoda Siecznych:")
println(secant(func_1, 0.2, 2.0, d, e, 100))
println(secant(func_2, -0.8, 1.0, d, e, 100))

println("\nMetoda Newtona (skrajne przypadki):")
println(newton(func_1, d_func_1, 10.0, d, e, 100))
println(newton(func_1, d_func_1, 100.0, d, e, 100))
println(newton(func_2, d_func_2, 10.0, d, e, 100))
println(newton(func_2, d_func_2, 100.0, d, e, 100))
println(newton(func_2, d_func_2, 1.0, d, e, 100))