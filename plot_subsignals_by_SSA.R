# The variable "act" is a vector of activity counts every 60 seconds
s.act = ssa(act, L = 1440, kind = "1d-ssa")
base = Rssa::reconstruct(s.act, groups = list(1))
cc <- Rssa::reconstruct(s.act, groups = list(c(2,3)))
cc <- cc$F1 + base$F1
cc_1 <- Rssa::reconstruct(s.act, groups = list(4:50))
cc_1 <- cc_1$F1 + base$F1

tmp = cbind(rep((1:1440)/1440,3), c(act[1441:2880], cc[1441:2880], cc_1[1441:2880]),c(rep("1", 1440),rep("2",1440),rep("3",1440)))
tmp = as.data.frame(tmp)
colnames(tmp) = c("time","signal","group")
tmp = cbind((1:1440)/1440, act[1441:2880], cc[1441:2880], cc_1[1441:2880])
tmp = as.data.frame(tmp)
colnames(tmp) = c("time","act","circadian","noise")
pdf("figure2b.pdf")
ggplot(tmp, aes(x=time))+geom_smooth(aes(y = circadian, color="circadian"),se=F) + geom_smooth(aes(y = noise, color="noise"),se=F) + geom_line(aes(y = act, color="act")) +scale_color_manual(values = c("circadian" = 'blue', "noise" = "green", "act" = "#6699CC")) + xlab("Time (h)") + ylab("Accelerometer activity count") + theme_classic() + theme(panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.text.x=element_blank(), axis.text.y=element_blank(), axis.title.x=element_text(size=16), axis.title.y=element_text(size=16),plot.margin = unit(c(0.2, 1, 0.2, 0.2), "cm"))
dev.off()
