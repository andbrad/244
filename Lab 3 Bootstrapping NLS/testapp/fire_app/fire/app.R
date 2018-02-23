############
# My Fire App
# Brad Anderson
############

library(shiny)
library(tidyverse)
library(leaflet)
library(sf)

sb_fhz <- st_read(dsn = ".", layer = "fhszs06_3_42") #This tells R to look in the current working directory. If it can't find it, then set it as the working directroy using the options on the file tab on the right

sb_df <- st_transform(sb_fhz, "+init=epsg:4326")
st_crs(sb_df) # shows you the current coordinate reference system

sb_fh_class <- sb_df %>% 
  select(HAZ_CLASS)

# Define UI for application that draws a map
ui <- fluidPage(
   
   # Application title
   titlePanel("Santa Barbara Fire Hazard Zones"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        selectInput("class", 
                    "Fire Hazard Class:",
                    choices = unique(sb_fh_class$HAZ_CLASS))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         leafletOutput("fire_map")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$fire_map <- renderLeaflet ({
  
    fire_subset <- sb_fh_class %>% 
      filter(HAZ_CLASS == input$class)
    
    leaflet(fire_subset) %>% 
      addTiles() %>% 
      addPolygons(weight = 0.5,
                  color = "red",
                  fillColor = "orange",
                  fillOpacity = 0.5
      )
    }) #must be called fire_map, which is what we defined above
  
}

# Run the application 
shinyApp(ui = ui, server = server)

