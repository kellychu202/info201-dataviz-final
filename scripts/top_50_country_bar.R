library(dplyr)
library(ggplot2)
library(lintr)
library(maps)
library(plotly)
library(leaflet)
library(styler)

top50_by_country <- read.csv(
  "data/spotify_top50_by_country.csv",
  stringsAsFactors = FALSE
)

# Use most_common_string to create a new df grouped by country, with the most
# popular genre in each country, and the average bpm for the music in
# that country.
most_common_string <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

interactive_bar <- function(yr){
  genre_by_country_df <- top50_by_country %>%
   group_by(country, year) %>%
    summarize(
      most_common_genre = most_common_string(top.genre)
    )
  
  genre_by_year_df <- genre_by_country_df %>%
    filter(year == yr)
  
  genre_country_year <- genre_by_year_df %>%
    group_by(most_common_genre) %>%
    summarize(
      number_countries = n()
    )
 
  bar_year_country <- ggplot(data = genre_country_year,
                             aes(x = most_common_genre,
                                 y = number_countries,
                                 fill = most_common_genre)) +
    geom_bar(stat = "identity") +
    xlab("Genres") + ylab("Number of Countries") +
    ggtitle("Worldwide popularity of a genre")
  return(bar_year_country)
}
