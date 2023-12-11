#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.12.2023r.

include("interpolation.jl")
using .Interpolation
using Plots

f = x -> abs(x)
g = x -> 1 / (1 + x^2)

for n in [5, 10, 15]
  plot_f = plotNnfx(f, -1.0, 1.0, n)
  plot_g = plotNnfx(g, -5.0, 5.0, n)
  savefig(plot_f, "./images/zad_6_f1_$n.png")
  savefig(plot_g, "./images/zad_6_f2_$n.png")
end