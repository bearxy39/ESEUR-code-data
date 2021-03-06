#
# BF03194493.R, 27 May 20
# Data from:
# The Marginal Value of Increased Testing: An Empirical Analysis using Four Code Coverage Measures
# Swapna S. Gokhale and Robert E. Mullen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG testing blocks_decisions coverage_blocks coverage_decisions

source("ESEUR_config.r")


pal_col=rainbow(2)

sh=read.csv(paste0(ESEUR_dir, "reliability/BF03194493.csv.xz"), as.is=TRUE)

sh$Block=sh$Block/100
sh$Dec=sh$Dec/100

plot(sh$Block, sh$Dec, col=pal_col[2],
	xlab="Block", ylab="Decision\n")


# The model: bd_mod=nls(Dec ~ c+a*Block^b, data=sh,
# produces a very different fit.  Presumably because the measurement points
# are nearly all above than 0.7
bd_mod=nls(Dec ~ a*Block^b, data=sh,
		start=list(a=0.1, b=1))
# summary(bd_mod)

x_range=seq(.01, 1, by=0.01)

pred=predict(bd_mod, newdata=data.frame(Block=x_range))
lines(x_range, pred, col=pal_col[1])

lines(c(0.1, 1), c(0.1, 1), col="grey")


# library("betareg")
#
# # A good fit, but the predictions look unrealistic
# # beta_mod=betareg(Dec ~ Block+I(Block^0.5), data=sh)
# 
# # The following all fit 'equally' well!
# # beta_mod=betareg(Dec ~ I(Block^2.0), data=sh)
# # beta_mod=betareg(Dec ~ I(Block^0.5), data=sh)
# beta_mod=betareg(Dec ~ Block, data=sh)
# 
# summary(beta_mod)
# 
# pred=predict(beta_mod, newdata=data.frame(Block=x_range))
# lines(x_range, pred, col=pal_col[3])
# 
