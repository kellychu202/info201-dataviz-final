library(dplyr)

dataset <- read.csv("./data/spotify_top50_by_country.csv", stringsAsFactors = FALSE)

get_summary_info <- function(dataset) {
  info <- list()
  info$colnames <- colnames(dataset)
  info$number_rows <- nrow(dataset)
  info$song_highest_energy <- dataset %>%
    filter(!is.na(nrgy)) %>%
    filter(nrgy == max(nrgy)) %>%
    pull(title)
  info$danceability_by_country <- dataset %>%
    group_by(country) %>%
    filter(!is.na(dnce)) %>%
    summarize(dnce_avg = mean(dnce)) %>%
    arrange(-dnce_avg)
  info$loudness_by_country <- dataset %>%
    group_by(country) %>%
    filter(!is.na(dB)) %>%
    summarize(dB_avg = mean(dB)) %>%
    arrange(-dB_avg) 
  return(info)
}


summary <- get_summary_info(dataset)
