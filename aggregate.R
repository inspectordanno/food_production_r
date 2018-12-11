library('tidyverse')

aggregate(countriesbyFood$Amount, by = list(countryFoodValues$Area, countryFoodValues$Element), FUN = sum)

summedValues <- aggregate(Amount~Area+Element, FUN = sum, data = countriesbyFood)

tmp <- spread(data = summedValues,key = Element, value = Amount)
tmp$ratio <- tmp$Feed/tmp$Food
