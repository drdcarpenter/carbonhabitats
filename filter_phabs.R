library(sf)
library(dplyr)

phabs <- st_read("G:/Data/Data to use/Habitats/BBO/GIS data/Current/Oxfordshire and Berkshire Habitat and Land Use December 2019.shp")

phabs <- filter(phabs, !S41Habitat %in% c("None", "Not assessed yet")) 
phabs <- filter(phabs, !is.na(S41Habitat))

unique(phabs$S41Habitat)
