#
# platforms.R, 11 Sep 19
# Data from:
# Plat_Forms 2007: {The} Web Development Platform Comparison -- Evaluation and Results
# Lutz Prechelt
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_developer requirements performance_developer team_performance

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(3)

# Meaning of classification column
#•G: source text generated fully automatically by some tool
# R: source text reused as is (that is, whole files reused without modification)
# GM: source text generated by some tool and then modified by hand
# RM: source text reused with some modifications
# M: source text written manually

sum_manual_LOC=function(df)
{
# Count what we know for certain
t=subset(df, classification == "M")
return(data.frame(language=df$language[1],
		  total=sum(t$totalLOC, na.rm=TRUE),
                  comment=sum(t$commentLOC, na.rm=TRUE),
                  statement=sum(t$statementLOC, na.rm=TRUE),
                  empty=sum(t$emptyLOC, na.rm=TRUE),
			stringsAsFactors=FALSE))
}


tot_team_req=function(df)
{
t=data.frame(r0=length(which(df$completeness == 0)),
                  r1=length(which(df$completeness == 1)),
                  r2=length(which(df$completeness == 2)),
                  r3=length(which(df$completeness == 3)),
                  r4=length(which(df$completeness == 4)))

# Some teams reviewed more than once, so average
return(t/length(unique(df$reviewer)))
}


fl=read.csv(paste0(ESEUR_dir, "projects/platforms-file.csv.xz"), as.is=TRUE)
rev=read.csv(paste0(ESEUR_dir, "projects/platforms-rev.csv.xz"), as.is=TRUE)

prog_LOC=ddply(subset(fl, role == "prog"), .(team), sum_manual_LOC)

team_req=ddply(rev, .(team), tot_team_req)

req_LOC=merge(prog_LOC, team_req, by="team")

u_lang=unique(req_LOC$language)
req_LOC$col_str=mapvalues(req_LOC$language, u_lang, pal_col)

plot(1, type="n", # log="y",
	xlim=range(req_LOC$r3+req_LOC$r4), ylim=range(req_LOC$total),
	xlab="Requirements fully implemented", ylab="Program LOC\n")

d_ply(req_LOC, .(language), function(df)
				points(df$r3+df$r4, df$total,
						col=df$col_str, lwd=1.4))

legend(x="bottomright", legend=u_lang, bty="n", fill=pal_col, cex=1.2)

