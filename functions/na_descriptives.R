na_mean <- function(x) mean(x, na.rm = T) #If your function fits on one line, you can drop the {}

na_sd <- function(x) sd(x, na.rm = T)

na_se <- function(x) {
  x <- discard(x, is.na) #discard is like "filter if not" for vectors
  sd(x)/sqrt(length(x))
}

na_sum <- function(x) sum(x, na.rm = T)
na_min <- function(x) min(x, na.rm = T)
na_max <- function(x) max(x, na.rm = T)