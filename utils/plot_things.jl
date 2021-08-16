include("example.jl")
using Printf
function plot_lyapunov_exponents()
	npts = 1000
	w = rand(npts)
	les = rand(npts)
	nSteps = 100000
	η = [0.5] 
	fig, ax = subplots()
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)

	for (i, ηi) = enumerate(η)
		w .= rand(npts)
		for j = 1:npts
			les[j] = lyap_exp(w[j], ηi)
		end
		ax.plot(w, les, label=latexstring(L"\eta = ",@sprintf("%0.1f", ηi)))
	end
	w .= rand(npts)
	for j = 1:npts
		les[j] = lyap_exp(w[j], 1/π - 2.e-1)
	end
	ax.plot(w, les, label=latexstring(L"\eta = 1/\pi - 0.2"))
 
	w .= rand(npts)
	for j = 1:npts
		les[j] = lyap_exp(w[j], 1/π - 1.e-1)
	end
	ax.plot(w, les, label=latexstring(L"\eta = 1/\pi - 0.1"))
 


	w .= rand(npts)
	for j = 1:npts
		les[j] = lyap_exp(w[j], 1/π + 1.e-2)
	end
	ax.plot(w, les, label=latexstring(L"\eta = 1/\pi + 0.01"))
 
	w .= rand(npts)
	for j = 1:npts
		les[j] = lyap_exp(w[j], 1/π + 1.e-1)
	end
	ax.plot(w, les, label=latexstring(L"\eta = 1/\pi + 0.1"))
 
	w .= rand(npts)
	for j = 1:npts
		les[j] = lyap_exp(w[j], 1/π + 4.e-1)
	end
	ax.plot(w, les, label=latexstring(L"\eta = 1/\pi + 0.4"))
 

	ax.grid(true)
	ax.set_xlabel(L"$ w $", fontsize=30)
	ax.set_ylabel(L"$\lambda(w)$", fontsize=30)
	ax.legend(fontsize=30)
end
function plot_bifurcation()
	npts = 500
	wstar = rand(npts)
	nSteps = 100000
	η = LinRange(0.01, 1.0, 100)
	fig, ax = subplots()
	ax.xaxis.set_tick_params(labelsize=30)
	ax.yaxis.set_tick_params(labelsize=30)

	for (i, ηi) = enumerate(η)
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
