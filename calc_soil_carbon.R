library(raster)
library(sf)
library(exactextractr)

# read in raster and reproject to crs = 27700


newproj <- "+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +towgs84=446.448,-125.157,542.06,0.15,0.247,0.842,-20.489 +units=m +no_defs"
soil <- raster("result.tiff")
soil2 <- projectRaster(soil, crs = newproj)

# calc mean soil C for each polygon
c_phabs$soilC <- exact_extract(soil2, c_phabs, "mean")

# calc total stored carbon
c_phabs <- mutate(c_phabs, totalC = (Cstor + soilC))

# calc total Cstor per phab
c_stored <- c_phabs %>%
  as.data.frame() %>% 
  dplyr::select(S41Habitat, Cstor, soilC) %>% 
  group_by(S41Habitat) %>% 
  summarise(T_Cstor = round(sum(Cstor), 0),
            t_soilC = round(sum(soilC), 0),
            total_c = round(sum(Cstor) + sum(soilC),0)) %>% 
  adorn_totals()
c_stored

# write_csv(c_stored, "total_stored_carbon.csv")
