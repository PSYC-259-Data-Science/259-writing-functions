library(tidyverse)

ds <- read_csv("data_cleaned/cleaned.csv")
ds_wider <- pivot_wider(ds, id_cols = c("id","age","age_group"), names_from = "stim", values_from = c("AUC_sal", "AUC_dist"))

#Mean doesn't remove NA by default, which gets kind of annoying
ds_wider %>% group_by(age_group) %>% 
  summarize(AUC_sal_Feist_M = mean(AUC_sal_Feist))

ds_wider %>% group_by(age_group) %>% 
  summarize(across(starts_with("AUC"), mean))

#Why don't we just write our own mean function to call that has the defaul we want?
na_mean <- function(x) {
  mean(x, na.rm = T)
}

ds_wider %>% group_by(age_group) %>% 
  summarize(across(starts_with("AUC"), na_mean))

#Why stop there?
na_mean <- function(x) mean(x, na.rm = T) #If your function fits on one line, you can drop the {}
na_sd <- function(x) sd(x, na.rm = T)
na_se <- function(x) {
  x <- discard(x, is.na) #discard is like "filter if not" for vectors
  sd(x)/sqrt(length(x))
}
fx_list <- list(M = na_mean, SD = na_sd, SE = na_se)

ds_wider %>% group_by(age_group) %>% 
  summarize(across(starts_with("AUC"), fx_list))

