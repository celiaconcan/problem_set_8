library(shiny)
ui <- fluidPage(
  
  # App title ----
  titlePanel("Gunfire Incidents Recorded in Oakland"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      h3("Source"),
      p("Thank you to Justice Tech Lab for gathering this data and making it available for public use."),     
      
      
      h3("Celia's Github"),
      p("https://github.com/celiaconcan/problem_set_8.git")
      
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
