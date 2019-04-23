library(shiny)
ui <- fluidPage(
  
  # App title ----
  titlePanel("Gunfire Incidents Recorded in Oakland"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      imageOutput("anim"))
      
    )
  )




server <- function(input, output) {
  

  
  output$anim <- renderImage(list(src = "oakland_anim.gif"), 
                             deleteFile = FALSE)
}



shinyApp(ui, server)
