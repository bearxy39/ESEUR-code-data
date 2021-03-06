#
# ase2018_gallaba.R, 22 Oct 19
# Data from:
# Noise and Heterogeneity in Historical Build Data: {An} Empirical Study of {Travis} {CI}
# Keheliya Gallaba and Christian Macho and Martin Pinzger and Shane McIntosh
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Travis-CI build_CI build_jobs build_failure


source("ESEUR_config.r")


pal_col=rainbow(2)


jf=read.csv(paste0(ESEUR_dir, "projects/ase2018_gallaba.csv.xz"), as.is=TRUE)

# Most jobs are small
jf10=subset(jf, all_jobs < 10)
# Sample them to reduce the size of the generated image
samp=sample(1:nrow(jf10), 10000)

jf_samp=rbind(subset(jf, all_jobs >= 10), jf10[samp, ])

# jf$p_failed=jf$failed_jobs/jf$all_jobs

plot(jitter(jf_samp$all_jobs), jitter(jf_samp$failed_jobs), log="xy", col=pal_col[2],
		xlab="Jobs in build", ylab="Failed jobs\n",
		xlim=c(3, 50), ylim=c(3, 50))

jf_3=subset(jf_samp, all_jobs > 3)

x_bounds=2:60

# There are five cases of zero failed jobs
loess_mod=loess(log(failed_jobs+1e-9) ~ log(all_jobs), data=jf_3, span=0.3)
loess_pred=predict(loess_mod, newdata=data.frame(all_jobs=x_bounds))
lines(x_bounds, exp(loess_pred), col=pal_col[1])

# j_mod=glm(log(failed_jobs) ~ log(all_jobs), data=jf_3, subset=(all_jobs > 8))
# summary(j_mod)
# 
# j_pred=predict(j_mod, newdata=data.frame(all_jobs=x_bounds))
# lines(x_bounds, exp(j_pred), col=pal_col[1])


