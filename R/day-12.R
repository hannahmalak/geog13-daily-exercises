# Hannah Malak
# 07/13/21
# Exercise 12 - Spatial Filtering

library(tidyverse)
library(sf)
library(USAboundaries)

# Step 1 - Filter state

us = us_states()
contiguous_us = filter(us, !name %in% c("Alaska", "Hawaii", "Puerto Rico"))
state_of_interest = filter(contiguous_us, name == "New York")

# Step 2 - Identify states that touch chosen state

touches_state = st_filter(contiguous_us, state_of_interest, .predicate = st_touches)

# Step 3 - Make map using ggplot

ggplot() +
  geom_sf(data = contiguous_us) +
  geom_sf(data = touches_state, fill = "blue", alpha = 0.5) +
  labs(title = "States That Touch New York",
       x = "Latitude",
       y = "Longitude") +
  ggthemes::theme_map()

ggsave(file = "img/day-12-map.png")
