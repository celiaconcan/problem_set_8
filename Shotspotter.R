library(readr)
library(ggplot2)
library(geom_sf)
library(tigris)
library(viridis)
library(sf)
library(stringr)
library(ggthemes)
library(tidyverse)

oakland <- read_csv("http://justicetechlab.org/wp-content/uploads/2017/08/OakShots_latlong.csv")


shapes <- urban_areas(class = "sf") 


shapes2 <- shapes %>%
filter(NAME10 == "San Francisco--Oakland, CA")

x <- st_as_sf(shapes2, coords = c("XCOORD", "YCOORD"), crs = 4236)

ggplot()+ 
  geom_sf() +
  geom_sf(data = shapes2) + 
  theme_map()

