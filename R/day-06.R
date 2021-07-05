# Hannah Malak
# 06/30/21
# Exercise 06 - COVID Data

library(dplyr)
library(ggplot2)
library(readr)

url = "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"

covid = readr::read_csv(url)

# Part 1
# Step 1

cc = covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(totCases = sum(cases, na.rm = TRUE)) %>%
  slice_max(totCases, n = 6)

# Step 2

cc2 = covid %>%
  filter(state %in% cc$state) %>%
  group_by(state, date) %>%
  summarize(totCases = sum(cases, na.rm = TRUE)) %>%
  ungroup()

# Step 3

g = ggplot(data = cc2, aes(x = date, y = totCases)) +
  geom_line(aes(color = state)) +
  facet_wrap(~state) +
  theme(legend.position = "bottom") +
  labs(title = "COVID By States",
       subtitle = "Top 6",
       x = "Date",
       y = "Total Cases")
ggsave(g, file = "img/day-06-graph-1.png")

# Part 2
# Step 1
cc3 = covid %>%
  group_by(date) %>%
  summarize(totCases = sum(cases, na.rm = TRUE)) %>%
  ungroup()

#Step 2
g2 = ggplot(data = cc3, aes(x = date, y = totCases)) +
  geom_col(color = "red") +
  labs(title = "Cumulative COVID Cases",
       subtitle = "United States",
       x = "Date",
       y = "Total Cases")
ggsave(g2, file = "img/day-06-graph-2.png")

