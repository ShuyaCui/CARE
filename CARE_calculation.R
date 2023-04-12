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
    idx_24hr = c()
    for(j in 2:length(contributions(s.act))){
         if(abs(period_estimate(s.act,j)-1440) < 10){
           idx_24hr = c(idx_24hr, j)
         }
    }
    ssa_care0[i] = sum(contributions(s.act)[idx_24hr])
   # energy of behavioral noise
    ssa_behavioral_energy[i] = sum(contributions(s.act)[-c(1,idx_24hr)])
}
res = cbind(ssa_care0, ssa_behavioral_energy, npar_act)
res = as.data.frame(res)
colnames(res) = c("CARE", "SSA_behavioral_energy","IS", "IV", "RA", "L5", "L5_starttime", "M10", "M10_starttime")
write.csv(res, file="./results/example.csv", row.names=T)
