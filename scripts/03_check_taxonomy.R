
#----- load libraries
library(here)
library(tidyverse)

#----- read data
data_bundle <- readRDS(here("output", "data_bundle.rds"))

# define taxonomic authority (SALVE, IUCN, etc)
# use taxise package?