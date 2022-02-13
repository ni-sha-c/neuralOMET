using PyPlot
include("lsq_ntk.jl")
function plot_err_vs_nparams()
	d = 10
	n = 2000
	nrep = 1
	nexps = 10
	err = zeros(nexps)
	N = zeros(Int64, nexps)
	for i = 1:nexps
		N[i] = n + round(Int64,exp(i)/d)
		@show "number of params = ", N[i]*d
		for k = 1:nrep
				err[i] += dir_test(d,n,N[i])/nrep
		end
	end
	fig = figure()
	ax = fig.add_subplot()
	ax.plot(log.(d.*N), err, ".-",lw=3.0, ms=25)
	ax.xaxis.set_tick_params(labelsize=35)
	ax.yaxis.set_tick_params(labelsize=35)
	ax.set_xlabel(L"\log(Nd)", fontsize=35)
	ax.set_ylabel("Test error", fontsize=35)
	ax.grid(true)

end
function plot_kernel_eigs()
	d = 10
	n = 2000
	N = n  
    β = randn(d)
    β ./= norm(β)

    X, Y = generate_data(n, d, β)
    Nd = N*d
    W = randn(d,N)
    for i = 1:N
        nw = norm(W[:,i])
        W[:,i] .*= sqrt(d)/nw
    end
	Φ = form_kernel(X, Y, W)
	Λ = eigvals(Φ'*Φ)
	@show "Minimum eig", minimum(Λ)
	fig = figure()
	ax = fig.add_subplot()
	ax.plot(Λ, ".-",lw=3.0, ms=25)
	ax.xaxis.set_tick_params(labelsize=35)
	ax.yaxis.set_tick_params(labelsize=35)
	ax.set_xlabel("index", fontsize=35)
	ax.set_ylabel("Kernel eigenvalues", fontsize=35)
	ax.grid(true)

	ax.set_ylim([0,10])
end
function plot_kernel_eig_pert()
	d = 10
	n = 2000
	N = 2*n  
    β = randn(d)
    β ./= norm(β)

    X, Y = generate_data(n, d, β)
    Nd = N*d
    W = randn(d,N)
    for i = 1:N
        nw = norm(W[:,i])
        W[:,i] .*= sqrt(d)/nw
    end
	Φ = form_kernel(X, Y, W)
	Λ = eigvals(Φ'*Φ)

	Xp = copy(X)
	Yp = copy(Y)
	Xp[:,1] = randn(d)
	Xp[:,1] = sqrt(d)*Xp[:,1]/norm(Xp[:,1])
	Yp[1] = model_fun(Xp[:,1], β)
	Φp = form_kernel(Xp, Yp, W)
	Λp = eigvals(Φp'*Φp)


	@show "Minimum eig orig", minimum(Λ)
	@show "Minimum eig pert", minimum(Λp)

	fig = figure()
	ax = fig.add_subplot()
	ax.plot(Λ, ".-",lw=3.0, ms=25, label="Original")
	ax.plot(Λp, ".-",lw=3.0, ms=25, label="Perturbed")
	ax.xaxis.set_tick_params(labelsize=35)
	ax.yaxis.set_tick_params(labelsize=35)
	ax.set_xlabel("index", fontsize=35)
	ax.legend(fontsize=35)
	ax.set_ylabel("Kernel eigenvalues", fontsize=35)
	ax.grid(true)

	ax.set_ylim([0,10])
end
function plot_solns_pert()
	d = 10
	n = 2000
	N = 2*n  
    β = randn(d)
    β ./= norm(β)

    X, Y = generate_data(n, d, β)
    Nd = N*d
    W = randn(d,N)
    for i = 1:N
        nw = norm(W[:,i])
        W[:,i] .*= sqrt(d)/nw
    end
	a = dir_solve(X,Y,W)

	Xp = copy(X)
	Yp = copy(Y)
	Xp[:,1] = randn(d)
	Xp[:,1] = sqrt(d)*Xp[:,1]/norm(Xp[:,1])
	Yp[1] = model_fun(Xp[:,1], β)
	ap = dir_solve(Xp,Yp,W)
	@show "Difference in solutions,",norm(a-ap)/sqrt(N*d)

	fig = figure()
	ax = fig.add_subplot()
	ax.plot(a, ".-",lw=3.0, ms=25, label="Original")
	ax.plot(ap, ".-",lw=3.0, ms=25, label="Perturbed")
	ax.xaxis.set_tick_params(labelsize=35)
	ax.yaxis.set_tick_params(labelsize=35)
	ax.set_xlabel("index", fontsize=35)
	ax.legend(fontsize=35)
	ax.set_ylabel("Soln", fontsize=35)
	ax.grid(true)

end
