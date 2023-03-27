# Circadian Activity Rhythm Energy (CARE)

## Software requirement
All analysis were implemented in R4.1.2. 
R packages used in this study are available from CRAN (https://cran.r-project.org/web/packages/available_packages_by_name.html), including:
- **Rssa**
- **lubridate**

##  Data requirement
###  Individual accelerometer  data
Individual accelerometer records should be saved in a csv file, with two columns, i.e., time and activity. In the **simulation_data** folder, we provided 7 simulated samples of accelerometer data. 

## Running analysis
### Preprocess accelerometer data
**preprocess_accelerometer_data.R**: Rscript to preprocess individual accelerometer records into a list of activity data frames;

### Calculate CARE
**CARE_calculation.R**: Rscript to calculate CARE and relative amplitude based on preprocessed accelerometer data list.

### Plot the raw activity signal and SSA subsignals
**plot_SSA_subsignals.R**: Rscript to plot raw activity signal and SSA subsignals from the preprocessed accelerometer data.
