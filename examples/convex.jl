function next(w, η)
	return (w + η*sin(2π*w) + 1) % 1
end
function dnext(w, η)
	return 1.0 + 2π*η*cos(2π*w)
end
function d2next(w, η)
	return -2π*2π*η*sin(2π*w)
end
