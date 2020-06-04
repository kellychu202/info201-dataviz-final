#Here lies the sever. Travellers beware...
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
library(lintr)
library(maps)
library(leaflet)
library(styler)

source("scripts/reuben_analysis.R")
source("scripts/world_2010s_analysis.R")
source("scripts/interactive_map_analysis.R")

server <- function(input, output){
  output$scatterplot <- renderPlotly({
    plot <- scatter_function(input$scatter_country_selector)
    return(plot)
  })
  
  output$piechart <- renderPlotly({
    chart <- genre_year(world_top2010, input$selected_year)
    return(chart)
  })
  
  output$worldmap <- renderLeaflet({
    map <- interactive_map(top50_by_country)
    return(map)
  })
  
}
