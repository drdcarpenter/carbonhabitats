library(sf)

# read in and filter sites data
sites <- st_read("G:/Data/Data to use/Sites/BBO/Combined Sites.shp")
stat_sites <- filter(sites, Desgntn %in% c("SAC", "SPA", "RAMSAR", "NNR", "SSSI"))
lws <- filter(sites, Desgntn %in% c("Berkshire Local Wildlife Site", "Oxfordshire Local Wildlife Site"))
c_phabs_simple <- dplyr::select(c_phabs, S41Habitat, Area, AGB, Cseq, Cstor, ACseq, soilC, totalC)

# priority habitats in stat sites
stat_phabs <- st_join(c_phabs_simple, stat_sites)
stat_phabs <- filter(stat_phabs, !is.na(Desgntn))
sum(stat_phabs$Area.x)

stat_Cstor <- stat_phabs %>%
  as.data.frame() %>% 
  dplyr::select(S41Habitat, Cstor, soilC) %>% 
  group_by(S41Habitat) %>% 
  summarise(T_Cstor = round(sum(Cstor), 0),
            t_soilC = round(sum(soilC), 0),
            total_c = round(sum(Cstor)+ sum(soilC), 0)) %>% 
  adorn_totals()
stat_Cstor

stat_Cseq <- stat_phabs %>% 
  as.data.frame() %>% 
  group_by(S41Habitat) %>% 
  summarise(AnnCseq = round(sum(ACseq), 0)) %>% 
  adorn_totals()
stat_Cseq

# priority habitats in LWS
lws_phabs <- st_join(c_phabs_simple, lws)
lws_phabs <- filter(lws_phabs, !is.na(Desgntn))
sum(lws_phabs$Area.x)

lws_Cstor <- lws_phabs %>%
  as.data.frame() %>% 
  dplyr::select(S41Habitat, Cstor, soilC) %>% 
  group_by(S41Habitat) %>% 
  summarise(T_Cstor = round(sum(Cstor), 0),
            t_soilC = round(sum(soilC), 0),
            total_c = round(sum(Cstor) + sum(soilC), 0)) %>% 
  adorn_totals()
lws_Cstor

lws_Cseq <- lws_phabs %>% 
  as.data.frame() %>% 
  group_by(S41Habitat) %>% 
  summarise(AnnCseq = round(sum(ACseq), 0)) %>% 
  adorn_totals()
lws_Cseq

# priority habs not in sites
no_site_phabs <- st_join(c_phabs_simple, sites, left = TRUE)
no_site_phabs <- filter(no_site_phabs, is.na(Desgntn))
sum(no_site_phabs$Area.x)

non_Cstor <- no_site_phabs %>%
  as.data.frame() %>% 
  dplyr::select(S41Habitat, Cstor, soilC) %>% 
  group_by(S41Habitat) %>% 
  summarise(T_Cstor = round(sum(Cstor), 0),
            t_soilC = round(sum(soilC), 0),
            total_c = round(sum(Cstor) + sum(soilC), 0)) %>% 
  adorn_totals()
non_Cstor

non_Cseq <- no_site_phabs %>% 
  as.data.frame() %>% 
  group_by(S41Habitat) %>% 
  summarise(AnnCseq = round(sum(ACseq), 0)) %>% 
  adorn_totals()
non_Cseq
