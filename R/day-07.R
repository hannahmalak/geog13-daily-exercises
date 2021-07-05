# Hannah Malak
# 07/01/21
# Exercise 07 - More COVID Plots

# Step 1

library(tidyverse)

url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"

covid = read_csv(url)

# Step 2

region = data.frame(state_abb = state.abb, state = state.name, state_region = state.region) %>%

# Steps 3-5

inner_join(covid, region, by = "state") %>%
  group_by(state_region, date) %>%
  summarize(totCases = sum(cases, na.rm = TRUE), totDeaths = sum(deaths, na.rm = TRUE)) %>%
  ungroup() %>%
  pivot_longer(cols = c('totCases', 'totDeaths')) %>%

# Step 6
ggplot(aes(x = date, y = value)) +
  geom_line(aes(color = state_region)) +
  labs(title = "Cumulative COVID Cases",
       subtitle = "By Region",
       x = "Date",
       y = "Value") +
  facet_grid(name~state_region, scales = "free_y") +
  theme_light()
ggsave(file = "img/day-07-graph.png")

