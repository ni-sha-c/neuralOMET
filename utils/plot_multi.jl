include("../src/general_driver.jl")
using PyPlot
using Printf
using LinearAlgebra
using JLD
function plot_hess_eigs(w, η, s=1.0)
	npts = 50000
	max_hess_eigs = zeros(npts)
	min_hess_eigs = zeros(npts)
	for i = 1:npts
		d2L = hess_loss(w, s)
		x = eigvals(d2L)
		max_hess_eigs[i] = maximum(x)
		min_hess_eigs[i] = minimum(x)
		w = next(w, η, s)
	end
	fig, ax = subplots()
	ax.plot(max_hess_eigs, ".", ms=10)
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)
    ax.set_xlabel("step number", fontsize=30)
	ax.set_ylabel(L"$ \||\nabla^2 L \|| $", fontsize=30)
    ax.grid(true)
    ax.set_title("η = $η", fontsize=30)
	fig, ax = subplots()
	ax.plot(min_hess_eigs, ".", ms=10)
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)
    ax.set_xlabel("step number", fontsize=30)
	ax.set_ylabel(L"$ \||(\nabla^2 L)^{-1}\|| $", fontsize=30)
    ax.grid(true)

    return max_hess_eigs, min_hess_eigs

end
function plot_lyapunov_exponents()
	npts = 10
	w = rand(npts)
	les = rand(npts)
	η = [0.001,0.01,0.02,0.025,0.05] 
	fig, ax = subplots()
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)

	for (i, ηi) = enumerate(η)
		w .= rand(npts)
		@show i, ηi
		for j = 1:npts
			les[j] = lyap_exp(w[j], ηi)
		end
		ax.plot(w, les, label=latexstring(L"\eta = ",@sprintf("%0.3f", ηi)))
	end
end
function fixed_point(w, η, s)
	n = 20000
	for i = 1:n
		w = next(w, η, s)
	end
	return w
end
function plot_bifurcation()
	nSteps = 20000
	η = LinRange(1.e-3, 2.0, 50)
	npts_η = size(η)[1]
	npts = 100	
	s = 1.0
	fig, ax = subplots()
	fig1, ax1 = subplots()
    wstar = randn(3)
	w = zeros(3)
	wplot = zeros(3, npts)
   	i = 1 
	while i <= npts_η
		@show i
		ηi = η[i]
		w .= wstar
		w = run(w, ηi, nSteps, s)
		wplot[:,1] = w
		for n = 1:npts-1
				wplot[:,n+1] = next(wplot[:,n], ηi, s)
		end
		@show ηi, wplot[:,end]
		if maximum(wplot) != NaN && minimum(wplot) != NaN 
			i += 1
		    ax.plot(ηi*ones(npts), wplot[1,:], "bo", ms=3.0)
		    ax1.plot(ηi*ones(npts), wplot[2,:], "ko", ms=3.0)

		end
	end
	ax.grid(true)
	ax.set_xlabel(L"$ \eta $", fontsize=30)
	ax.set_ylabel(L"$ w^*_1 $", fontsize=30)
    ax1.grid(true)
	ax1.set_xlabel(L"$ \eta $", fontsize=30)
	ax1.set_ylabel(L"$ w^*_2 $", fontsize=30)
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)
    ax1.xaxis.set_tick_params(labelsize=30)
	ax1.yaxis.set_tick_params(labelsize=30)
    return wplot, wstar 
end
X = load("goodIC-deep.jld")
w0 = X["w0"]
η = 0.7
max_hess_eigs, min_hess_eigs = plot_hess_eigs(w0, η)

