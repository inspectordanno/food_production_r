library('tidyverse')

countryFoodValues <-
  filter(countriesbyFood, Area, Item, Element, Amount)

countryFoodValues <- countriesbyFood[,9:13]

aggregate(countryFoodValues$Amount, by = list(countryFoodValues$Area, countryFoodValues$Element), FUN = sum)

summedValues <- aggregate(Amount~Area+Element, FUN = sum, data = countryFoodValues)

ratioValues <- aggregate(data = summedValues, Amount~Area, FUN = Element == Food / Element == Feed)



tmp <- spread(data = summedValues,key = Element, value = Amount)
tmp$ratio <- tmp$Feed/tmp$Food
