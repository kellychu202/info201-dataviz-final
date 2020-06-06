#a certain UI smell fills the room...
library(plotly)
library(shiny)
library(shinyWidgets)

page_one <- tabPanel (
  "Introduction and Overview",
      tags$div(
        id = "gold_title",
        h1("Popular Music Analysis")
      ),
      tags$div(
        id = "text_header",
        p("Music is often considered to be a universal language. Given how
        popular music is worldwide, we wanted to investigate the music
        industry a little more and create ways for people to learn more
        about the industry as a whole, answering questions like uniqueness
        of music taste, genre popularity, and popularity by region of
        certain genres. This information could help a casual listener,
        but it could also help a future musician in their quest to
        demistify and industry that can be hard to break into."),
        img(src = "streaming.jpg.jpg", height = "98%", width = "98%"),
        img(src = "spotifytop50.png", height = 300, width = 525)
      )
  
)

page_two <- tabPanel(
  "Speed and Energy by Region",
  sidebarLayout(
    sidebarPanel(
      tags$div(
        id = "sidebar",
      h2("Choose Regions to Display"),
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
      tags$div(
        id = "purple_title",
        h1("Speed and Energy Tastes by Region")
      ),
      tags$p(
        id = "header",
        "Speed and energy are defining characteristics of songs. As it happens,
        peoples' preferences for these characteristics is influenced by region.
        This plot describes the top 50 songs on Spotify in a region by speed and
        energy level."),
      tags$p(
        id = "header",
        strong("NOTE-"),
             ("These data were taken around Christmas time 2019, causing
             an unusually high popularity of Christmas songs.")),
      plotlyOutput(outputId = "scatterplot"),
      tags$div(
        id = "header",
        strong("Notable Outlier Regions:"),
        p("- The US and Indonesia prefer lower-energy music"),
        p("- Brail and Japan prefer higher-energy music"),
        p("- India, Columbia, Israel, and Indonesia prefer slower music"),
        p("- Brazil prefers", strong("much"), "faster music")
      )
    )
  )
)

page_three <- tabPanel(
  "Top Genres of the 2010s",
  sidebarLayout(
    sidebarPanel(
      tags$div(
        id = "sidebar",
        sliderTextInput(
          h2("Select a Year"),
          inputId = "selected_year",
          choices = list(
            "decade"= "the 2010s",
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
          ),
        ),
        div(
          id = "fun_facts",
        
        # i hate how this looks but i can't figure out a way to extend the sidebarpanel to fit 
        # the entire length of the page
        # i could put an image instead???
          
          
        h4("Fun Facts about this Data:"),
        p("- Adele is the sole contributor to British Soul, 
          which is the 6th most popular genre of the decade"),
        p("- Pop and Dance Pop's distinction is unclear"),
        p("- Coldplay is Permanent Wave"),
        p("- EDM encompasses \"Complextro\", \"Electro\", \"Electro Pop\",
          \"Electro House\", and \"Big Room\""),
        p("- 2019 is the only year where Dance Pop isn't the most popular genre"),
        p("- The number of songs differs each year")
        ),
      ),
  ), 
  mainPanel(
    tags$div(
      id = "purple_title",
      h1("Top Genres of the 2010s by Year")
    ),
    tags$p(
      id = "header",
      "People's music preferences are constantly evolving, consequently, 
      so are the types of songs that become popular worldwide. This page shows the
      distribution of genres of the Billboard's top songs for each year in the 2010s.
      By sliding through the years, the different pie charts highlight the changes and
      general trends of popular genres from the last decade. The table below the chart
      lists the titles, artists, and specific genres of the corresponding songs from the
      selected year."
    ),
    tags$p(
      id = "header",
      strong("NOTE-"),
      "Some song's genres were edited from the original data to fit under broader
      categories. In the 2010-2019 chart, genres with fewer than 4 top songs were
      categorized under \"misc.\""
    ),
    tags$div(
      id = "p3_piechart",
      plotlyOutput("piechart"),
    ),
    # song table
    tags$div(
      id = "second_header",
      titlePanel(textOutput("song_table_title"))
    ),
    div(
      id = "table",
      style='height:250px; overflow-y: scroll',
      tableOutput("table")
    )
  )
  )
)


page_four <- tabPanel(
  "Worldwide Genre Popularity Based on Year Released",
  h1("Compare two years' releases"),
  sidebarLayout(
    sidebarPanel(
      
      selectInput(
        "Select a Year",
        inputId = "year",
        choices = list(
          "2001" = "2001", "2002" = "2002", "2004" = "2004", "2006" = "2006",
          "2008" = "2008", "2009" = "2009", "2010" = "2010", "2011" = "2011",
          "2012" = "2012", "2013" = "2013", "2014" = "2014", "2015" = "2015",
          "2016" = "2016", "2017" = "2017", "2018" = "2018", "2019" = "2019")
      ),
      selected = c("2019"),
      
      selectInput(
        "Select a Year",
        inputId = "year2",
        choices = list(
          "2001" = "2001", "2002" = "2002", "2004" = "2004", "2006" = "2006",
          "2008" = "2008", "2009" = "2009", "2010" = "2010", "2011" = "2011",
          "2012" = "2012", "2013" = "2013", "2014" = "2014", "2015" = "2015",
          "2016" = "2016", "2017" = "2017", "2018" = "2018", "2019" = "2019")
      ),
      selected = c("2010")
  ),
    mainPanel(
      tags$p(
        id = "page_4_header",
        "This bar looks at the most popular genres in a given year, based on 
        Top 50 Charts provided by Spotify, and displays the number of
        countries where that genre is the most popular. This information
        could help a budding musician looking to realize what types of music
        they could focus on for maximum chart success, or what is working
        based off real data."),
      tags$p(
        id = "page_2_header",
        strong("NOTE-"),
        ("These data were taken around Christmas time 2019, causing
             an unusually high popularity of Christmas songs.")),
      plotlyOutput("barchart"),
      plotlyOutput("barchart2")
    )
  )
)


page_five <- tabPanel(
  "Conclusion",
  mainPanel(
    tags$div(
      id = "gold_title",
      h1("Insights")
    ),
    tags$div(
      id = "purple_title",
      h3("Speed and Energy Tastes by Region")
    ),
    tags$p(
      id = "header",
      "As seen in the chart, most regions prefer music in the 120-140
      beats per minute range. However, there are outlier countries like
      Brazil that prefer faster music, or outliers like Indonesia that
      prefer sower music. Similarly, some countries like the US prefer
      lower-energy music. With a broader lense, these data show us that
      location CAN BE a contributing factor to music preferences."
    ),
    tags$div(
      id = "purple_title",
      h3("The Pie Chart")
    ),
    tags$p(
      id = "header",
      "Over the 2010s, the genres of top songs became more diverse, spanning
      only 4 different genres at the lowest point to 11 at its peak. Dance
      Pop and Pop remained the two most popular genres of the decade
      (55.2% and 22.6% overall, respectively). In terms of total genre make-up,
      EDM rose in popularity from not on the board in 2010 to 19.4% in 2019,
      and hip hop saw a general decline from 13.7% in 2010 to 3.23% in 2019."
    ),
    tags$div(
      id = "purple_title",
      h3("The Bar Chart")
    ),
    tags$p(
      id = "header",
      "These visualizations could help someone who is trying to learn more
      about their music taste, or someone who is trying to break into the
      music industry. Music taste, by genre, year released, bpm, energy, 
      and many more variables varies greatly based on country and even by 
      year. It's hard to even predict going forward a country's music tastes. 
      However, there are certain genres that are more universally popular,
      such as different sub genres of pop music."
    )
  )
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

