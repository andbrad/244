################
# National Parks Visitation Shiny App - MS
# ESM 244 Lab 1
# Allison Horst and Sean Fitzgerald
################

library(shiny)
library(tidyverse)

# Note: You will need to change the pathway below so that it matches the pathway to np_visit.csv on YOUR computer.

np_visit <- read_csv("H:/Week 1/np_visit.csv")

#ca_np <- np_visit %>% 
  #filter(state == "CA" & type == "National Park")

all_nps<-np_visit %>% 
  filter(type=="National Park"|type=="National Monument") %>% 
  arrange(state)
View(np_visit)

all_nps$state<-as.factor(all_nps$state)

  
# Define UI for app that draws a bar graph ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("California National Park Visitation"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      selectInput("state", "State:", choices=unique(all_nps$state)),
      
      #selectinput adds a dropdown menu. Input is "State"
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "Year",
                  label = "Year",
                  min = 1950,
                  max = 2016,
                  value = 2016)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Bar plot ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)


server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    x <- all_nps$visitors # This is my quantitative data
    Year <- input$Year
    pick_state <-input$state
    
    ggplot(subset(all_nps, year == Year & state==pick_state), aes(x = park_name, y = visitors)) + 
      geom_col(aes(fill = park_name)) +
      theme_minimal() +
      ylab("Annual Visitors") +
      xlab("") +
      scale_y_continuous(expand = c(0,0), limits = c(0, 6e6)) +
      coord_flip() +
      guides(fill = FALSE)
           
         
  })
  
}

shinyApp(ui, server) # This puts them together and tells R to make an app of it! 