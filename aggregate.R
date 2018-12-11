library('tidyverse')

aggregate(countriesbyFood$Amount, by = list(countriesbyFood$GU_A3, countriesbyFood$Element), FUN = sum)

summedValues <- aggregate(Amount~GU_A3+Element, FUN = sum, data = countriesbyFood)

tmp <- spread(data = summedValues,key = Element, value = Amount)
tmp$ratio <- tmp$Feed/tmp$Food
countryRatios <- merge(tmp, income, by.x="GU_A3", by.y="GU_A3")

gdp <- select(map@data, GU_A3, GDP_MD_EST)

countryRatios <- merge(countryRatios, gdp, by.x="GU_A3", by.y="GU_A3")
save(countryRatios, file= 'countryRatios.rdata')
