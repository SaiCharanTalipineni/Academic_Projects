station <- read.csv("C:/Users/sag163/Desktop/HealthyRideStations2015.csv", header = T)

head(station)

library(ggmap)
map <- get_map(location = 'Pittsburgh', zoom = 13, maptype = "hybrid")

library(dplyr)
library(plyr)

rack <- as.data.frame(cbind(station$Latitude, station$Longitude, station$RackQnty))

colnames(rack) <- c("lat", "lon", "num")

  mapPoints <- ggmap(map) + 
  geom_point(aes(x = rack$lon, y = rack$lat, size = rack$num), data = rack) + scale_size_area(name = "Rack Quantity")

plot(mapPoints)
                 
                 