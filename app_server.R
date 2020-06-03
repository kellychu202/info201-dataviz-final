#Here lies the sever. Travellers beware...
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
source("scripts/reuben_analysis.R")
source("scripts/world_2010s_analysis.R")

server <- function(input, output){
  output$scatterplot <- renderPlotly({
    plot <- scatter_function(input$scatter_country_selector)
    return(plot)
  })
  
  output$piechart <- renderPlotly({
    chart <- genre_year(world_top2010, input$selected_year)
    return(chart)
  })
}