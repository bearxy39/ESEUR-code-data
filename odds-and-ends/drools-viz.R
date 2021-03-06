#
# drools-viz.R, 23 Apr 20
# Data from:
# Parameter-Free Probabilistic {API} Mining across {GitHub}
# Jaroslav Fowkes and Charles Sutton
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG API_mining method_call call_sequence-mining


source("ESEUR_config.r")


library("arules")
library("arulesViz")


# Convert original Fowkes and Sutton data into two column data transactions
# library("foreign")
# library("plyr")
# 
# 
# split_calls=function(df)
# {
# return(data.frame(called=unlist(strsplit(df$fqCalls, " "))))
# }
# 
# 
# drool=read.arff(paste0(ESEUR_dir, "odds-and-ends/drools.arff"))
# 
# d=ddply(drool, .(fqCaller), split_calls)
# 
# write.csv(d, file="drools.csv.xz", row.names=FALSE)


drools=read.transactions(paste0(ESEUR_dir, "odds-and-ends/drools.csv.xz"),
			format="single", cols=c(1, 2))

rules=apriori(drools, parameter=list(support=0.0001, confidence=0.1))

# cex=1.2 has no effect, reported some problems
plot(rules, control=list(main=""), method="two-key plot")

