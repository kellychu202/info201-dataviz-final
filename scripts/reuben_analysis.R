library(dplyr)
library(ggplot2)
library(lintr)
library(maps)
library(plotly)
library(leaflet)
library(styler)

# Analysis of spotify top 50 dataset
top_50_data <- read.csv(
  "./data/spotify_top50_by_country.csv",
  stringsAsFactors = FALSE
)

leaflet() %>%
  addProviderTiles("CartoDB.Positron")

country_summaries <- top_50_data %>%
  filter(!is.na(bpm)) %>%
  group_by(country) %>%
  summarise(
    avg_bpm = mean(bpm, narm = TRUE),
    "Average Energy Level" = mean(nrgy)
  ) %>%
  arrange(desc(avg_bpm))
country_summaries$country <- factor(
  country_summaries$country,
  levels = country_summaries$country
)

country_bpm_chart <- ggplotly(
  ggplot(data = country_summaries) +
    geom_bar(
      mapping = aes(
        x = country, y = avg_bpm, fill = `Average Energy Level`, text = country
      ), stat = "identity",
      width = 1
    ) +
    coord_cartesian(ylim = c(105, 140)) +
    theme(axis.text.x = element_blank()) +
    xlab("Country (hover to view)") +
    ylab("Average BPM"),
  tooltip = "text"
)
