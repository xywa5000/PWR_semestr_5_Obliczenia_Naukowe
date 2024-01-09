#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#08.01.2024r.

include("utils.jl")
include("matrixgen.jl")
using .matrixgen
using .blocksys
using .utilsModule
using Plots

sizes = [1000, 2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000, 22500, 25000, 27500, 30000]
test_number = length(sizes)
block_size = 10

function classic_algorythm(A, b)
    return Array(A.matrix)\b
end

struct Solution
    func::Function
    times::Vector{Float64}
    ops::Vector{Int}
    memory::Vector{Int}
end

results = [
    Solution(f, zeros(Float64, test_number), zeros(Int, test_number), zeros(Int, test_number)) 
    for f in [classic_algorythm, gauss_method, gauss_method_pivot, lu_method, lu_method_pivot]
]


for (i, size) in enumerate(sizes)
    blockmat(size, block_size, 10., "tmp.txt")
    A = read_matrix("tmp.txt")
    b = generate_rhs(A)
    for S in results
        tempA = deepcopy(A)
        tempb = deepcopy(b)
        stats = @timed S.func(tempA, tempb)
        println("$size $(stats.time) $(tempA.operation_count) $(stats.bytes)")
      
        S.times[i] = stats.time
        S.ops[i] = tempA.operation_count
        S.memory[i] = stats.bytes
       
    end
end

plot(
    sizes, 
    [S.times for S in results], 
    title="Time complexity of algorithms", 
    legend=:topleft,
    label=["Classic algorithm" "Gauss" "Pivot Gauss" "LU" "Pivot LU"]
)
xlabel!("matrix size")
ylabel!("time (s)")
savefig("images/times_all.png")

plot(
    sizes, 
    [results[k].times for k in 2:length(results)], 
    title="Time complexity of algorithms", 
    legend=:topleft,
    label=["Gauss" "Pivot Gauss" "LU" "Pivot LU"]
)
xlabel!("matrix size")
ylabel!("time (s)")
savefig("images/times_part.png")

plot(
    sizes, 
    [results[k].ops for k in 2:length(results)], 
    title="Time complexity of algorithms", 
    legend=:topleft,
    label=["Gauss" "Pivot Gauss" "LU" "Pivot LU"]
)
xlabel!("matrix size")
ylabel!("number of operations")
savefig("images/operations.png")

plot(
    sizes, 
    [S.memory for S in results], 
    title="Memory usage", 
    legend=:topleft,
    label=["Classic algorithm" "Gauss" "Pivot Gauss" "LU" "Pivot LU"]
)
xlabel!("matrix size")
ylabel!("memory usage (B)")
savefig("images/memory_all.png")

plot(
    sizes, 
    [results[k].memory for k in 2:length(results)], 
    title="Memory usage",
    legend=:topleft,
    label=["Gauss" "Pivot Gauss" "LU" "Pivot LU"]
)
xlabel!("matrix size")
ylabel!("memory usage (B)")
savefig("images/memory_part.png")

rm("tmp.txt")