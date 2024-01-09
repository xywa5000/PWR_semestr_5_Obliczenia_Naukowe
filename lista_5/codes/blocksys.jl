#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#08.01.2024r.

include("sparsematrix.jl")
module blocksys
export  generate_rhs,
        gauss_method, 
        gauss_method_pivot, 
        lu_generate, lu_solver, lu_method, 
        lu_generate_pivot, lu_solver_pivot, lu_method_pivot

using Main.sparsematrixModule

"""
Function determining the right-hand side vector for the given matrix A, assuming that the solution vector x consists solely of ones.

# Parameters
A – coefficient matrix of size n×n with non-zero (sufficiently large) elements on the diagonal, following the structure described in the documentation

# Returns
b – right-hand side vector of length n
"""

function generate_rhs(A::SparseMatrix)
    b = zeros(Float64, A.size)
    for i in 1:A.size
        for j in columns_range(A, i)
            b[i] += A[i, j]
        end
    end
    return b
end

"""
Function solving a system of equations in the form described in the documentation using the Gaussian elimination method.

# Parameters
A – coefficient matrix of size n×n with non-zero (sufficiently large) elements on the diagonal, following the structure described in the documentation

b – right-hand side vector of length n

# Returns
x – solution vector of length n
"""

function gauss_method(A::SparseMatrix, b::Vector{Float64})
    n = A.size
    
    for k in 1:n-1
        for i in k+1:last_row(A, k)
            try
                m = A[i, k] / A[k, k]
                A[i, k] = 0.0

                for j in k+1:last_column(A, k)
                    A[i, j] -= m * A[k, j]
                end

                b[i] -= m * b[k]

            catch err
                error("Zero value on the diagonal of A at index ($k, $k)")

            end            
        end
    end

    x = zeros(n)
    x[n] = b[n] / A[n, n]
    for i in n-1:-1:1
        x[i] = b[i]
        for j in i+1:last_column(A, i)
            x[i] -= A[i, j] * x[j]
        end
        x[i] /= A[i, i]
    end
    return x
end

"""
Function solving a system of equations in the form described in the documentation using the Gaussian elimination method with partial pivoting.

# Parameters
A – coefficient matrix of size n×n with non-zero (sufficiently large) elements on the diagonal, following the structure described in the documentation

b – right-hand side vector of length n

# Returns
x – solution vector of length n
"""

function gauss_method_pivot(A::SparseMatrix, b::Vector{Float64})
    n = A.size
    p = [1:n;]

    for k in 1:n-1
        bound = last_row(A, k)
        j = reduce((x, y) -> abs(A[p[x], k]) >= abs(A[p[y], k]) ? x : y, k:bound)
        p[k], p[j] = p[j], p[k]

        for i in k+1:bound
            z = A[p[i], k] / A[p[k], k]
            A[p[i], k] = 0.0

            for j in k+1:last_column(A, k + A.block_size)
                A[p[i], j] -= z * A[p[k], j]
            end

            b[p[i]] -= z * b[p[k]]
        end
    end

    x = zeros(n)
    x[n] = b[p[n]] / A[p[n], n]

    for i in n-1:-1:1
        x[i] = b[p[i]]

        for j in i+1:last_column(A, i + A.block_size)
            x[i] -= A[p[i], j] * x[j]
        end

        x[i] /= A[p[i], i]
    end

    return x
end

"""
Function determining the LU decomposition for the given coefficient matrix.

# Parameters
A – coefficient matrix following the structure described in the documentation (subject to changes)
"""

function lu_generate(A::SparseMatrix)
    n = A.size

    for k in 1:n-1
        for i in k+1:last_row(A, k)
            try
                m = A[i, k] / A[k, k]
                A[i, k] = m

                for j in k+1:last_column(A, k)
                    A[i, j] -= m * A[k, j]
                end

            catch err
                error("Zero value on the diagonal of A at index ($k, $k)")

            end            
        end
    end
end

"""
Function solving the system of equations for the given right-hand side vector and LU decomposition of the coefficient matrix.

# Parameters
LU – LU decomposition of matrix A as a single matrix of size n×n in the form described in the documentation, where below the diagonal is L, and above is U

b – right-hand side vector of length n (subject to changes)

# Results
x – solution vector of length n
"""

function lu_solver(LU::SparseMatrix, b::Vector{Float64})
    n = LU.size

    for i in 2:n
        for j in first_column(LU, i):i-1
            b[i] -= LU[i, j] * b[j]
        end
    end

    x = zeros(n)
    x[n] = b[n] / LU[n, n]

    for i in n-1:-1:1
        x[i] = b[i]

        for j in i+1:last_column(LU, i + LU.block_size)
            x[i] -= LU[i, j] * x[j]
        end

        x[i] /= LU[i, i]
    end

    return x
end

"""
Function solving the system of equations for the given LU decomposition, following the description provided in the documentation.

# Parameters
A – coefficient matrix of size n×n as described in the documentation

b – right-hand side vector of length n

# Results
x – solution vector of length n
"""

function lu_method(A, b)
    lu_generate(A)
    return lu_solver(A, b)
end

"""
Function computing the LU decomposition with partial pivoting for the given coefficient matrix, following the description provided in the documentation.

# Parameters
A – coefficient matrix as described in the documentation (subject to changes)

# Results
p – permutation vector
"""

function lu_generate_pivot(A::SparseMatrix)
    n = A.size
    p = [1:n;]

    for k in 1:n-1
        bound = last_row(A, k)
        j = reduce((x, y) -> abs(A[p[x], k]) >= abs(A[p[y], k]) ? x : y, k:bound)
        p[k], p[j] = p[j], p[k]

        for i in k+1:bound
            z = A[p[i], k] / A[p[k], k]
            A[p[i], k] = z

            for j in k+1:last_column(A, k + A.block_size)
                A[p[i], j] -= z * A[p[k], j]
            end
        end
    end

    return p
end

"""
Function solving a system of equations for the given right-hand side vector and LU decomposition of the coefficient matrix row,
with the permutation vector obtained during the generation of the decomposition with partial pivoting.

# Parameters
LU – LU decomposition of matrix A as one matrix of size n×n, following the description provided, where L is below the diagonal and U is above

P – permutation vector of length n

b – right-hand side vector of length n (subject to changes)

# Results
x – solution vector of length n
"""

function lu_solver_pivot(LU::SparseMatrix, P::Vector{Int}, b::Vector{Float64})
    n = LU.size

    for i in 2:n
        for j in first_column(LU, P[i]):i-1
            b[P[i]] -= LU[P[i], j] * b[P[j]]
        end
    end

    x = zeros(n)
    x[n] = b[P[n]] / LU[P[n], n]

    for i in n-1:-1:1
        x[i] = b[P[i]]

        for j in i+1:last_column(LU, i + LU.block_size)
            x[i] -= LU[P[i], j] * x[j]
        end

        x[i] /= LU[P[i], i]
    end

    return x
end

"""
Function solving a system of equations for the given right-hand side vector using LU decomposition and partial pivoting.

# Parameters
A – coefficient matrix of size n×n following the description provided

b – right-hand side vector of length n

# Results
x – solution vector of length n
"""

function lu_method_pivot(A, b)
    P = lu_generate_pivot(A)
    return lu_solver_pivot(A, P, b)
end

end
