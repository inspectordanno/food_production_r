library(tidyverse)
library(rgdal)
load("food.rdata")

##parsing data

food_data <- read.csv('food.csv', stringsAsFactors = F)

tmp <- gather(food_data, key = Year, value = Amount, 11:63)
tmp$Year <- substr(tmp$Year,2,5)

food <- select(tmp, Area, Area.Abbreviation, Item, Element, Year, Amount)
food$Year <- as.numeric(food$Year)

#save(food,file = "food.rdata")

#dat <- food[food$Area.Abbreviation %in% countrySelection,]

##map
map <-  readOGR(dsn = "shapefiles", layer = "ne_50m_admin_0_countries")
dat.s <- select(map@data,POP_EST,GU_A3,SU_A3, CONTINENT, REGION_UN, SUBREGION, REGION_WB)
income <- select(map@data, INCOME_GRP, GU_A3, NAME)
income$INCOME_GRP <- as.numeric(income$INCOME_GRP)

dat.s$pop <- as.numeric(as.character(dat.s$POP_EST))
#save(dat.s,file= "countries.rdata")

large <- dat.s[dat.s$pop>10000000,]


countriesbyFood <- merge(dat.s,food, by.y = "Area.Abbreviation", by.x= "GU_A3")
countriesbyFood$Year <- as.numeric(countriesbyFood$Year)

countriesbyFood <- merge(countriesbyFood, income, by.x = "GU_A3", by.y = "GU_A3")
save(countriesbyFood,file= "countriesbyFood.rdata")

t <- table(countriesbyFood$Item, countriesbyFood$Element)

tx <-  as.data.frame(t)
v <-  t[,1]!=0
t2 <- t[v,]
t3 <- rownames(t2)
t3
countriesbyFood <- countriesbyFood[countriesbyFood$Item %in% t3, ]

ggplot(mergedData[mergedData$Item=="Wheat and products",]) + geom_line(aes(color = Element, x = Year, y = Amount)) + facet_wrap(~Area)

wheatFood <- filter(food, Item == "Wheat and products", Element == "Food", Year == "1990")
wheatFeed <- filter(food, Item == "Wheat and products", Element == "Feed", Year == "1990")