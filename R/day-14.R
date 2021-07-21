# Hannah Malak
# 07/19/21
# Exercise 14 - Functions

library(tidyverse)
library(sf)
library(USAboundaries)

# Step 1 - Create function

get_conus = function(data, var){
  conus = filter(data, !get(var) %in% c("Hawaii", "Puerto Rico", "Alaska"))
  return(conus)
}

# Step 2 - Use uscities.csv to create points

cities = read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  get_conus("state_name") %>%
  st_transform(5070) %>%
  select(city)

# Step 3 - Define polygons

counties = st_transform(us_counties(), 5070) %>%
  select(name, geoid, state_name) %>%
  get_conus("state_name")

# Step 3 - PIP function

point_in_polygon = function(points, polygon){
  st_join(polygon, points) %>%
    count(geoid)
}

# Step 4 - Plot

plot_pip = function(data){
  ggplot() +
    geom_sf(data = data, aes(fill = log(n)), alpha = .9, size = .2) +
    scale_fill_gradient(low = "white", high = "black") +
    theme_void() +
    theme(legend.position = 'none',
          plot.title = element_text(face = "bold", color = "black", hjust = .5, size = 24)) +
    labs(title = "Number of Cities in Each US County")
}

cities_plot = point_in_polygon(cities, counties)

plot_pip(cities_plot)

ggsave(filename = "img/day-14-map.png")
