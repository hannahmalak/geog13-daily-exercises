# Hannah Malak
# 07/11/21
# Exercise 10 - Feature Geometries

# Step 1

library(tidyverse)
library(sf)

# Step 2 - Filter out non-contiguous states

US = USAboundaries::us_states()
CONUS = filter(US, !name %in% c("Alaska", "Hawaii", "Puerto Rico"))

# Step 3 - Preserve state boundaries

(us_c_ml = st_combine(CONUS) %>%
    st_cast("MULTILINESTRING"))

plot(us_c_ml)

# Step 4 - Dissolve state boundaries

(us_u_ml = st_union(CONUS)  %>%
    st_cast("MULTILINESTRING"))

plot(us_u_ml)
