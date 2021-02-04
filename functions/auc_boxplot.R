# USEFUL HEADER INFORMATION NEEDS TO GO HERE

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
    ggsave(paste0("eda/",stim_name,".png"), plot = p)
  }
  return(p)
}