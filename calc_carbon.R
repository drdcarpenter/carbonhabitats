library(sf)
library(dplyr)
library(readr)
library(janitor)

# read in data
phabs <- readRDS("phabs.rds")
carbon <- read_csv("carbon_data.csv")

# convert factors to character for join
phabs <- mutate_if(phabs, is.factor, as.character)

# join carbon data to habs data
c_phabs <- left_join(phabs, carbon)

# calculate stored C and Cseq per feature
c_phabs <- c_phabs %>% 
  mutate(Cstor = (Area * AGB)) %>% 
  mutate(ACseq = (Area * Cseq))

c_phabs <- c_phabs %>% 
  filter(!is.na(AGB))

# plot data
library(RColorBrewer)
pal <- brewer.pal(7, "OrRd") # we select 7 colors from the palette
class(pal)

plot(c_phabs["Cstor"], pal = pal, nbreaks = 7, border = NA) # this doesn't work well


# calc total Cstor per phab
tot_Cstor <- c_phabs %>%
  as.data.frame() %>% 
  select(S41Habitat, Cstor) %>% 
  group_by(S41Habitat) %>% 
  summarise(T_Cstor = round(sum(Cstor), 0)) %>% 
  adorn_totals()

# write_csv(tot_Cstor, "total_carbon_storage.csv")

# calc annual Cseq
ann_c_seq <- c_phabs %>% 
  as.data.frame() %>% 
  group_by(S41Habitat) %>% 
  summarise(AnnCseq = round(sum(ACseq), 0)) %>% 
  adorn_totals()

# write_csv(ann_c_seq, "annual_carbon_sequestered.csv")
            