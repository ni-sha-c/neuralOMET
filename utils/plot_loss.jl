include("../examples/nonconvex_smooth.jl")
using PyPlot
using Printf
function plot_loss_landscape(s=4.0)
	npts = 10000
	w = rand(npts)
	lw = rand(npts)
	fig, ax = subplots()
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)
	for (i, wi) = enumerate(w)
       lw[i] = loss(wi,s) 
	end
	ax.plot(w, lw,".")
end
function plot_orbits()
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
