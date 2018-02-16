library(shiny)
library(shinydashboard)


ui <- dashboardPage(
  
  dashboardHeader(title = "Allison's App Title"), 
  
  dashboardSidebar(
    
    sidebarMenu(
      
      menuItem("First Tab", tabName = "tab_1"), #first name is what appeas, second is what understands it as
      menuItem("Second Tab", tabName = "tab_2")
    )
    
    
  ), # This comma seperates the different items within the Sidebar
  
  dashboardBody(
    
    tabItems(
      
      tabItem(tabName = "tab_1",
              fluidRow(
                box(plotOutput("my_graph1", height = 300)),
                box(title = "Choose Color:",
                    selectInput("color1", "Choose Color:", choices = c("Orange","Magenta", "Purple")
                    )
              ))),
      
      tabItem(tabName = "tab_2",
              fluidRow(
                box(plotOutput("my_graph2", height = 500)),
                box(title = "Choose Color:",
                    radioButtons("color2", "Choose Color:", choices = c("red", "yellow", "gray"))
                
              ))
    )
    
  )
  
))



server <- function(input, output){
  
  
  output$my_graph1 <- renderPlot({
    hist(faithful$waiting, col = input$color1) #multiple graphics do not need a commma between them
  })
  
  output$my_graph2 <- renderPlot({
    
    ggplot(faithful, aes(x= waiting, y = eruptions)) +
    geom_point(color=input$color2)
  })
  
}
  
  
  
shinyApp(ui = ui, server = server)

