library(dplyr)
library(ggplot2)
library(lintr)
library(maps)
library(plotly)
library(leaflet)
library(styler)

top50_by_country <- read.csv(
  "./data/spotify_top50_by_country.csv",
  stringsAsFactors = FALSE
)

# Function to find the most common string/genre type in top.genre,
# for a given country
interactive_map <- function(dataset) {
  most_common_string <- function(x) {
    ux <- unique(x)
    ux[which.max(tabulate(match(x, ux)))]
  }
  # Use most_common_string to create a new df grouped by country, with the most
  # popular genre in each country, and the average bpm for the music in
  # that country.
  genre_by_country_df <- dataset %>%
    group_by(country) %>%
    summarize(
      most_common_genre = most_common_string(top.genre),
      average_bpm = mean(bpm)
    )


  # Manually adding latitude/longitude data for each country in the df.
  genre_by_country_df$latitude <- c(
     6.887755,
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
  genre_by_country_df$longitude <- c(
    20.277958,
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
      radius = ~ average_bpm * 2000,
      popup = ~most_common_genre
    )
  return(interactive_map)
}

lat_long <- vector(mode="list", length = 20)
names(lat_long) <- c("africa", "argentina", "australia", "belgium",
                     "bolivia", "brazil", "canada", "germany",
                     "colombia", "chile", "spain", "usa", "france",
                     "india", "indonesia", "israel", "italy", "japan",
                     "malaysa", "world"
                     )
lat_long[[1]] <- c(6.887755, 20.277958)
lat_long[[2]] <- c(-33.761676, -65.988583)
lat_long[[3]] <- c(-26.609699, 133.290891)
lat_long[[4]] <- c(50.781369, 4.416280)
lat_long[[5]] <- c(-17.246193, -64.838269)
lat_long[[6]] <- c(-11.558803, -52.636267)
lat_long[[7]] <- c(57.123296, -110.419892)
lat_long[[8]] <- c(-33.459535, -70.631214)
lat_long[[9]] <- c(4.456372, -73.323049)
lat_long[[10]] <- c(48.601190, 2.354039)
lat_long[[11]] <- c(50.057343, 9.044510)
lat_long[[12]] <- c(28.625053, 77.123134)
lat_long[[13]] <- c(-6.198393, 106.848708)
lat_long[[14]] <- c(32.078374, 34.776839)
lat_long[[15]] <- c(41.889017, 12.488693)
lat_long[[16]] <- c(35.680875, 139.759581)
lat_long[[17]] <- c(3.097368, 101.680072)
lat_long[[18]] <- c( 40.406270, -3.680031)
lat_long[[19]] <- c(38.909920, -77.023774)
lat_long[[20]] <- c(40.258674, -38.624665)




