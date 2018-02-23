########
#National Parks Visitation App
#########

library(tidyverse)
library(shiny)

np_visit <- read_csv("H:/Week 1/np_visit.csv")

ca_np <- np_visit %>% 
  filter(state == "CA" & type == "National Park")

ui <- fluidPage(
  titlePanel("CA NP Visitation"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "Year",
                  label = "Year",
                  min = 1950,
                  max = 2016,
                  value = 2016)
    ), 
    
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)

server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    x <- ca_np$visitors
    Year <- input$Year
    
    ggplot(subset(ca_np, year == Year), aes (x = park_name, y = visitors)) +
      
      geom_col(aes(fill = park_name))+
      coord_flip()
  })
}

shinyApp(ui, server)