#include("../examples/nonconvex_smooth.jl")
include("../src/driver.jl")
using PyPlot
using Printf
function plot_loss_landscape(s=1.0)
	npts = 50000
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
function plot_sharpness(η, s=1.0)
	npts = 50000
	w = rand(npts)
	lw = rand(npts)
	fig, ax = subplots()
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)
	for (i, wi) = enumerate(w)
		lw[i] = abs(dnext(wi, η, s) - 1.0)/η
	end
	ax.plot(w, lw,".")
end

function plot_orbits(s)
	npts = 100
	wstar = rand(npts)
	nSteps = 1000
	η = LinRange(0.001, 0.1, 5)
	fig, ax = subplots()
	ax.xaxis.set_tick_params(labelsize=16)
	ax.yaxis.set_tick_params(labelsize=16)

	for (i, ηi) = enumerate(η)
		@show i, ηi
		wstar .= rand(npts)
		for j = 1:npts
			wstar[j] = run(wstar[j], ηi, nSteps, s)
		end
		ax.plot(ηi*ones(npts), wstar, "bP", ms=3.0)
	end
	ax.grid(true)
	ax.set_xlabel(L"$ \eta $", fontsize=16)
	ax.set_ylabel(L"$ w^* $", fontsize=16)
end
function get_lyaps(η, s, npts)
	w = rand(npts)
	lw = rand(npts)
	for (i, wi) = enumerate(w)
			lw[i] = lyap_exp(wi, η, s)
	end
	return lw
end
function plot_lyaps(s)
	η = LinRange(0.001, 0.1, 5)
	fig, ax = subplots()
	ax.xaxis.set_tick_params(labelsize=16)
	ax.yaxis.set_tick_params(labelsize=16)
	npts = 100
	for (i, ηi) = enumerate(η)
		@show i, ηi
		lw = get_lyaps(ηi, s, npts)
		ax.plot(ηi*ones(npts), lw, "rv", ms=3.0)
	end
	ax.grid(true)
	ax.set_xlabel(L"$ \eta $", fontsize=16)
	ax.set_ylabel(L"$ Lyapunov exponent $", fontsize=16)



end
