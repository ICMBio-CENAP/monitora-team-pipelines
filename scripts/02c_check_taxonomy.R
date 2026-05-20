
# clean environment
rm(list=ls())


#----- load libraries
library(here)
library(tidyverse)


#----- read data
data_fixed_dates <- readRDS(here("output", "data_fixed_dates.rds"))
projects <- data_fixed_dates$projects
deployments <- data_fixed_dates$deployments
images <- data_fixed_dates$images
rm(data_fixed_dates)

#----- check taxonomy

# NB! incorrect identifications should be checked and fixed in Wildlife Insights
# however, here we will provisionally fix some stuff here



# check individual projects

# gurupi
target_sp_gurupi <- images %>%
  filter(project_id == 2002545) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", "Canidae", "Felidae", "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Pipile", "Crypturellus", "Tinamus", "Cerdocyon",
                        "Speothos", "Galictis", "Lontra", "Cabassous",
                        "Euphractus", "Caluromys", "Chironectes",
                        "Philander")) %>%
  filter(! species %in% c("jacquacu", "kappleri")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf)




# terra do meio
target_sp_tdm <- images %>%
  filter(project_id == 2002554) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", "Canidae", "Felidae", "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Pipile", "Psophia", "Crypturellus", "Atelocynus",
                        "Canis", "Cerdocyon", "Speothos", "Galictis",
                        "Odocoileus", "Cabassous", "Metachirus",
                        "Sciurus")) %>%
  filter(! species %in% c("alector", "jacquacu", "viridis",
                          "guttatus", "major", "kappleri")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf)

# in terra do meio, replace wrong taxonomies but keep record
# from Dasyprocta leporina to iacki
# from Psophia viridis to dextralis


# jamari
target_sp_jamari <- images %>%
  filter(project_id == 2002562) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", "Canidae", "Felidae", "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Odontophorus", "Crypturellus", "Atelocynus", "Cerdocyon",
                        "Speothos", "Herpailurus", "Galictis", "Potos",
                        "Procyon", "Odocoileus", "Cabassous",
                        "Metachirus")) %>%
  filter(! species %in% c("fasciolata", "tomentosum", "urumutum",
                          "superciliaris", "guttatus", "major")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf)

# in jamari, replace wrong taxonomies but keep record
# loads of wrong Dasyprocta, check and fix them all
# from Psophia crepitans to viridis


# juruena
target_sp_juruena <- images %>%
  filter(project_id == 2002576) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", "Canidae", "Felidae", "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Aburria", "Nothocrax", "Ortalis", "Pipile",
                        "Psophia", "Crypturellus", "Rhynchotus", "Cerdocyon",
                        "Herpailurus", "Galictis", "Lontra", "Potos",
                        "Procyon", "Cabassous", "Euphractus", "Monodelphis",
                        "Philander", "Sciurus")) %>%
  filter(! species %in% c("superciliaris", "guttatus", "major", 
                          "wiedii", "kappleri")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf)



# maraca
target_sp_maraca <- images %>%
  filter(project_id == 2002584) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", "Canidae", "Felidae", "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Mitu", "Ortalis", "Penelope", "Odontophorus",
                        "Crypturellus", "Speothos", "Herpailurus", "Galictis",
                        "Nasua", "Procyon", "Cabassous", "Priodontes",
                        "Dasypus", "Didelphis", "Metachirus", "Philander",
                        "Tamandua", "Sciurus")) %>%
  filter(! species %in% c("fasciolata", "wiedii")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf)

# in maraca, replace wrong taxonomies but keep record
# from Dasyprocta fuliginosa to leporina
# from Psophia crepitans to viridis



# save aggregated data
florestal_fixed_coords <- list(projects=projects,
                               deployments=deployments,
                               images=images)
saveRDS(florestal_fixed_coords, here("output", "florestal_fixed_coords.rds"))

