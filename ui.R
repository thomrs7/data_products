
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("October 2015 Weather"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        uiOutput("choose_location"),
        uiOutput("choose_vars"),
        helpText("Help test here")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
