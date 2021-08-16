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
	N = 100000
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

