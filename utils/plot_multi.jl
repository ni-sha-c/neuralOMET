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
    wstar = randn(2)
	w = zeros(2)
	wplot = zeros(2, npts)
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
		@show ηi, maximum(wplot)
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
