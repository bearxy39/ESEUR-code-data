#
# simula_04.R, 13 Apr 20
#
# Data from:
# Eliminating Over-Confidence in Software Development Effort Estimates
# Magne J{\o}rgensen and Kjetil Mol{\o}kken
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate_effort overconfidence project_estimate


source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))


pal_col=rainbow(2)

# Team,Group,Estimate,Minimum,Maximum
est=read.csv(paste0(ESEUR_dir, "group-compare/simula_04.csv.xz"), as.is=TRUE)

plot(density(subset(est, Group =="A")$Estimate, from=0), col=pal_col[1],
	main="",
	xaxs="i", yaxs="i",
	xlim=c(0, max(est$Estimate)), ylim=c(0, 9e-4),
	xlab="Estimate", ylab="Density\n\n")
lines(density(subset(est, Group !="A")$Estimate, from=0), col=pal_col[2])

legend(x="topright", legend=c("No instructions", "With instructions"), bty="n", fill=pal_col, cex=1.2)


