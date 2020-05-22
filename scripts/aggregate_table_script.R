# function that takes dataset as parameter
# returns table of aggregate information
# group_by operation 
# well formatted column names
# contain relevant info
# sorted in a meaningful way
# report: describe why this table was included and info
library(stringr)
library(dplyr)
library(knitr)
top_2010s <- read.csv("./data/top_2010s.csv", stringsAsFactors = FALSE)

aggregate_table <- function(dataset){
  # consolidate/clean top.genres
  dataset$top.genre[
    str_detect(dataset$top.genre, "hip") |
      str_detect(dataset$top.genre, "rap")
    ] <- "hip hop"
  dataset$top.genre[str_detect(dataset$top.genre, "r&b")] <- "rnb"
  dataset$top.genre[str_detect(dataset$top.genre, "house")] <- "house"
  dataset$top.genre[str_detect(
    dataset$top.genre, "edm"
  ) |
    str_detect(dataset$top.genre, "big room") |
    str_detect(dataset$top.genre, "electro") |
    str_detect(dataset$top.genre, "complextro")] <- "edm"
  dataset$top.genre[str_detect(dataset$top.genre, "indie")] <- "indie"
  dataset$top.genre[str_detect(dataset$top.genre, "latin")] <- "latin"
  dataset$top.genre[str_detect(dataset$top.genre, "dance")] <- "dance pop"
  dataset$top.genre[str_detect(dataset$top.genre, "pop") &
                     dataset$top.genre != "dance pop"] <- "pop"
  # make aggregate table
  
  aggr_table <- dataset %>%
    group_by(genre = top.genre) %>%
    summarize(
      pop_mean = mean(pop, na.rm = TRUE),
      bpm_mean = mean(bpm, na.rm = TRUE), 
      energy_mean = mean(nrgy, na.rm = TRUE),
      dance_mean = mean(dnce, na.rm = TRUE),
      liveness_mean = mean(live, na.rm = TRUE),
      sum = sum(n())
      ) %>%
    filter(sum > 3) %>%
    arrange(-pop_mean) %>%
    select(!sum)
  
  return(aggr_table)
}

new <- aggregate_table(top_2010s)
