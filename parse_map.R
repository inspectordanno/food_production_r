library(sp)
library(rgdal)
map <-  readOGR(dsn = "shapefiles", layer = "ne_50m_admin_0_countries")
plot(map)

dat.s <- select(data,POP_EST,GU_A3,SU_A3) 

tmp <- merge(dat.s,dat, by.y = "Area.Abbreviation", by.x= "GU_A3")
