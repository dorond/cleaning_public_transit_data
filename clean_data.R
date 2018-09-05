library(tidyverse)
library(readxl)

df <- read_excel("mbta.xlsx", skip = 1) %>%
  select(-starts_with("X")) %>%
  filter(mode != "All Modes by Qtr" & mode != "Pct Chg / Yr" & mode != "TOTAL") %>%
  gather(year_month, thou_riders, -mode) %>%
  mutate(thou_riders = as.numeric(thou_riders)) %>%
  spread(mode, thou_riders) %>%
  separate(year_month, c("year", "month")) %>%
  mutate(year = as.integer(year), month = as.integer(month))

names(df) <- df %>%
  names() %>%
  tolower() %>% 
  str_replace(" ", "_")

df$boat[which(df$boat > 30)] <- 4