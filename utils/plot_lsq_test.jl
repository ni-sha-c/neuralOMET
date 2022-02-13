using PyPlot
include("lsq_ntk.jl")
function plot_err_vs_nparams()
	d = 10
	n = 2000
	nrep = 1
	nexps = 10
	err = zeros(nexps)
	N = zeros(Int64, nexps)
	for i = 1:nexps
		N[i] = n + round(Int64,exp(i)/d)
		@show "number of params = ", N[i]*d
		for k = 1:nrep
				err[i] += dir_test(d,n,N[i])/nrep
		end
	end
	fig = figure()
	ax = fig.add_subplot()
	ax.plot(log.(d.*N), err, ".-",lw=3.0, ms=25)
	ax.xaxis.set_tick_params(labelsize=35)
	ax.yaxis.set_tick_params(labelsize=35)
	ax.set_xlabel(L"\log(Nd)", fontsize=35)
	ax.set_ylabel("Test error", fontsize=35)
	ax.grid(true)
end
function plot_kernel_eigs()

	d = 10
	n = 2000
	nrep = 1
	nexps = 10
	err = zeros(nexps)
	N = zeros(Int64, nexps)
	for i = 1:nexps
		N[i] = n + round(Int64,exp(i)/d)
		@show "number of params = ", N[i]*d
		for k = 1:nrep
				err[i] += dir_test(d,n,N[i])/nrep
		end
	end
	fig = figure()
	ax = fig.add_subplot()
	ax.plot(log.(d.*N), err, ".-",lw=3.0, ms=25)
	ax.xaxis.set_tick_params(labelsize=35)
	ax.yaxis.set_tick_params(labelsize=35)
	ax.set_xlabel(L"\log(Nd)", fontsize=35)
	ax.set_ylabel("Test error", fontsize=35)
	ax.grid(true)




end
