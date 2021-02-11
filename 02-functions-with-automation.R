library(tidyverse)

ds <- read_csv("data_cleaned/cleaned.csv")
ds_wider <- pivot_wider(ds, id_cols = c("id","age","age_group"), names_from = "stim", values_from = c("AUC_sal", "AUC_dist"))

#No built in summary fx for standard error
ds_wider %>% group_by(age_group) %>% 
  summarize(AUC_Feist_SE = sd(AUC_sal_Feist)/sqrt(length(AUC_sal_Feist)))

#this gets really clunky, especially if we want to include a list of functions
ds_wider %>% group_by(age_group) %>% 
  summarize(across(starts_with("AUC"), ~ sd(.x)/sqrt(length(.x))))

#Why don't we just write our own se function to call
#We can also choose to discard na by default
na_se <- function(x) {
  x <- discard(x, is.na) #discard is like "filter if not" for vectors
  sd(x)/sqrt(length(x))
}

ds_wider %>% group_by(age_group) %>% 
  summarize(across(starts_with("AUC"), na_se))

#Why stop there?
#Let's make a whole set of "na" summary functions
na_mean <- function(x) mean(x, na.rm = T) #If your function fits on one line, you can drop the {}
na_sd <- function(x) sd(x, na.rm = T)
fx_list <- list(M = na_mean, SD = na_sd, SE = na_se)

ds_wider %>% group_by(age_group) %>% 
  summarize(across(starts_with("AUC"), fx_list))

#Can embed your own fxs within fxs
summary_stats <- function(df, var_select_string) {
  na_mean <- function(x) mean(x, na.rm = T)
  na_sd <- function(x) sd(x, na.rm = T)
  na_se <- function(x) {
    x <- discard(x, is.na)
    sd(x)/sqrt(length(x))
  }
  fx_list <- list(M = na_mean, SD = na_sd, SE = na_se)

  df  %>%
    summarize(across(contains(var_select_string) & where(is.numeric), fx_list))
}

ds_wider %>% summary_stats("AUC")
ds_wider %>% summary_stats("Feist")
ds_wider %>% summary_stats("age") #Grabs "age" and "age_group" (factor)
ds_wider %>% group_by(age_group) %>% summary_stats("Feist")
