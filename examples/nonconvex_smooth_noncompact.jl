using Zygote
function loss(w, s=4.0)
	return (w[1]*w[2] - s)^2/2
end
grad_loss(w, s=4.0) = gradient(w -> loss(w, s), w)[1]
next(w, η, s=4.0) = w - η*grad_loss(w, s)
dnext(w, η, s=4.0) = jacobian(w -> next(w, η, s), w)[1]
d2next(w, η, s=4.0) = jacobian(w -> dnext(w, η, s), w)[1]

