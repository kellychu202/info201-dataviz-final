#a certain UI smell fills the room...
library(plotly)
library(shiny)
library(shinyWidgets)
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
      h1("Choose Regions to display"),
      checkboxGroupInput(
        inputId = "scatter_country_selector",
        label = " ",
        c(
          "World" = "world",
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
        ),
      selected = c("world")
      )
      )
    ),
    mainPanel(
      tags$p(
        id = "page_2_header",
        "Speed and energy are defining characteristics of songs. As it happens,
        peoples' preferences for these characteristics is influenced by region.
        This plot describes the top 50 songs on Spotify in a region by speed and
        energy level."),
      tags$p(
        id = "page_2_header",
        strong("NOTE-"),
             ("These data were taken around Christmas time 2019, causing
             an unusually high popularity of Christmas songs.")),
      plotlyOutput(outputId = "scatterplot"),
      tags$div(
        id = "page_2_header",
        strong("Notable Outlier Regions:"),
        p("-The US and Indonesia prefer lower-energy music"),
        p("-Brail and Japan prefer higher-energy music"),
        p("-India, Columbia, Israel, and Indonesia prefer slower music"),
        p("-Brazil prefers", strong("much"), "faster music")
      )
    )
  )
)

page_three <- tabPanel(
  "Top Genres of the 2010s",
  h1("Interactive plot 2"),
  sidebarLayout(
    sidebarPanel(
      sliderTextInput(
        "Select a Year",
        inputId = "selected_year",
        choices = list(
          "2010" = "2010",
          "2011" = "2011",
          "2012" = "2012",
          "2013" = "2013",
          "2014" = "2014",
          "2015" = "2015",
          "2016" = "2016",
          "2017" = "2017",
          "2018" = "2018",
          "2019" = "2019"
        )
      ),
  ), 
  mainPanel(
    plotlyOutput("piechart")
    # add chart of songs for the year
  )
  )
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

