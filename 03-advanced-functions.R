library(tidyverse)

ds <- read_csv("data_cleaned/cleaned.csv")

#Making this graph for each subset duplicates a lot of code!
#It's also hard to remember to update the title and filter (two different places)
ds %>% filter(stim == "Feist") %>% 
  ggplot(aes(x = age_group, y = AUC_sal)) + 
  geom_hline(yintercept = 0.5) +
  geom_boxplot() + 
  ggtitle("Feist") + 
  ylim(0,1) + 
  xlab("Age Group") +
  ylab("Saliency AUC") +
  theme_minimal()

ds %>% filter(stim == "Dogs") %>% 
  ggplot(aes(x = age_group, y = AUC_sal)) + 
  geom_hline(yintercept = 0.5) +
  geom_boxplot() + 
  ggtitle("Dogs") + 
  ylim(0,1) + 
  xlab("Age Group") +
  ylab("Saliency AUC") +
  theme_minimal()

#Let's write this as a function
by_stim_graph <- function(ds, stim_name) {
  ds %>% filter(stim == stim_name) %>% 
    ggplot(aes(x = age_group, y = AUC_sal)) + 
    geom_hline(yintercept = 0.5) +
    geom_boxplot() + 
    ggtitle(stim_name) + 
    ylim(0,1) + 
    xlab("Age Group") +
    ylab("Saliency AUC") +
    theme_minimal()
}
by_stim_graph(ds, "Feist")
by_stim_graph(ds, "Dogs")

#Makes this much more "mappable" too
map(c("Feist","Dogs","Plane","Science"), ~ by_stim_graph(ds, .x))

#Can we make the function more flexible?
#Make save_file an argument with a default of "FALSE"
#Assigning a value to an argument with "=" sets the defaul
by_stim_graph <- function(ds, stim_name, save_file = FALSE) {
  #Part1: Make the graph
  p <- ds %>% filter(stim == stim_name) %>% 
    ggplot(aes(x = age_group, y = AUC_sal)) + 
    geom_hline(yintercept = 0.5) +
    geom_boxplot() + 
    ggtitle(stim_name) + 
    ylim(0,1) + 
    xlab("Age Group") +
    ylab("Saliency AUC") +
    theme_minimal()
  
  #Part2: Save the graph if save_file == T
  #USE AN IF STATEMENT TO HANDLE THE SAVE_FILE ARGUMENT
  #If save file is T, run the code, otherwise don't
  if (save_file == T) {
    file_name <- paste0("eda/",stim_name,".png")
    ggsave(file_name, plot = p)
    print(paste("Wrote file", file_name))
  }
  print(p)
}
by_stim_graph(ds, "Feist")
by_stim_graph(ds, "Feist", save_file = T)

#Can we make the function even more flexible?
#Make stim_name an optional argument. If it's supplied, filter by stim. If not, graph all data
auc_boxplot <- function(df, stim_name = NULL, dv_name, save_file = FALSE) {
  #Part1: Check the input
  stopifnot("ERROR: save_file must be logical" = is.logical(save_file))
  
  #Part2: Filter dataset if a stim is included, otherwise "overall"
  if (!is.null(stim_name)) {
    ds <- ds %>% filter(stim == stim_name)
  } else {
    stim_name <- "Overall"
  }
  
  #Part3: Make the graph and save it to p
  p <- ds %>% 
    ggplot(aes(x = age_group, y = {{dv_name}})) + 
    geom_hline(yintercept = 0.5) +
    geom_boxplot() + 
    ggtitle(stim_name) + 
    ylim(0,1) + 
    xlab("Age Group") +
    ylab("Saliency AUC") +
    theme_minimal()
  
  #Part4: Save the graph if save_file is TRUE
  if (save_file == T) {
    file_name <- paste0("eda/",stim_name,".png")
    ggsave(file_name, plot = p)
    print(paste("Wrote file", file_name))
  }
  
  #Part5: Return the graph
  return(p)
}

auc_boxplot(ds, dv_name = AUC_dist)
auc_boxplot(ds, stim = "Plane")
auc_boxplot(ds, save_file = T)
auc_boxplot(ds, save_file = "yes") 
