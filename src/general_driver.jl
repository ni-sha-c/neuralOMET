include("../examples/nonconvex_smooth_noncompact.jl")
function lyap_exp(w, η, s=1.0)
	N = 20000
	le = 0.0
	v = rand(2)
	for n = 1:N
		v = dnext(w, η, s)*v
		nv = norm(v)
		v ./= nv
		le += log(nv)/N
		w = next(w, η, s)
	end
	return le
end
function run(w, η, n, s)
	for i = 1:n
		w = next(w, η, s)
	end
	return w
end


