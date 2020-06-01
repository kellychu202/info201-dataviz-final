#This is where the app lives...

library("shiny")


source("app_server.R")
source("app_ui.R")

shinyApp(ui = ui, server = server)
