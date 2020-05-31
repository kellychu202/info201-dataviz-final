#a certain UI smell fills the room...
library(plotly)
library(shiny)


page_one <- tabPanel (
  "Introduction and Overview",
  sidebarLayout(
    sidebarPanel(
      h1("Intro Content")
    ),
    mainPanel(
      p("Main panel content")
    )
  )
)

page_two <- tabPanel(
  "First Interactive Page",
  h1("Interactive plot 1")
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

ui <- navbarPage(
  "Music Analysis",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five
)

