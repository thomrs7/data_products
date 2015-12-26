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
        helpText("Help text here")
    ),

    # Show the plot
    mainPanel(
      plotOutput("wxPlot")
    )
  )
))
