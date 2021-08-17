using Zygote
n_comp = 2
function g(w, s=4.0)
	return 1.0 - s*w*(1-w)
end
function loss(w, s=4.0)
	fw = w
	for n = 1:n_comp
		fw = g(fw, s)
	end
	return fw
end
grad_loss(w, s=0.4) = gradient(w -> loss(w, s), w)[1]
next(w, η, s=4.0) = (w - η*grad_loss(w, s) + 1.0) % 1.0
dnext(w, η, s=4.0) = gradient(w -> next(w, η, s), w)[1]
d2next(w, η, s=4.0) = gradient(w -> dnext(w, η, s), w)[1]

