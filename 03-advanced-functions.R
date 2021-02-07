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
by_stim_graph <- function(ds, stim_name, save_file = FALSE) {
  ds %>% filter(stim == stim_name) %>% 
    ggplot(aes(x = age_group, y = AUC_sal)) + 
    geom_hline(yintercept = 0.5) +
    geom_boxplot() + 
    ggtitle(stim_name) + 
    ylim(0,1) + 
    xlab("Age Group") +
    ylab("Saliency AUC") +
    theme_minimal()
  #USE AN IF STATEMENT TO HANDLE THE SAVE ARGUMENT
  #If save file is T, run the code, otherwise don't
  if (save_file == T) {
    file_name <- paste0("eda/",stim_name,".png")
    ggsave(file_name)
    print(paste("Wrote file", file_name))
  }
}
by_stim_graph(ds, "Feist")
by_stim_graph(ds, "Feist", save_file = T)

#if statements help control the flow of your function
if (condition == T) {
  #Do the stuff here
} else {
  #Do the stuff here
}


#Can we make the function EVEN more flexible?
#Make stim_name an optional argument. If it's supplied, filter by stim. If not, graph all data
auc_boxplot <- function(df, stim_name = NULL, save_file = FALSE) {
  if (!is.null(stim_name)) {
    ds <- ds %>% filter(stim == stim_name)
  } else {
    stim_name <- "Overall"
  }
  
  p <- ds %>% 
    ggplot(aes(x = age_group, y = AUC_sal)) + 
    geom_hline(yintercept = 0.5) +
    geom_boxplot() + 
    ggtitle(stim_name) + 
    ylim(0,1) + 
    xlab("Age Group") +
    ylab("Saliency AUC") +
    theme_minimal()
  
  if (save_file == T) {
    file_name <- paste0("eda/",stim_name,".png")
    ggsave(file_name, plot = p)
    print(paste("Wrote file", file_name))
  }
  return(p)
}
auc_boxplot(ds)
auc_boxplot(ds, stim = "Plane")
auc_boxplot(ds, save_file = T)
