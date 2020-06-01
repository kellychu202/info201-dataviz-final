#Here lies the sever. Travellers beware...
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)
source("scripts/reuben_analysis.R")


server <- function(input, output){
  output$scatterplot <- renderPlot({
  })
}