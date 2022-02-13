using LinearAlgebra
h1(x) = x
h2(x) = (x*x - 1)/sqrt(2)
"""
d : input dimension
n : no. of samples
N : no. of neurons
ntest : no. of test data points

True data: y_i = f(x_i) + ϵ_i, i <= n
are interpolated using N neurons and ReLU activations. 

Overparameterization is assumed, so choose d, n and N such that Nd > n.

Test error is the output
"""
function dir_test(d=2, n=30, N=300, ntest=100)
    β = randn(d)
    β ./= norm(β)

	X, Y = generate_data(n, d, β)
	Nd = N*d
	W = randn(d,N)
	for i = 1:N
		nw = norm(W[:,i])
		W[:,i] .*= sqrt(d)/nw
	end
	a = dir_solve(X, Y, W)
	return comp_err(a, W, ntest, β)
end
function model_fun(x, β)
	betax = dot(β,x)
	sqrthalf = sqrt(0.5)
	return (sqrthalf*h1(betax) + 
		   sqrthalf*h2(betax) + 
		   sqrthalf*randn())
end
function generate_data(n, d, β)
	X = zeros(d, n)
	Y = zeros(n)
	for i = 1:n
		X[:,i] = randn(d) 
		X[:,i] = sqrt(d)*X[:,i]/norm(X[:,i])
		Y[i] =	model_fun(X[:,i], β)
	end
    return X, Y	
end
function form_kernel(X, Y, W)
	d, N = size(W)
    n = size(Y)[1]
	Nd = N*d
	Φ = zeros(Nd, n)
	sNd = sqrt(Nd)
	for k = 1:n
		xk = X[:,k]
		for i = 1:N
			wi = W[:,i]
			sp = dot(wi, xk)
			if (sp > 0)
				Φ[(i-1)*d+1:i*d,k] = xk/sNd
			end
		end
	end
	return Φ
end
function dir_solve(X, Y, W)
	Φ = form_kernel(X, Y, W)
	K = Φ'*Φ	
	return Φ*(K\Y)
end
function it_solve(X, Y, W, η=0.01)

end
function comp_err(a, W, n, β)
	d, N = size(W)
	X_test = randn(d,n)
	Y_true = zeros(n)
	Y = zeros(n)
	sNd = sqrt(N*d)
	for i = 1:n
		X_test[:,i] .*= sqrt(d)/norm(X_test[:,i])
		Xi = X_test[:,i]
		Y_true[i] = model_fun(Xi,β)
		for j = 1:N
			Wj = W[:,j]
			spwx = dot(Xi, Wj)
			if spwx > 0
				Y[i] += dot(a[(j-1)*d+1:j*d],Xi)/sNd
			end

		end
	end
	@show Y_true[1:10], Y[1:10]
	return norm((Y_true .- Y)./Y)/sqrt(n)
end
	
