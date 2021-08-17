include("../src/driver.jl")
using PyPlot
using Printf
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
function plot_bifurcation()
	npts = 50
	wstar = rand(npts)
	nSteps = 50000
	η = LinRange(0.0001, 0.1, 20)
	fig, ax = subplots()
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)

	for (i, ηi) = enumerate(η)
		@show i, ηi
		wstar .= rand(npts)
		for j = 1:npts
			wstar[j] = run(wstar[j], ηi, nSteps)
		end
		ax.plot(ηi*ones(npts), wstar, "bo", ms=3.0)
	end
	ax.grid(true)
	ax.set_xlabel(L"$ \eta $", fontsize=30)
	ax.set_ylabel(L"$ w^* $", fontsize=30)
end
