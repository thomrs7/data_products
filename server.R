library(shiny)
library(plyr)
library(ggplot2)
library(dplyr)
library(viridis)

shinyServer(function(input, output) {
    
    wx_data = read.csv('data/oct_2015_weather.csv')
    
    wx_data <- mutate(wx_data, 
                      time = as.POSIXct(time,origin = "1970-01-01",tz = "GMT"),
                      Temperature = as.numeric(Temperature),
                      areaDescription = as.character(areaDescription)
    )
    wx_data <- filter(wx_data, Temperature != 0)
    
    
    output$choose_vars <- renderUI({
        vars <- c("Temperature" = "Temperature",
                  "Humidity" = "Humidity",
                  "Pressure" = "Pressure",
                  'Visibility'= 'Visibility',
                  'Wind_Speed'='Wind_Speed'
                  )
        
        selectInput("variable", "Variable:",  vars, selected = 'Temperature' )
    })
    
    output$choose_location <- renderUI({
 
        loc <- as.list(unique(wx_data$areaDescription))
        selectInput("location", "Location:",  loc, selected = 'Saint Petersburg FL'
                    )
    })
    
 
    
  output$distPlot <- renderPlot({

  if(is.null(input$variable))
      return()
  
    var <- input$variable
    loc <- input$location
    
      
    data <- filter(wx_data, areaDescription == loc)
    print(var)
    print(loc)
    
    p <- ggplot(data,  aes_string(x='time',y=var)) 
    p <- p + geom_jitter(alpha=.5, size=3, aes_string(color=var)) 
    p <- p + scale_color_gradientn(colours = viridis(6),  name=var) 
    p <- p + labs(title = loc, x="Date", y="Degrees Fahrenheit") 
    p
    
    

  })

})
