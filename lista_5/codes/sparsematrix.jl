#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#08.01.2024r.

module sparsematrixModule
export  SparseMatrix, get_sparsematrix,
        columns_range, first_column, last_column,
        rows_range, first_row, last_row

using SparseArrays

mutable struct SparseMatrix
    matrix::SparseMatrixCSC{Float64, Int}
    size::Int
    block_size::Int
    blocks_number::Int
    operation_count::Int
end

function Base.getindex(M::SparseMatrix, i::Int, j::Int)
    M.operation_count += 1
    return M.matrix[i, j]
end

function Base.setindex!(M::SparseMatrix, value::Float64, i::Int, j::Int)
    M.matrix[i, j] = value
end

function Base.:*(M::SparseMatrix, V::Vector{Float64})
    if length(V) != M.size
        error("Input size error!")
    end
    result = zeros(Float64, M.size)
    for i in 1:M.size
        for j in columns_range(M, i)
            result[i] += V[j] * M[i, j]
        end
    end
    return result
end

function get_sparsematrix(size::Int, block_size::Int, Vs::Vector{Tuple{Int, Int, Float64}})
    M = get_sparsematrix(size, block_size)
    for (i, j, v) in Vs
        M[i, j] = v
    end
    return M
end

function get_sparsematrix(size::Int, block_size::Int)
    block_no = Int(size / block_size)
    A = spzeros(size, size)
    return SparseMatrix(A, size, block_size, block_no, 0)
end

function create_SparseMatrix(size::Int, block_size::Int)
    blocks_number = Int(size / block_size)
    matrix = spzeros(size, size)
    return SparseMatrix(matrix, size, block_size, blocks_number, 0)
end

function columns_range(matrix::SparseMatrix, row::Int)
    return first_column(matrix, row) : last_column(matrix, row)
end

function first_column(matrix::SparseMatrix, row::Int)
    return max(1, row - ((row - 1) % matrix.block_size) - 1)
end

function last_column(matrix::SparseMatrix, row::Int)
    return min(matrix.size, matrix.block_size + row)
end

function rows_range(matrix::SparseMatrix, column::Int)
    return first_row(matrix, column) : last_row(matrix, column)
end

function first_row(matrix::SparseMatrix, column::Int)
    return max(1, column - matrix.block_size)
end

function last_row(matrix::SparseMatrix, column::Int)
    return min(matrix.size, column + matrix.block_size - (column % matrix.block_size))
end

end
