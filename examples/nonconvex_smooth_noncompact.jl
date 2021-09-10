using LinearAlgebra
function loss(w, s=4.0)
	return (w[1]*w[2] - s)^2/2
end
function grad_loss(w, s=4.0) 
	term = w[1]*w[2] - s
	return term*[w[2], w[1]]
end
function hess_loss(w, s=4.0)
	term = w[1]*w[2] - s
	dterm = [w[2] w[1]]
	return term*[0 1;1 0] .+ 
	[w[2]*dterm; w[1]*dterm] 
end
next(w, η, s=4.0) = w - η*grad_loss(w, s)
dnext(w, η, s=4.0) = I(2) - η*hess_loss(w, s)    
function d2next(w, η, s=4.0)
    term = w[1]*w[2] - s
    dterm = [w[2] w[1]]
    d2term = [0 1;1 0]
    dfirst = [0 0;dterm; dterm; 0 0]
    dsecond = [0 2*w[2]; w[2] w[1]; 
		   w[2] w[1]; 2*w[1] 0]
    return -η*(dfirst .+ dsecond)	
end
