#
# 13-cmp-ext-reg.R, 23 Apr 20
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
# Jon Eyolfson and Lin Tan and Patrick Lam
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG commit_day-time commit_fault


source("ESEUR_config.r")

library("circular")
library("plyr")


plot_layout(2, 1, max_height=13)
par(mar=MAR_default-c(0.8, 0, 0.5, 0))

pal_col=rainbow(4)


sum_commits=function(df)
{
t=count(df$hour)

return(data.frame(hour=t$x, freq=t$freq))
}


day=0:23

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commitbasicinformation.tsv.xz"), sep="\t", as.is=TRUE)

commits$is_introducing= (commits$is_introducing == "t")
commits$is_fixing= (commits$is_fixing == "t")

fault_commits=subset(commits, is_introducing)
basic_commits=subset(commits, !is_introducing)


fault_total=ddply(fault_commits, .(week_day), sum_commits)
basic_total=ddply(basic_commits, .(week_day), sum_commits)

week_fault=subset(fault_total, week_day < 5)
week_basic=subset(basic_total, week_day < 5)

fault_mod = nls(freq ~ gam0+gam1*cos(omega*hour-phi+nu*cos(omega*hour-phi)),
                start = list(gam0 = 800, gam1 = 700, omega=0.3, phi = 1, nu = 0),
#                start = list(gam0 = 800, gam1 = 700, omega=3.8, phi = 1, nu = 0),
		data=week_fault)

fault_2mod = nls(freq ~ gam0+gam1*cos(omega*hour-phi+nu*cos(omega*hour-phi))+gam2*cos(2*omega*hour-phi+nu*sin(omega*hour-phi)),
                start = list(gam0 = 800, gam1 = 700, gam2=100, omega=0.3, phi = 1, nu = 0),
		data=week_fault)

basic_mod = nls(freq ~ gam0+gam1*cos(omega*hour-phi+nu*cos(omega*hour-phi)),
                start = list(gam0 = 800, gam1 = 700, omega=0.3, phi = 1, nu = 0),
		data=week_basic)
basic_2mod = nls(freq ~ gam0+gam1*cos(omega*hour-phi+nu*cos(omega*hour-phi))+gam2*cos(2*omega*hour-phi+nu*sin(omega*hour-phi)),
                start = list(gam0 = 800, gam1 = 700, gam2=100, omega=0.3, phi = 1, nu = 0),
		data=week_basic)

plot(week_basic$hour, week_basic$freq, col=pal_col[2],
	xaxs="i",
	xlab="Hour", ylab="non-fault commits\n")

pred=predict(basic_mod, newdata=data.frame(hour=day))
lines(day, pred, col=pal_col[3])

f_sum=summary(fault_mod)
b_sum=summary(basic_mod)
fault_pred=b_sum$coefficients[1, 1]+
		b_sum$coefficients[2, 1]*
			cos(f_sum$coefficients[3, 1]*day-
				f_sum$coefficients[4, 1]+
				f_sum$coefficients[5, 1]*
				  cos(f_sum$coefficients[3, 1]*day-
					  f_sum$coefficients[4, 1]))
lines(day, fault_pred, col=pal_col[1])


plot(week_basic$hour, week_basic$freq, col=pal_col[4],
	xaxs="i",
	xlab="Hour", ylab="non-fault commits\n")

pred=predict(basic_2mod, newdata=data.frame(hour=day))
lines(day, pred, col=pal_col[3])

f_sum=summary(fault_2mod)
b_sum=summary(basic_2mod)
fault_pred=b_sum$coefficients[1, 1]+
		b_sum$coefficients[2, 1]*
			cos(f_sum$coefficients[4, 1]*day-
				f_sum$coefficients[5, 1]+
				f_sum$coefficients[6, 1]*
				  cos(f_sum$coefficients[4, 1]*day-
					  f_sum$coefficients[5, 1]))+
		b_sum$coefficients[3, 1]*
			cos(2*f_sum$coefficients[4, 1]*day-
				f_sum$coefficients[5, 1]+
				f_sum$coefficients[6, 1]*
				  sin(f_sum$coefficients[4, 1]*day-
					  f_sum$coefficients[5, 1]))
lines(day, fault_pred, col=pal_col[1])

