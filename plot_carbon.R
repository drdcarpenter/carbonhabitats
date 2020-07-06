library(ggplot2)

m <- ggplot(c_phabs)+
  geom_sf(aes(fill = totalC), colour = NA)+
  theme_light()+
  scale_fill_gradient(low = "#56B1F7", high = "#132B43")
m

# add ggmap() background
# add TVERC boundary
# or do this in GIS?