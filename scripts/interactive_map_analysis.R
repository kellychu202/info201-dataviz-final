library(dplyr)
library(ggplot2)
library(lintr)
library(maps)
library(plotly)
library(leaflet)
library(styler)


top50_by_country <- read.csv("./spotify_top50_by_country.csv", stringsAsFactors = FALSE)

# Function to find the most common string/genre type in top.genre, for a given country
most_common_string <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Use most_common_string to create a new df grouped by country, with the most
# popular genre in each country, and the average bpm for the music in
# that country.
genre_by_country_df <- top50_by_country %>%
  group_by(country) %>%
  summarize(most_common_genre = most_common_string(top.genre),
            average_bpm = mean(bpm))

# Manually adding latitude/longitude data for each country in the df. 
genre_by_country_df$latitude <- c(6.887755,
                                  -33.761676,
                                  -26.609699, 
                                  50.781369, 
                                  -17.246193, 
                                  -11.558803, 
                                  57.123296,
                                  -33.459535, 
                                  4.456372, 
                                  48.601190,
                                  50.057343,
                                  28.625053, 
                                  -6.198393, 
                                  32.078374, 
                                  41.889017, 
                                  35.680875, 
                                  3.097368, 
                                  40.406270,
                                  38.909920, 
                                  40.258674
                                  )
genre_by_country_df$longitude <- c(20.277958,
                                   -65.988583,
                                   133.290891,
                                   4.416280,
                                   -64.838269,
                                   -52.636267,
                                   -110.419892,
                                   -70.631214,
                                   -73.323049,
                                   2.354039,
                                   9.044510,
                                   77.123134,
                                   106.848708,
                                   34.776839,
                                   12.488693,
                                   139.759581,
                                   101.680072,
                                   -3.680031,
                                   -77.023774,
                                   -38.624665
                                   )

interactive_map <- leaflet(data = genre_by_country_df) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addCircles(
    lat = ~latitude,
    lng = ~longitude,
    stroke = FALSE,
    radius = ~average_bpm*2000,
    popup = ~most_common_genre
  )

  
  