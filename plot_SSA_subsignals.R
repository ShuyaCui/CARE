#### use data from sample #1 ####
act = act_data_list[[1]]$act
s.act = ssa(act, L = 1440, kind = "1d-ssa")
idx_24hr = c()
for(j in 2:length(contributions(s.act))){
    if(abs(period_estimate(s.act,j)-1440) < 10){
        idx_24hr = c(idx_24hr, j)
     }
}
base = Rssa::reconstruct(s.act, groups = list(1))
base = base$F1
cc <- Rssa::reconstruct(s.act, groups = list(idx_24hr))
cc <- cc$F1
tmp_idx=2:length(contributions(s.act))
cc_1 <- Rssa::reconstruct(s.act, groups = list(tmp_idx[-idx_24hr]))
cc_1 <- cc_1$F1
# Plot the raw activity signal and SSA subsignals on the first day
tmp = cbind((1:1440)/60, act[1:1440], cc[1:1440], cc_1[1:1440], base[1:1440])
tmp = as.data.frame(tmp)
colnames(tmp) = c("time","act","circadian","noise","base")
pdf("SSA subsignals.pdf", height = 6, width = 8)
ggplot(tmp, aes(x=time))+geom_smooth(aes(y = circadian, color="SSA 24-hour signal", lty = "SSA 24-hour signal"), show.legend = TRUE, se=F) + geom_smooth(aes(y = noise, color="SSA noise signal", lty = "SSA noise signal"), show.legend = TRUE, se=F) + geom_smooth(aes(y = base, color="SSA base signal", lty = "SSA base signal"), show.legend = TRUE, se=F) + geom_line(aes(y = act, color="raw activity signal", lty="raw activity signal"), show.legend = TRUE, se=F) + scale_color_manual(values = c("SSA 24-hour signal" = 'blue', "SSA noise signal" = "green", "SSA base signal"="black", "raw activity signal" = "#6699CC")) + scale_linetype_manual(values = c("SSA 24-hour signal" = 'dashed', "SSA noise signal" = "dotted", "SSA base signal"="dotdash", "raw activity signal" = "solid")) + guides(color = guide_legend(override.aes = list(linetype = c("dashed", "dotted", "dotdash", "solid")))) + scale_x_continuous(breaks = c(0, 8, 16, 24), labels =c("0:00","08:00","16:00","24:00"), limits=c(0,24)) + xlab("Time (h)") + ylab("Accelerometer activity count") + theme_classic() + theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.title.x=element_text(size=16), axis.title.y=element_text(size=16),plot.margin = unit(c(0.2, 1, 0.2, 0.2), "cm"))
dev.off()
