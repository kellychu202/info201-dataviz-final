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
    if (input$selected_year == "the 2010s"){
      chart <- top2010_pie_chart(world_top2010)
    } else {
    chart <- genre_year(world_top2010, input$selected_year)
    return(chart)
    }
  })
  
  output$song_table_title <- renderText({
    paste("Top Songs of", input$selected_year)
  })
  
  output$table <- renderTable({
    songs <- top_songs(world_top2010, input$selected_year)
    return(songs)
  }, caption = "*Genres may not correspond directly to those
  in the chart above. Some are more specific."
  )

  output$barchart <- renderPlotly({
    bar <- interactive_bar(input$year)
    return(bar)
  })
  
}
