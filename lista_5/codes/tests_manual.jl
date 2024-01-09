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

function solver()
    println("\nchoose solution method:")
    println("1 - gauss_method()")
    println("2 - gauss_method_pivot()")
    println("3 - lu_method")
    println("4 - lu_method_pivot")
    solver_type = parse(Int, readline())
    println("\nName of matrix file:")
    matrix_file = readline()
    println("Name of vector file (if empty will be generate):")
    vector_file = readline()
    println("Name of result file:")
    result_file = readline()

    A = read_matrix(matrix_file)
    if vector_file != ""
        b = read_vector(vector_file)
    else
        b = generate_rhs(A)
    end

    if solver_type == 1
        x = gauss_method(A, b)
    elseif solver_type == 2
        x = gauss_method_pivot(A, b)
    elseif solver_type == 3
        x = lu_method(A, b)
    elseif solver_type ==4
        x = lu_method_pivot(A, b)
    else
        println("Invalid solver number!")
    end

    write_x(result_file, x, nothing)
end

function matrix_generator()
    println("\nn value:")
    n = parse(Int, readline())
    println("l value:")
    l = parse(Int, readline())
    println("ck value:")
    ck = parse(Float64, readline())
    println("Name of result file:")
    result_file = readline()

    blockmat(n, l, ck, result_file)
end

function vector_generator()
    println("\nName of matrix file:")
    matrix_file = readline()
    println("Name of result file:")
    result_file = readline()

    A = read_matrix(matrix_file)
    b = generate_rhs(A)
    write_x(result_file, b, nothing)
end

"""
A simple program for manual testing of the sparsematrixModule and utilsModule modules. Choosing specific options ensures particular effects. 
!!! Each parameter should be on separate lines !!!
"""

println("Welcome in simple manual test program")
println("choose action:")
println("1 - solver")
println("2 - matrix_generator")
println("3 - vector_generator")
action_type = parse(Int, readline())

if action_type == 1
    solver()
elseif action_type == 2
    matrix_generator()
elseif  action_type == 3
    vector_generator()
else
    println("Invalid action!")
end
