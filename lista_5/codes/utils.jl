#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#08.01.2024r.

include("blocksys.jl")
module utilsModule
export read_matrix, read_matrix_as_sparse, read_vector, write_x

using SparseArrays
using LinearAlgebra
using Main.sparsematrixModule

"""
Function reading a matrix from a file.

# Parameters
filename - name of the file

# Results
A - SparseMatrix
"""

function read_matrix(filename::String)
    open(filename) do f
        params = split(readline(f))
        size = parse(Int, params[1])
        block_size = parse(Int, params[2])
        A = get_sparsematrix(size, block_size)
        while !eof(f)
            line = split(readline(f))
            i = parse(Int, line[1])
            j = parse(Int, line[2])
            v = parse(Float64, line[3])
            A[i, j] = v
        end
        return A
    end
end

"""
Function reading a vector from a file.

# Parameters
filename - name of the file

# Results
b - vector of Floats64
"""

function read_vector(filename::String)
    open(filename) do f
        n = parse(Int, readline(f))
        b = zeros(n)
        for i in 1:n
            b[i] = parse(Float64, readline(f))
        end
        return b
    end
end

"""
Function writing a vector from to file.

# Parameters
filename - name of the file
"""

function write_x(filename::String, X::Vector{Float64}, target_x::Union{Nothing, Vector{Float64}})
    open(filename, "w") do f
        if target_x !== nothing
            error = norm(X - target_x) / norm(target_x)
            write(f, "$error\n")
        end
        for x in X
            write(f, "$x\n")
        end
    end
end

end
