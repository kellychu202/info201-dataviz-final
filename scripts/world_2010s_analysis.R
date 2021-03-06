library(dplyr)
library(ggplot2)
library(plotly)
library(stringr)
library(styler)
library(lintr)

world_top2010 <- read.csv("./data/top_2010s.csv", stringsAsFactors = FALSE)

consolidate_genres <- function(dataset) {
  # consolidate genres
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
  # group by genre and year
  all_genres <- dataset %>%
    group_by(genre = top.genre, year) %>%
    summarize(total = sum(n(), na.rm = TRUE))
  return(all_genres)
}

# piechart of genres by year
genre_year <- function(dataset, selected_year) {
  all_genres <- consolidate_genres(dataset)
  # find the genres that correspond to selected year
  summary_genres <- all_genres %>%
    filter(year == selected_year)
  # plot pie chart of genre of selected year
  genre_by_year <- plot_ly(
    data = summary_genres, values = ~total, labels = ~genre, type = "pie",
    textposition = "inside",
    textinfo = "label+percent",
    insidetextfont = list(color = "#FFFFFF"),
    hoverinfo = "text+percent",
    text = ~ paste("Genre:", genre, "<br>", "Song Count:", total)
  ) %>%
    layout(
      title = paste("Popular Genres in", selected_year)
    )

  return(genre_by_year)
}

# corresponding top songs of selected year (genres not cleaned)
top_songs <- function(dataset, selected_year) {
  if (selected_year == "the 2010s") {
    songs <- dataset %>%
      select(
        "Song" = title,
        "Artist" = artist,
        "Year" = year,
        "Genre*" = top.genre
      )
  } else {
    songs <- dataset %>%
      filter(year == selected_year) %>%
      select("Song" = title, "Artist" = artist, "Genre*" = top.genre)
  }
  return(songs)
}

top2010_pie_chart <- function(dataset) {
  all_genres <- consolidate_genres(dataset)
  # group all genres together (getting rid  of year)
  summary_genres <- all_genres %>%
    group_by(genre) %>%
    summarize(total = sum(total, na.rm = TRUE))
  # outliers are genres with only one top song in a year
  summary_genres$genre[summary_genres$total < 4] <- "misc."
  genres_2010s <- summary_genres %>%
    group_by(genre) %>%
    summarize(total = sum(total, na.rm = TRUE))
  genre_2010s <- plot_ly(
    data = genres_2010s, values = ~total, labels = ~genre, type = "pie",
    textposition = "inside",
    height = 425,
    textinfo = "label+percent",
    insidetextfont = list(color = "#FFFFFF"),
    hoverinfo = "text+percent",
    text = ~ paste("Genre:", genre, "<br>", "Song Count:", total)
  ) %>%
    layout(title = "Popular Genres of 2010-2019")
  return(genre_2010s)
}
