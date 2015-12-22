library(shiny)
library(plyr)
library(dplyr)
library(lubridate)
library(ggplot2)
library(viridis)

shinyServer(function(input, output) {
    ## Get and prepare data
    wx_data = read.csv('data/oct_2015_weather.csv')
    wx_data <- mutate(wx_data, 
                      time = ymd_hms(time),
                      areaDescription = as.character(areaDescription)
        )

    ## Dynamic Dropdowns
    output$choose_vars <- renderUI({
        vars <- c("Temperature" = "Temperature",
                  "Humidity" = "Humidity",
                  "Pressure" = "Pressure",
                  'Visibility'= 'Visibility',
                  'Wind_Speed'='Wind_Speed'
                  )
        
        selectInput("variable", "Variable:",  vars, 
                    selected = 'Temperature' )
    })
    
    output$choose_location <- renderUI({
        loc <- as.list(unique(wx_data$areaDescription))
        selectInput("location", "Location:",  loc, 
                    selected = 'Saint Petersburg FL'
            )
    })
    
  ## Create the Plot Based on Inputs
  output$wxPlot <- renderPlot({
      if(is.null(input$variable))
          return()
     
        var <- input$variable
        loc <- input$location
        cnt <- input$count
    
        data <- filter(wx_data, areaDescription == loc)
    
        p <- ggplot(data,  aes_string(x='time',y=var)) 
        p <- p + geom_jitter(alpha=.5, size=3, aes_string(color=var)) 
        p <- p + scale_color_gradientn(colours = viridis(24),  name=var) 
        p <- p + labs(title = loc, x="Date", y="Degrees Fahrenheit") 
        
        return(p)
    
  })
  
})
