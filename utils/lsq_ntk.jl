using LinearAlgebra
# dimension of input
d = 20
# number of samples
n = 3000
# generate data
# y_i = f(x_i) + ϵ_i
# β : fixed unit norm vector 
β = rand(d)
β ./= norm(β)
# Hermite polynomials that go into f
h1(x) = x
h2(x) = (x*x - 1)/sqrt(2)
function generate_data(n, d)
	X = zeros(d, n)
	Y = zeros(d)
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
function train(X, Y, W)
	# Form matrix Phi
	Φ = zeros(n, Nd)
    for i = 1:Nd
			
	end
end

	end
	end



end
