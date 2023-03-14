library(Rssa)
source("./nPar_calculation.R")
# load the activity data
load("./act_data_list.RData")
# # ###############################################
# # calculate nonparametric variables
npar_act = matrix(NA, nrow = length(act_data_list), ncol = 7)
for (i in 1:length(act_data_list)){
  act = act_data_list[[i]]
  npar_act[i,] = unlist(nparACT_base(act,1/60,plot=F))
}
colnames(npar_act) = c("IS", "IV", "RA", "L5", "L5_starttime", "M10", "M10_starttime")
npar_act = as.data.frame(npar_act)

# calculate CARE by SSA
ssa_care0 = c()
ssa_behavioral_energy = c()
for (i in 1:length(act_data_list)){
    act = act_data_list[[i]]
    # SSA circadian component
    s.act = ssa(act$act, L = 1440, kind = "1d-ssa")
    ssa_care0[i] = sum(contributions(s.act)[2:3])
   # energy of behavioral noise
    ssa_behavioral_energy = sum(contributions(s.act)[4:length(contributions(s.act))])
}

write.csv(ssa_care0, file="./results/CARE_0.csv", row.names=F)
write.csv(npar_act, file="./results/nonparametric_variables.csv", row.names=F)
