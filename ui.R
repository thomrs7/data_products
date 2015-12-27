library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("October 2015 Weather"),

  # Sidebar with data  inputs
  sidebarLayout(
    sidebarPanel(
        uiOutput("choose_location"),
        uiOutput("choose_vars"),
        sliderInput("days",
                    "Days to Average:",
                    min = 1,
                    max = 14,
                    value = 7),
        helpText(tags$h4("Directions"),
                 "1) Select your location",
                 tags$br(),
                 "2) Choose variable to view",
                 tags$br(),
                 "3) Adjust slider for a rolling average",
                 tags$br(),
                 "4) Graph will update as data changes"
                 )
    ),

    # Show the plot
    mainPanel(
      plotOutput("wxPlot")
    )
  )
))
