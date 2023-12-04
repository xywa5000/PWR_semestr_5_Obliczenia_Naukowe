#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.11.2023r.

# Rozwiązanie identyczne jak na liście pierwszej
# Z wyjątkiem zmiany X na X'

function forward(x, y, type)
    sum = type(0.0)
    for i in 1:length(x)
        sum += x[i] * y[i]
    end
    return sum
end

function backward(x, y, type)
    sum = type(0.0)
    for i in length(x):-1:1
        sum += x[i] * y[i]
    end
    return sum
end

function descending_order(x, y)
    p = x .* y
    sum_pos = sum(sort(filter(a -> a > 0, p), rev=true))
    sum_neg = sum(sort(filter(a -> a < 0, p)))
    return sum_pos + sum_neg
end

function ascending_order(x, y)
    p = x .* y
    sum_pos = sum(sort(filter(a -> a > 0, p)))
    sum_neg = sum(sort(filter(a -> a < 0, p), rev=true))
    return sum_pos + sum_neg
end

x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

println("X*Y\n")
for i in [Float32, Float64]
    a = Array{i,1}(x)
    b = Array{i,1}(y)
    println(i)
    println(rpad("Forward: ", 20), forward(a, b, i))
    println(rpad("Backward: ", 20), backward(a, b, i))
    println(rpad("Descending_order: ", 20), descending_order(a, b))
    println(rpad("Ascending_order: ", 20), ascending_order(a, b), '\n')
end

x = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]

println("X'*Y\n")
for i in [Float32, Float64]
    a = Array{i,1}(x)
    b = Array{i,1}(y)
    println(i)
    println(rpad("Forward: ", 20), forward(a, b, i))
    println(rpad("Backward: ", 20), backward(a, b, i))
    println(rpad("Descending_order: ", 20), descending_order(a, b))
    println(rpad("Ascending_order: ", 20), ascending_order(a, b), '\n')
end