library(Rssa)
load("./nPar_calculation.R")
# load the activity data
load("./act_data_list.RData")
# # ###############################################
# # calculate nonparametric variables
npar_act = matrix(NA, nrow = length(act_data_list), ncol = 7)
for (i in 1:length(act_data_list)){
  act = act_data_list[[i]]
  npar_act[i,] = unlist(nparACT_base(act$activity,1/60,plot=F))
}
colnames(npar_act) = c("IS", "IV", "RA", "L5", "L5_starttime", "M10", "M10_starttime")
npar_act = as.data.frame(npar_act)

# calculate CARE by SSA
ssa_care0 = c()
ssa_behavioral_energy = c()
for (i in 1:length(act_data_list)){
    act = act_data_list[[i]]
    # SSA circadian component
    s.act = ssa(act$activity, L = 1440, kind = "1d-ssa")
    ssa_care0[i] = sum(contributions(s.act)[2:3])
   # energy of behavioral noise
    ssa_behavioral_energy = sum(contributions(s.act)[4:length(contributions(s.act))])
}
# calibrate CARE_0 by gamma, here gamma = scaled maximum activity intensity
gamma = npar_act$M10/max(npar_act$M10, na.rm = T)
ssa_care1 = ssa_care0/gamma

write.csv(ssa_care0, file="./results/CARE_0.csv", row.names=F)
write.csv(ssa_care1, file="./results/CARE_1.csv", row.names=F)
write.csv(npar_act, file="./results/nonparametric_variables.csv", row.names=F)
