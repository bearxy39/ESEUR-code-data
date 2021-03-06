#
# spec-cache.R, 23 Nov 17
#
# Data from:
# Improving Accuracy of Software Performance Models on Multicore Platforms with Shared Caches
# Vlastimil Babka
# Code adapted from that kindly provided by: Vlastimil Babka
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_cpu-cache performance_model benchmark_improve cpu_multicore

source("ESEUR_config.r")


# par(fin=c(4.5, 3.5))

isol=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_isol_means.tbl"), sep=" ", as.is=TRUE)
hit=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_hit_means.tbl"), sep=" ", as.is=TRUE)
miss=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_miss_means.tbl"), sep=" ", as.is=TRUE)
cap=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_cap_means.tbl"), sep=" ", as.is=TRUE)
mem=read.csv(paste0(ESEUR_dir, "benchmark/babkatuma/tbl_mem_miss_means.tbl"), sep=" ", as.is=TRUE)

pal_col=rainbow(4)


ordr=order(-isol$L2_LINES_IN.SELF.ALL/isol$time)


barplot(rbind(hit$time[ordr]/isol$time[ordr]*100-100,
		miss$time[ordr]/isol$time[ordr]*100-100,
		cap$time[ordr]/isol$time[ordr]*100-100,
		mem$time[ordr]/isol$time[ordr]*100-100),
	beside=TRUE, col=pal_col, border=NA, cex.names=0.95,
	ylab="Slowdown percentage\n",
	names.arg=apply(t(isol$benchmark[ordr]), 1, substring,1,8), las=2,
	args.legend=list(x="topright", bty="n", cex=1.2),
	legend.text=c("shared cache: Hits",
			"shared cache: Conflict misses",
			"shared cache: Capacity misses",
			"shared memory bus: Accesses"))


