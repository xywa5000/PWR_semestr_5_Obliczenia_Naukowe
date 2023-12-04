#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.11.2023r.

using Polynomials

# Wielomian Wilkinsona z zadnia + inicjalizacja zmiennych
coefficients::Vector{Float64} = [1, -210.0, 20615.0,-1256850.0,53327946.0,-1672280820.0,40171771630.0,-756111184500.0,11310276995381.0,-135585182899530.0,1307535010540395.0,-10142299865511450.0,63030812099294896.0,-311333643161390640.0,1206647803780373360.0,-3599979517947607200.0,8037811822645051776.0,-12870931245150988800.0,13803759753640704000.0,-8752948036761600000.0,2432902008176640000.0]
exactroots::Vector{Float64} = [Float64(i) for i in 1:20]

wilkinson_norm::Polynomial{Float64,:x} = Polynomial(reverse(coefficients))
wilkinson_mult::Polynomial{Float64,:x} = fromroots(exactroots)
wilkinson_roots::Vector{Float64} = roots(wilkinson_norm)

root::Float64 = zero(Float64)
norm::Float64 = zero(Float64)
mult::Float64 = zero(Float64)
sub::Float64 = zero(Float64)

# Wielomian bez zniekształcenia - 20 iteracji dla 20 miejsc zerowych
println("Wilkinson polynomial test without distraction:")
println("| k | z_k | P(z_k) | p(z_k) | z_k - k |")
println("|---|-----|--------|--------|---------|")

for k in 1:20
    root = wilkinson_roots[k]
    norm = abs(wilkinson_norm(root))
    mult = abs(wilkinson_mult(root))
    sub = abs(root - k)

    print("| $k\t| $root\t| $norm\t| $mult\t| $sub|\n")
end

print("________________________________________________________________________\n\n")

# Wielomian ze zniekształceniem - 20 iteracji dla 20 miejsc zerowych
println("Wilkinson polynomial test with distraction:")
println("| k | z_k | P(z_k) | p(z_k) | z_k - k |")
println("|---|-----|--------|--------|---------|")

# Zniekształcenie
coefficients[2] -= 2^(-23)

wilkinson_norm_distracted::Polynomial{Float64,:x} = Polynomial(reverse(coefficients))
wilkinson_roots_distracted::Vector{ComplexF64} = roots(wilkinson_norm_distracted)
root_distracted::ComplexF64 = zero(ComplexF64)

for k in 1:20
    root_distracted = wilkinson_roots_distracted[k]
    norm = abs(wilkinson_norm_distracted(root_distracted))
    mult = abs(wilkinson_mult(root_distracted))
    sub = abs(root_distracted - k)

    print("| $k\t| $root_distracted\t| $norm\t| $mult\t| $sub|\n")
end