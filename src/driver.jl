include("../examples/nonconvex_smooth.jl")
function lyap_exp(w, η)
	N = 20000
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


