# Hannah Malak
# 07/13/21
# Exercise 11 - Projecting Data

library(tidyverse)
library(sf)
library(units)

# Step 1 + 2 - Read in data/Filter cities

cities = readr::read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  filter(city %in% c("Los Angeles", "Santa Barbara"))

# Step 3a - Transform filtered object locations to equal area

equalarea <- (st_transform(cities, 5070))

# Step 3b - Transform filtered object locations to equidistant

equidistant <- (st_transform(cities, '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'))


# Step 4 - Calculate distance

st_distance(equalarea)
st_distance(equidistant)

# Step 5 - Units

st_distance(equidistant) %>%
  set_units("km") %>%
  drop_units()
