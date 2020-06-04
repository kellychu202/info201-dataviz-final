library(dplyr)
library(ggplot2)
library(lintr)
library(maps)
library(plotly)
library(leaflet)
library(styler)
library(RColorBrewer)

# Analysis of spotify top 50 dataset
top_50_data <- read.csv(
  "./data/spotify_top50_by_country.csv",
  stringsAsFactors = FALSE
)

scatter_function <- function(countries){
  selected_countries <- top_50_data %>%
    filter(is.element(country, countries))
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
  country_scatterplot <- ggplotly(
    ggplot(data = selected_countries) +
    geom_point(
      mapping = aes(
        x = bpm,
        y = nrgy,
        color = country,
        text = paste(ifelse(country != "israel",
                            paste("Title:", title),
                            "Cannot Display Hebrew Characters"),
                     paste("Artist:", artist),
                     paste("Region:", country),
                     sep = "<br>")
      ),
      position = "jitter",
    ) +
    #scale_color_brewer(palette = "Dark2") +
    ggtitle("BPM and Energy of Top 50 Songs") +
    xlab("Speed (Beats Per Minute)") +
    ylab("Energy Level") +
    theme_minimal() +
    labs(color = "Region"),
    tooltip = "text"
  )
  return(country_scatterplot)
}

scatter_function(c("usa", "brazil", "israel", "malasya"))



chart_function <- function(df) {
  country_summaries <- df %>%
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
          x = country, y = avg_bpm, fill = `Average Energy Level`,
          text = paste0(toupper(country), ", BPM = ", avg_bpm)
        ), stat = "identity", color = "white", size = .1,
        width = 1
      ) +
      coord_cartesian(ylim = c(105, 140)) +
      theme_minimal() +
      theme(
        axis.text.x = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_line(size = .1, color = "gray")
      ) +
      ggtitle("Average Speed and Energy of Top 50 Songs by Country") +
      xlab("Country (hover to view)") +
      ylab("Average BPM"),
    tooltip = "text"
  )
  return(country_bpm_chart)
}
chart_function(top_50_data)
