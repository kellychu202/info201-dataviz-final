library(dplyr)

dataset <- read.csv("./data/spotify_top50_by_country.csv",
                    stringsAsFactors = FALSE)

get_summary_info <- function(dataset) {
  info <- list()
  CapStr <- function(y) {
    c <- strsplit(y, " ")[[1]]
    paste(toupper(substring(c, 1, 1)), substring(c, 2),
          sep = "", collapse = " ")
  }
  info$number_rows <- nrow(dataset)
  info$loudest_song <- dataset %>%
    filter(!is.na(dB)) %>%
    filter(dB == min(dB)) %>%
    pull(title)
  info$song_highest_energy <- dataset %>%
    filter(!is.na(nrgy)) %>%
    filter(nrgy == max(nrgy)) %>%
    pull(title)
  info$max_danceability_country <- dataset %>%
    group_by(country) %>%
    filter(!is.na(dnce)) %>%
    summarize(dnce_avg = mean(dnce)) %>%
    filter(dnce_avg == max(dnce_avg)) %>%
    pull(country) %>%
    CapStr()
  info$max_loudness_country <- dataset %>%
    group_by(country) %>%
    filter(!is.na(dB)) %>%
    summarize(dB_avg = mean(dB)) %>%
    filter(dB_avg == max(dB_avg)) %>%
    pull(country) %>%
    CapStr()
  return(info)
}

summary <- get_summary_info(dataset)
