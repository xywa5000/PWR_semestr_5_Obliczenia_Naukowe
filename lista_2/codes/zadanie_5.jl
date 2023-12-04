#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.11.2023r.

# wartości początkowe
p1 = Float32(0.01)
p3 = Float64(0.01)
r = 3

# funkcja obliczająca następny wyraz
next(p) = p + r * p * (1 - p)

println(" | ", rpad("n", 3),
        " | ", rpad("Float32", 20),
        " | ", rpad("Float32 z obcięciem", 20),
        " | ", rpad("Float64", 25),
        " |")
for n in 0:9
        println(" | ", rpad(n, 3),
                " | ", rpad(p1, 20),
                " | ", rpad(p1, 20),
                " | ", rpad(p3, 25),
                " |")
        global p1 = next(p1)
        global p3 = next(p3)
end

p2 = Float32(0.722) # p2 ucięcie

for n in 10:40
        println(" | ", rpad(n, 3),
                " | ", rpad(p1, 20),
                " | ", rpad(p2, 20),
                " | ", rpad(p3, 25),
                " |")
        global p1 = next(p1)
        global p2 = next(p2)
        global p3 = next(p3)
end