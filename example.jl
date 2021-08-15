using PyPlot
function next(w, η)
	return (w + η*sin(2π*w) + 1) % 1
end
function dnext(w, η)
	return 1.0 + 2π*η*cos(2π*w)
end
function d2next(w, η)
	return -2π*2π*η*sin(2π*w)
end
function lyap_exp(w, η)
	N = 10000
	le = 0.0
	for n = 1:N
		le += log(abs(dnext(w, η)))/N
		w = next(w, η)
	end
	return le
end
function run(w, η, n)
	for i = 1:n
		w = next(w, η)
	end
	return w
end
function bifurcation()
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
