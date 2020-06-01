#a certain UI smell fills the room...
library(plotly)
library(shiny)

page_one <- tabPanel (
  "Introduction and Overview",
  sidebarLayout(
    sidebarPanel(
      h2("Intro Content")
    ),
    mainPanel(
      p("Main panel content")
    )
  )
)

page_two <- tabPanel(
  "First Interactive Page",
  sidebarLayout(
    sidebarPanel(
      tags$div(
        id = "page_2_sidebar",
      h1("Interactive plot 1"),
      checkboxGroupInput(
        inputId = "scatter_country_selector",
        label = "Country Selector",
        c(
          "world" = "world",
          "Africa" = "africa",
          "Argentina" = "argentina",
          "Australia" = "australia",
          "Belgium" = "belgium",
          "Bolivia" = "bolivia",
          "Brazil" = "brazil",
          "Canada" = "canada",
          "Germany" = "germany",
          "Columbia" = "colombia",
          "Chile" = "chile",
          "Spain" = "spain",
          "USA" = "usa",
          "France" = "france",
          "India" = "india",
          "Indonesia" = "indonesia",
          "Israel" = "israel",
          "Italy" = "italy",
          "Japan" = "japan",
          "Malasya" = "malasya"
        )
      ),
      textOutput(outputId = "scatter_column")
      )
    ),
    mainPanel(
      tags$p(
        id = "page_2_header",
        "Reuben claims this page keep out")
    )
  )
)

page_three <- tabPanel(
  "Second Interactive Page",
  h1("Interactive plot 2")
)

page_four <- tabPanel(
  "Third Interactive Page",
  h1("Interactive plot 3")
)

page_five <- tabPanel(
  "Summary Takeaways",
  h1("Analysis time boys")
)

ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "Music Analysis",
    page_one,
    page_two,
    page_three,
    page_four,
    page_five
  )
)

