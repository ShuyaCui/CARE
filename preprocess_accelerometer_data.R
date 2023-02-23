library(lubridate)

act_file_path = './simulation_data'
act_files = list.files(act_file_path, full.names=FALSE, recursive=TRUE)
act_data_list = list()
for (i in 1:length(act_files)){
  file = act_files[i]
  data = read.csv(paste(act_file_path, file, sep='/'), header=TRUE,
                  colClasses = c("character","numeric"), col.names=c("time","act"))
  data$time = as.POSIXct(data$time)
  act_data_list[[file]] = data
}
save(act_data_list, file="act_data_list.RData")
