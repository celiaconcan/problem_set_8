library(readr)
library(ggplot2)
library(geom_sf)
library(tigris)
library(viridis)
library(sf)
library(stringr)
library(ggthemes)
library(tidyverse)

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
                    ))


shapes <- urban_areas(class = "sf") 


shapes2 <- shapes %>%
filter(NAME10 == "San Francisco--Oakland, CA")

oakland <- st_as_sf(oakland, coords = c("XCOORD", "YCOORD"), crs = 4236)

ggplot(data = shapes2)+ 
  geom_sf() +
  geom_sf(data = oakland) + 
  theme_map()

