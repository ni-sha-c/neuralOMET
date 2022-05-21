# Generate plots for the paper
include("plot_loss.jl")
s_ing = [1.0, 3.0, 4.0]
function plot_plots(s_list=s_ing)
	for (i, si) = enumerate(s_list)
		@show i
		#plot_loss(si)
		plot_sharpness(si)
		#plot_lyaps(si)
		#plot_orbits(si)
	end
end

