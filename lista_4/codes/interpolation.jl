#Krzysztof Dobrucki
#Numer albumu 268507
#Informatyka Algorytmiczna
#Semestr Zimowy 2023/2024
#Politechnika Wrocławska
#05.12.2023r.

module Interpolation
export differencesQuotients, NewtonPolynomial, naturalForm, plotNnfx
using Plots

"""
Function calculating the differences quotients, which are coefficients of the linear combination for the Newton
interpolating polynomial.

Inputs:
  x - vector of length n + 1 containing nodes x_0, ..., x_n: x[1] = x_0, ..., x[n+1] = x_n
  f - vector of length n + 1 containing values of the interpolated function at nodes: f(x_0), ..., f(x_n)

Outputs:
  fx - vector of length n + 1 containing calculated differences quotients:
    fx[1] = f[x_0], fx[2] = f[x_0, x_1], ..., fx[n] = f[x_0, ..., x{n-1}], fx[n+1] = f[x_0, ..., x_n].
"""
function differencesQuotients(x::Vector{Float64}, f::Vector{Float64})::Vector{Float64}
    len = length(x)
    fx = zeros(len)

    for i in 1:len   # place function values into the result array, f(x_0) = f[x_0]
        fx[i] = f[i]
    end

    for j in 2:len  # calculate f[x_0, x_1, ..., x_j]
        for k in len:-1:j
            fx[k] = (fx[k] - fx[k-1]) / (x[k] - x[k-j+1])
        end
    end

    return fx
end

"""
Function calculating the value of the Newton interpolating polynomial of degree n at the point x = t.

Inputs:
  x - vector of length n + 1 containing nodes x_0, ..., x_n: x[1] = x_0 ,..., x[n+1] = x_n
  fx - vector of length n + 1 containing differences quotients: 
    fx[1] = f[x_0], fx[2] = f[x_0, x_1], ..., fx[n] = f[x_0, ..., x_{n-1}], fx[n+1] = f[x_0, ..., x_n]
  t - point where to calculate the polynomial value

Outputs:
  nt - polynomial value at point t.
"""
function NewtonPolynomial(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)::Float64
    len = length(x)
    nt::Float64 = fx[len]

    for i in (len-1):-1:1
        nt = fx[i] + (t - x[i]) * nt
    end

    return nt
end

"""
Function calculating the coefficients of the interpolating polynomial in natural form for a polynomial
given in Newton's form.

Inputs:
  x - vector of length n + 1 containing nodes x_0, ..., x_n: x[1] = x_0 ,..., x[n+1] = x_n
  fx - vector of length n + 1 containing differences quotients: 
    fx[1] = f[x_0], fx[2] = f[x_0, x_1], ..., fx[n] = f[x_0, ..., x_{n-1}], fx[n+1] = f[x_0, ..., x_n]

Outputs:
  a - vector of length n + 1 containing calculated coefficients in natural form:
    a[1] = a_0, a[2] = a_1, ..., a[n] = a_{n-1}, a[n+1] = a_n.
"""
function naturalForm(x::Vector{Float64}, fx::Vector{Float64})::Vector{Float64}
    len = length(x)
    a::Vector{Float64} = zeros(len)
    a[len] = fx[len]
    for i in (len-1):-1:1
        a[i] = fx[i] - x[i] * a[i+1]
        for j in (i+1):(len-1)
            a[j] += -x[i] * a[j+1]
        end
    end

    return a
end

"""
Function interpolating the given function f(x) in the interval [a, b] using an interpolating polynomial
of degree n in Newton's form. Plots the interpolating polynomial and the interpolated function using the Plots package.
Uses equidistant nodes for interpolation.

Inputs:
  f - function f(x) given as an anonymous function,
  a, b - interval boundaries for interpolation
  n - degree of the interpolating polynomial

Outputs:
  The function plots the interpolating polynomial and the interpolated function in the interval [a, b].
"""
function plotNnfx(f, a::Float64, b::Float64, n::Int)
    resolution = 100  # number of points plotted on the graph between nodes (including the node on the left side of the interval)
    h::Float64 = (b - a) / n
    x::Vector{Float64} = zeros(n + 1)
    fValues::Vector{Float64} = zeros(n + 1)
    for i in 1:(n+1)
        x[i] = a + (i - 1) * h
        fValues[i] = f(x[i])
    end

    c::Vector{Float64} = differencesQuotients(x, fValues)

    numberOfPoints = resolution * n + 1 # plus one because we also consider the right boundary b
    step::Float64 = (b - a) / (numberOfPoints - 1)

    xPlot::Vector{Float64} = zeros(numberOfPoints)
    fPlot::Vector{Float64} = zeros(numberOfPoints)
    polynomialPlot::Vector{Float64} = zeros(numberOfPoints)

    xPlot[1] = a
    fPlot[1] = fValues[1]
    polynomialPlot[1] = fValues[1] # a is one of the n+1 nodes
    for i in 2:numberOfPoints
        xPlot[i] = a + (i - 1) * step
        fPlot[i] = f(xPlot[i])
        polynomialPlot[i] = NewtonPolynomial(x, c, xPlot[i])
    end

    p = plot(xPlot, [fPlot, polynomialPlot], label=["function" "polynomial"], title="Interpolation of f with polynomial of degree <=$n")
    return p
end

end
