using LinearAlgebra
h1(x) = x
h2(x) = (x*x - 1)/sqrt(2)
β = randn(d)
β ./= norm(β)
"""
d : input dimension
n : no. of samples
N : no. of neurons
Ntest : no. of test data points

True data: y_i = f(x_i) + ϵ_i, i <= n
are interpolated using N neurons and ReLU activations. 

Overparameterization is assumed, so choose d, n and N such that Nd > n.

Test error is the output
"""
function dir_test(d=2, n=300, N=300)


end
function generate_data(n, d)
	X = zeros(d, n)
	Y = zeros(n)
	for i = 1:n
		X[:,i] = randn(d) 
		X[:,i] = X[:,i]/norm(X[:,i])
		betax = dot(β,X[:,i])
		Y[i] = sqrt(0.5)*h1(betax) + 
		       sqrt(0.5)*h2(betax) + 
			   0.5*randn()
	end
    return X, Y	
end
# number of neurons
N = 3000
Nd = N*d
W = randn(d,N)
for i = 1:N
	nw = norm(W[:,i])
	W[:,i] ./= nw
end
function form_kernel(X, Y, W)
	# Form matrix Phi
	Φ = zeros(Nd, n)
	for k = 1:n
		xk = X[:,k]
		for i = 1:N
			wi = W[:,i]
			sp = dot(wi, xk)
			if (sp > 0)
				Φ[(i-1)*d+1:i*d,k] = xk
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
	
