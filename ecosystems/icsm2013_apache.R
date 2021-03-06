#
# icsm2013_apache.R, 26 May 20
# Data from:
# The Evolution of Project Inter-Dependencies in a Software Ecosystem: the Case of {Apache}
# Gabriele Bavota and Gerardo Canfora and Massimiliano {Di Penta} and Rocco Oliveto and Sebastiano Panichella
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java_project evolution dependency_evolution method_dependency class_dependency project_evolution


source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))
pal_col=rainbow(5)


icsm=read.csv(paste0(ESEUR_dir, "ecosystems/icsm2013_apache.csv.xz"), as.is=TRUE, sep=";")
icsm$DATE=as.Date(icsm$DATE, format="%d/%m/%y")

plot(icsm$DATE, icsm$LOC, type="l", log="y", col=pal_col[1],
	xaxs="i", yaxs="i",
	ylim=c(1, 4e7),
	xlab="Date", ylab="Projects\n\n")

lines(icsm$DATE, icsm$METHODS, col=pal_col[2])
lines(icsm$DATE, icsm$CLASSES, col=pal_col[3])
lines(icsm$DATE, icsm$N_PROJECTS, col=pal_col[4])
lines(icsm$DATE, icsm$N_DEPENDENCIES, col=pal_col[5])

legend(x="bottomright", legend=c("LOC", "Methods", "Classes", "Projects", "Dependencies"),
			inset=c(-0.02, 0.3), bty="n", fill=pal_col, cex=1.2)

# LM_mod=glm(LOC ~ METHODS+N_PROJECTS
#                  +(METHODS+N_PROJECTS):N_DEPENDENCIES, data=icsm)
# LM_mod=glm(LOC ~ METHODS+N_PROJECTS:N_DEPENDENCIES, data=icsm)
# LM_mod=glm(LOC ~ METHODS, data=icsm)
# summary(LM_mod)
# 
# DP_mod=glm(N_DEPENDENCIES ~ METHODS+CLASSES+N_PROJECTS, data=icsm)
# DP_mod=glm(N_DEPENDENCIES ~ CLASSES+N_PROJECTS, data=icsm)
# DP_mod=glm(N_DEPENDENCIES ~ METHODS+N_PROJECTS+I(N_PROJECTS^2), data=icsm)
# summary(DP_mod)
# 

