library(shiny)
library(readr)
library(ggplot2)
library(tigris)
library(viridis)
library(sf)
library(stringr)
library(ggthemes)
library(gganimate)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Location of ShotSpotter Detections"))

server <- function(input, output) {
  output$plot1 <- renderImage({
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext='.gif')
    
    oakland <- read_csv("http://justicetechlab.org/wp-content/uploads/2017/08/OakShots_latlong.csv",
                        col_types = cols(
                          OBJECTID = col_double(),
                          CAD_ = col_character(),
                          BEAT = col_character(),
                          DATE___TIM = col_character(),
                          ADDRESS = col_character(),
                          CALL_ID = col_character(),
                          DESCRIPTIO = col_character(),
                          Xrough = col_double(),
                          Yrough = col_double(),
                          XCOORD = col_double(),
                          YCOORD = col_double()
                        )) %>%
      arrange(DATE___TIM) %>%
      rowid_to_column() %>%
      sample_n(200)
    
    shapes <- urban_areas(class = "sf") 
    
    
    shapes2 <- shapes %>%
      filter(NAME10 == "San Francisco--Oakland, CA")
    
    oakland <- st_as_sf(oakland, coords = c("XCOORD", "YCOORD"), crs = 4236)
    
    # now make the animation
    p = ggplot(data = shapes2)+ 
      geom_sf() +
      geom_sf(data = oakland) + 
      theme_map() +
      transition_time(rowid) +
      labs(subtitle = "Oakland, CA",
           caption = "Source: Justice Tech Lab")
    
    
    anim_save("outfile.gif", animate(p)) # New
    
    # Return a list containing the filename
    list(src = "outfile.gif",
         contentType = 'image/gif'
         # width = 400,
         # height = 300,
         # alt = "This is alternate text"
    )}, deleteFile = TRUE)}

shinyApp(ui, server)
