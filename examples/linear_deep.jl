using LinearAlgebra
function loss(w, s=4.0)
	return (w[1]*w[2]*w[3] - s)^2/2
end
function grad_loss(w, s=4.0) 
	term = w[1]*w[2]*w[3] - s
	return term*[w[2]*w[3], 
				w[1]*w[3], 
				w[1]*w[2]]
end
function hess_loss(w, s=4.0)
	term = w[1]*w[2]*w[3] - s
	dterm = [w[2]*w[3] w[1]*w[3] w[1]*w[2]]

	return term*[0 w[3] w[2]; 
				 w[3] 0 w[1];
				 w[2] w[1] 0] .+ 
	[w[2]*w[3]*dterm; w[1]*w[3]*dterm;
	w[1]*w[2]*dterm] 
end
next(w, η, s=4.0) = w - η*grad_loss(w, s)
dnext(w, η, s=4.0) = I(3) - η*hess_loss(w, s)    
function d2next(w, η, s=4.0)
	term = w[1]*w[2]*w[3] - s
	dterm = [w[2]*w[3] w[1]*w[3] w[1]*w[2]]
	d2term = [0 w[3] w[2];w[3] 0 w[1];
			 w[2] w[1] 0]
    dfirst = term*[0 0 0;0 0 1;0 1 0;
				   0 0 1;0 0 0;1 0 0;
				   0 1 0;1 0 0;0 0 0] .+ 
	[0 0 0;w[3]*dterm;w[2]*dterm;
	 w[3]*dterm;0 0 0;w[1]*dterm;
	w[2]*dterm;w[1]*dterm;0 0 0]	



	dsecond = [0 2*w[2]*w[3]*w[3] 2*w[2]*w[2]*w[3];
			   w[2]*w[3]*w[3] w[1]*w[3]*w[3] 2*w[1]*w[2]*w[3];
			   w[2]*w[2]*w[3] 2*w[1]*w[2]*w[3] w[1]*w[2]*w[2];
			   w[2]*w[3]*w[3] w[1]*w[3]*w[3] 2*w[1]*w[2]*w[3];
			   2*w[3]*w[3]*w[1] 0 2*w[3]*w[1]*w[1];
			   2*w[1]*w[2]*w[3] w[1]*w[1]*w[3] w[1]*w[1]*w[2];
			   w[2]*w[2]*w[3] 2*w[2]*w[1]*w[3] w[1]*w[2]*w[2];
			   2*w[1]*w[2]*w[3] w[1]*w[1]*w[3] w[1]*w[1]*w[2];
			   2*w[1]*w[2]*w[2] 2*w[1]*w[1]*w[2] 0]





    return -η*(dfirst .+ dsecond)	
end
