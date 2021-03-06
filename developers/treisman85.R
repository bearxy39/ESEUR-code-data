#
# treisman85.R, 28 Aug 20
#
# Data from:
# Search Asymmetry: {A} Diagnostic for Preattentive Processing of Separable Features
# Anne Treisman and Janet Souther
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example experiment_human vision_preattentive


source("ESEUR_config.r")


plot_layout(1, 2, default_height=8)
par(mar=c(1, 1, 0.5, 0))

start_plot=function()
{
plot(0, type="n", bty="o", xaxt="n", yaxt="n", xaxs="i", yaxs="i",
	xlim=c(1, 10), ylim=c(1, 10),
	xlab="", ylab="")
}


draw_circle=function(x, y)
{
lines(x+circle_x_pts, y+circle_y_pts, col=point_col)
}

draw_cusp=function(x, y)
{
lines(x+head(circle_x_pts, n=-30), y+head(circle_y_pts, n=-30), col=point_col)
}


half_circle=function(x, y)
{
half_len=length(circle_x_pts)/2
lines(x+head(circle_x_pts, n=half_len), y+head(circle_y_pts, n=half_len), col=point_col)
}

circle_line=function(x, y)
{
draw_circle(x, y)
lines(c(x, x), c(y, y-1.1), col=point_col)
}


circum=c(seq(0, 0.70, by=0.01), 0.5^0.5)  # 0.7071068
circle_x_pts=c(circum, rev(circum), -circum, -rev(circum))
circle_y_pts=c(-sqrt(0.5-circum^2), +sqrt(0.5-rev(circum)^2),
		sqrt(0.5-circum^2), -sqrt(0.5-rev(circum)^2))


start_plot()
draw_circle(2.5, 2.5)
draw_circle(2.7, 6.9)
draw_circle(3.6, 4.3)
draw_circle(4.1, 8.1)
circle_line(6.3, 3.3)
draw_circle(5.9, 7.0)
draw_circle(8.9, 1.9)
draw_circle(8.1, 8.1)
draw_circle(7.5, 5.2)

# start_plot()
# draw_circle(2.5, 2.5)
# draw_circle(2.7, 6.9)
# draw_circle(3.6, 4.3)
# draw_circle(4.1, 8.1)
# draw_circle(6.3, 3.3)
# draw_circle(5.9, 7.0)
# draw_circle(8.9, 1.9)
# draw_circle(8.1, 8.1)
# draw_cusp(7.5, 5.2)
# 
# start_plot()
# draw_circle(2.5, 2.5)
# draw_circle(2.7, 6.9)
# draw_circle(3.6, 4.3)
# draw_circle(4.1, 8.1)
# draw_circle(6.3, 3.3)
# draw_circle(5.9, 7.0)
# draw_circle(8.9, 1.9)
# half_circle(8.1, 8.1)
# draw_circle(7.5, 5.2)


start_plot()
circle_line(2.5, 2.5)
circle_line(2.7, 6.9)
circle_line(3.6, 4.3)
circle_line(4.1, 8.1)
circle_line(6.3, 3.3)
circle_line(5.9, 7.0)
circle_line(8.9, 1.9)
circle_line(8.1, 8.1)
draw_circle(7.5, 5.2)

# start_plot()
# draw_cusp(2.5, 2.5)
# draw_cusp(2.7, 6.9)
# draw_circle(3.6, 4.3)
# draw_cusp(4.1, 8.1)
# draw_cusp(6.3, 3.3)
# draw_cusp(5.9, 7.0)
# draw_cusp(8.9, 1.9)
# draw_cusp(8.1, 8.1)
# draw_cusp(7.5, 5.2)
# 
# 
# start_plot()
# half_circle(2.5, 2.5)
# half_circle(2.7, 6.9)
# draw_circle(3.6, 4.3)
# half_circle(4.1, 8.1)
# half_circle(6.3, 3.3)
# half_circle(5.9, 7.0)
# half_circle(8.9, 1.9)
# half_circle(8.1, 8.1)
# half_circle(7.5, 5.2)


