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
function dir_test(d=2, n=300, N=300, ntest=100)
    β = randn(d)
    β ./= norm(β)

	X, Y = generate_data(n, d, β)
	Nd = N*d
	W = randn(d,N)
	for i = 1:N
		nw = norm(W[:,i])
		W[:,i] ./= nw
	end
	a = dir_solve(X, Y, W)
	return comp_err(a, W, ntest)
end
function model_fun(x, β)
	betax = dot(β,x)
	return (sqrt(0.5)*h1(betax) + 
		   sqrt(0.5)*h2(betax) + 
		   0.5*randn())
end
function generate_data(n, d, β)
	X = zeros(d, n)
	Y = zeros(n)
	for i = 1:n
		X[:,i] = randn(d) 
		X[:,i] = X[:,i]/norm(X[:,i])
		Y[i] =	model_fun(X[:,i], β)
	end
    return X, Y	
end
function form_kernel(X, Y, W)
	d, N = size(W)
	Φ = zeros(Nd, n)
	sNd = sqrt(N*d)
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
	return Φ*solve(K, Y)
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
			Y_true[i] = model_fun(X_test[:,i],β)
		for j = 1:N
			spwx = dot(X_test[:,i], W[:,j])
			if spwx > 0
				Y[i] += dot(a[(j-1)*d+1:j*d],X_test[:,n])/sNd
			end

		end
	end
	return norm((Y_true .- Y)./Y)/sqrt(n)
end
	
