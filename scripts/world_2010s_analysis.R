# proper labels/titles/legends
# intentional chart type and encoding selection based on the question of
# interest and data type
# report: why this chart (what does it express)
#         what does it reveal

library(dplyr)
library(ggplot2)
library(plotly)
library(stringr)
library(styler)
library(lintr)

world_top2010 <- read.csv("./data/top_2010s.csv", stringsAsFactors = FALSE)

top2010_pie_chart <- function(dataset) {
  # sum all the unique genres
  all_genres <- dataset %>%
    group_by(genre = top.genre) %>%
    summarize(total = sum(n(), na.rm = TRUE))

  # consolidate genres
  all_genres$genre[
    str_detect(all_genres$genre, "hip") |
      str_detect(all_genres$genre, "rap")
  ] <- "hip hop"
  all_genres$genre[str_detect(all_genres$genre, "r&b")] <- "rnb"
  all_genres$genre[str_detect(all_genres$genre, "house")] <- "house"
  all_genres$genre[str_detect(
    all_genres$genre, "edm"
  ) |
    str_detect(all_genres$genre, "big room") |
    str_detect(all_genres$genre, "electro") |
    str_detect(all_genres$genre, "complextro")] <- "edm"
  all_genres$genre[str_detect(all_genres$genre, "indie")] <- "indie"
  all_genres$genre[str_detect(all_genres$genre, "latin")] <- "latin"
  all_genres$genre[str_detect(all_genres$genre, "pop") &
    all_genres$genre != "dance pop"] <- "pop"
  # outliers are genres with only one top song in a year
  all_genres$genre[all_genres$total < 4] <- "misc."

  summary_genres <- all_genres %>%
    group_by(genre) %>%
    summarize(total = sum(total, na.rm = TRUE))

  genre_2010s <- plot_ly(
    data = summary_genres, values = ~total, labels = ~genre, type = "pie",
    textposition = "inside",
    textinfo = "label+percent",
    insidetextfont = list(color = "#FFFFFF"),
    hoverinfo = "text+percent",
    text = ~ paste("Genre:", genre, "<br>", "Song Count:", total)
  ) %>%
    layout(title = "Popular Genres 2010-2019")
  return(genre_2010s)
}

