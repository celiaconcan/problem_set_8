library(tigris)
library(sf)
library(ggthemes)
library(gganimate)
library(tidyverse)
library(janitor)


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



shapes <- places("ca", class = "sf", cb = TRUE) %>%
  filter(NAME == "Oakland")

x <- oakland %>%
  filter(XCOORD > -130,
         YCOORD > 36) %>%
  st_as_sf(coords = c("XCOORD", "YCOORD"), crs = st_crs(shapes))




ggplot(data = shapes) + 
  geom_sf() + 
  geom_sf(data = x, alpha = 0.5) + 
  theme_map() +
  transition_states(DATE__TIM) +
  labs(title = "Location of ShotSpotter Detections",
       subtitle = "Aurora, CO",
       caption = "Source: Justice Tech Lab")
