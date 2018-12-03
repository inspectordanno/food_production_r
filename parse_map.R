library(sp) 
library(rgdal)
library(tidyverse)
map <-  readOGR(dsn = "shapefiles", layer = "ne_50m_admin_0_countries")
plot(map)

load("food.rdata")

dat <- food[food$Area.Abbreviation %in% sel,]

dat.s <- select(map@data,POP_EST,GU_A3,SU_A3) 
dat.s
mergedData <- merge(dat.s,dat, by.y = "Area.Abbreviation", by.x= "GU_A3")
wheatFood <- filter(food, Item == "Wheat and products", Element == "Food", Year == "1990")
wheatFeed <- filter(food, Item == "Wheat and products", Element == "Feedd", Year == "1990")
