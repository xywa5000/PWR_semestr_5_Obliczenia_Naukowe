#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.11.2023r.

using Plots

func(x)::Float64 = exp(Float64(x)) * log(Float64(1.0) + exp(Float64(-x)))
funcplot = plot(func, title="f(x) = e^x * ln(1 + e^-x)", label="f(x)", xlims=(0.0, 50.0), xticks=0.0:5.0:50.0, ylims=(0.0, 2.0), linecolor=:blue, lw=2)
Plots.png(funcplot, "zad2_jl.png")