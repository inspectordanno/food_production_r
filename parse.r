library(tidyverse)

food_data <- read.csv('food.csv', stringsAsFactors = F)

tst <- food_data[1:100,]

tmp <- gather(food_data, key = Year, value = Amount, 11:63)
tmp$Year <- substr(tmp$Year,2,5)

food <- select(tmp, Area, Area.Abbreviation, Item, Element, Year, Amount)
food$Year <- as.numeric(food$Year)

sel <- c("ZAF","AFG", "SFB", "PAK", "PER", "USA", "GBR")

dat <- food[food$Area.Abbreviation %in% sel,]

library(dplyr)
sample <- filter(food, Area.Abbreviation == sel)
save(food,file = "food.rdata")