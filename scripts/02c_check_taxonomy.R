
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
target_spp <- images %>%
  filter(project_id == 2002545) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filter target families
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", #"Canidae", "Felidae",
                       "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filter target species and species with enough data
  drop_na(genus, species) %>%
  filter(! genus %in% c("Penelope", "Pipile", "Crypturellus", "Tinamus", "Cerdocyon",
                        "Speothos", "Panthera", "Galictis", "Lontra",
                        "Cabassous", "Euphractus", "Caluromys", "Chironectes",
                        "Philander")) %>%
  filter(! species %in% c("jacquacu", "yagouaroundi", "kappleri")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf) %>%
  mutate(targets = paste(genus, species, sep = " ")) %>%
  pull(targets) %>%
  print()

# now filter images files based on target_spp
images <- images %>%
  filter(
    if_else(
      # condition: target project
      project_id == 2002545,
      # if TRUE: check if genus + species combination exists in target_sp_gurupi
      paste(genus, species) %in% target_spp,
      # if FALSE: keep the row automatically
      TRUE
    )) %>%
  print()



# terra do meio
target_spp <- images %>%
  filter(project_id == 2002554) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", #"Canidae", "Felidae",
                       "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Pipile", "Psophia", "Crypturellus", "Atelocynus",
                        "Canis", "Cerdocyon", "Speothos", 
                        "Panthera", "Eira", "Galictis", "Procyon",
                        "Odocoileus", "Dasypus", "Cabassous", "Tamandua",
                        "Metachirus", "Didelphis", "Guerlinguetus", "Sciurus")) %>%
  filter(! species %in% c("alector", "jacquacu", "viridis",
                          "guttatus", "major", "wiedii","yagouaroundi", 
                          "kappleri")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf) %>%
  mutate(targets = paste(genus, species, sep = " ")) %>%
  pull(targets) %>%
  print()


# in terra do meio, replace wrong taxonomies but keep record
# from Dasyprocta leporina to iacki
# from Psophia viridis to dextralis
images <- images %>%
  mutate(species = case_when(project_id == 2002554 & species == "leporina" ~ "iacki",
                             project_id == 2002554 & species == "viridis" ~ "dextralis",
                             .default = species)) %>%
  print()


# now filter images files based on target_spp
images <- images %>%
  filter(
    if_else(
      # condition: target project
      project_id == 2002554,
      # if TRUE: check if genus + species combination exists in target_sp_gurupi
      paste(genus, species) %in% target_spp,
      # if FALSE: keep the row automatically
      TRUE
    )) %>%
  print()



# jamari
target_spp <- images %>%
  filter(project_id == 2002562) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", #"Canidae", "Felidae",
                       "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Odontophorus", "Crypturellus", "Atelocynus", "Cerdocyon",
                        "Speothos", "Herpailurus", "Panthera", "Puma",
                        "Galictis", "Potos", "Procyon", "Odocoileus",
                        "Cabassous", "Priodontes", "Tamandua",
                        "Metachirus", "Myoprocta", "Sciurus")) %>%
  filter(! species %in% c("fasciolata", "tomentosum", "urumutum",
                          "superciliaris", "guttatus", "major",
                          "wiedii")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf) %>%
  mutate(targets = paste(genus, species, sep = " ")) %>%
  pull(targets) %>%
  print()

# in jamari, replace wrong taxonomies but keep record
# loads of wrong Dasyprocta, check and fix them all
# from Psophia crepitans to viridis
images <- images %>%
  mutate(species = case_when(project_id == 2002562 & genus == "Dasyprocta" ~ "fuliginosa",
                             project_id == 2002562 & species == "crepitans" ~ "viridis",
                             .default = species)) %>%
  print()


# now filter images files based on target_spp
images <- images %>%
  filter(
    if_else(
      # condition: target project
      project_id == 2002562,
      # if TRUE: check if genus + species combination exists in target_sp_gurupi
      paste(genus, species) %in% target_spp,
      # if FALSE: keep the row automatically
      TRUE
    )) %>%
  print()



# juruena
target_spp <- images %>%
  filter(project_id == 2002576) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", #"Canidae", "Felidae", 
                       "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Aburria", "Nothocrax", "Ortalis", "Penelope", "Pipile",
                        "Psophia", "Crypturellus", "Rhynchotus",
                        "Atelocynus", "Cerdocyon", "Herpailurus", "Panthera",
                        "Galictis", "Lontra", "Potos",
                        "Procyon", "Cabassous", "Euphractus", "Tamandua",
                        "Monodelphis", "Philander", "Sciurus")) %>%
  filter(! species %in% c("superciliaris", "guttatus", "major", 
                          "wiedii", "kappleri")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf) %>%
  mutate(targets = paste(genus, species, sep = " ")) %>%
  pull(targets) %>%
  print()

# now filter images files based on target_spp
images <- images %>%
  filter(
    if_else(
      # condition: target project
      project_id == 2002576,
      # if TRUE: check if genus + species combination exists in target_sp_gurupi
      paste(genus, species) %in% target_spp,
      # if FALSE: keep the row automatically
      TRUE
    )) %>%
  print()


# maraca
target_spp <- images %>%
  filter(project_id == 2002584) %>%
  filter(class %in% c("Mammalia", "Aves")) %>%
  # filtrar familias alvo
  filter(family %in% c("Cracidae", "Odontophoridae", "Psophiidae", "Tinamidae",
                       "Cervidae", #"Canidae", "Felidae",
                       "Mustelidae",
                       "Procyonidae", "Tayassuidae", "Chlamyphoridae",
                       "Dasypodidae", "Didelphidae", "Tapiridae",
                       "Myrmecophagidae", "Cuniculidae", "Dasyproctidae",
                       "Sciuridae")) %>%
  # filtrar especies identificaveis ou com dados suficientes
  drop_na(genus, species) %>%
  filter(! genus %in% c("Mitu", "Ortalis", "Penelope", "Odontophorus",
                        "Crypturellus", "Speothos", "Herpailurus", "Panthera",
                        "Puma", "Galictis", "Nasua", "Procyon",
                        "Odocoileus", "Cabassous", "Priodontes",
                        "Dasypus", "Didelphis", "Metachirus", "Philander",
                        "Tamandua", "Sciurus")) %>%
  filter(! species %in% c("fasciolata", "wiedii", "nemorivaga")) %>%
  group_by(class, order, family, genus, species) %>%
  count() %>%
  arrange(class, order, family, genus, species) %>%
  print(n=Inf) %>%
  mutate(targets = paste(genus, species, sep = " ")) %>%
  pull(targets) %>%
  print()

# in maraca, replace wrong taxonomies but keep record
images <- images %>%
  mutate(species = case_when(project_id == 2002584 & genus == "Dasyprocta" ~ "leporina",
                             .default = species)) %>%
  print()


# now filter images files based on target_spp
images <- images %>%
  filter(
    if_else(
      # condition: target project
      project_id == 2002584,
      # if TRUE: check if genus + species combination exists in target_sp_gurupi
      paste(genus, species) %in% target_spp,
      # if FALSE: keep the row automatically
      TRUE
    )) %>%
  print()



# save aggregated data
florestal_fixed_taxonomy <- list(projects=projects,
                                 deployments=deployments,
                                 images=images)
saveRDS(florestal_fixed_taxonomy, here("output", "florestal_fixed_taxonomy.rds"))

