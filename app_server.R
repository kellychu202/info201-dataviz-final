#Here lies the sever. Travellers beware...
library(dplyr)
library(shiny)
library(plotly)
source("scripts/reuben_analysis.R")


server <- function(input, output){
  output$scatter_column <- renderText({
   list <- input$scatter_column_selector
   return(list)
  })
}