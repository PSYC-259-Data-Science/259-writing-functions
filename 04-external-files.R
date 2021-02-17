rm(list = ls())
library(tidyverse)

#All we need to do to load external files is call "source"
source("functions/auc_boxplot.R")

ds <- read_csv("data_cleaned/cleaned.csv")

#Use the external function
auc_boxplot(ds)
auc_boxplot(ds, stim_name = "Feist")
auc_boxplot(ds, stim_name = "Dogs", save_file = T)

#What if you have multiple functions and you want to load them all?
fx_list <- list.files(path = "functions", pattern = ".R", full.names = T)
map(fx_list, source)

#You can also put them all in one file
#but that gets messy unless they're short and thematically related

#Just remember that changes to your function won't take effect 
#until they are sourced!
#Checking source-on-save can save some headaches