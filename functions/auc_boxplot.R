# auc_boxplot function, John Franchak, 2/7/2021
# Creates boxplots of AUC values by age group
# Input arguments:
  # df = a study data frame containing age_group, AUC_sal, and stim
  # stim_name (optional) = a string containing the name of a stimulus to plot; will plot overall if not included
  # save_file = a boolean indicating whether to save the resulting plot
# Return values: 
  # p = the resulting ggplot object

auc_boxplot <- function(df, stim_name = NULL, save_file = FALSE) {
  stopifnot(is.logical(save_file))
  stopifnot(is.null(save_file) | is.character(save_file))
  
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