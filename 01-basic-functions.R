library(tidyverse)

paths <- c("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv",
           "https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv",
           "https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
ds_map <- map_dfr(paths, read_csv)
ds_longer <- pivot_longer(ds_map, Male:Female, names_to = "Sex", values_to = "Words")


#Functions have 4 parts: a function name (what you call to use the function), an argument list (inputs)
# a body (where calculations are made), and an output. Typically, the output is the last line of the body

function_name <- function(input1, input2) {
  #THIS IS THE BODY
}




words_graph <- function(df) {
  p <- ggplot(df, aes(x = Race, y = Words, fill = Sex)) + 
    geom_bar(stat = "identity", position = "dodge") + 
    ggtitle(df$Film) + theme_minimal()
  print(p)
}

split(ds_longer.$Film) %>% map(words_graph)