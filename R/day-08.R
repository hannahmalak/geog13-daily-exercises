# Hannah Malak
# 07/06/21
# Exercise 08 - COVID 7 Day Rolling Average

# Step 1

library(tidyverse)
library(zoo)

url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"

covid = read_csv(url)

state.of.interest = "California"

# Step 2

covid %>%
  filter(state == state.of.interest) %>%
  group_by(date) %>%
  summarize(totalCases = sum(cases)) %>%
  mutate(newCases = totalCases - lag(totalCases), roll7 = rollmean(newCases, 7, fill = NA, align = "right")) %>%
  ggplot(aes(x=date)) +
  geom_col(aes(y = newCases), col = NA, fill = "#C4B5B5") +
  geom_line(aes(y = roll7), col = "mediumpurple4", size = 1) +
  labs(title = "New COVID cases in California",
       x = "Date",
       y = "New Cases") +
  theme(aspect.ratio = .5)

# Step 3
ggsave(file = "img/day-08-graph.png")
