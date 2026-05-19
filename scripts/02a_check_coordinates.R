
# clean environment
rm(list=ls())


#----- load libraries
library(here)
library(tidyverse)
library(leaflet)


#----- read data
florestal_raw <- readRDS(here("output", "florestal_raw.rds"))
projects <- florestal_raw$projects
deployments <- florestal_raw$deployments
images <- florestal_raw$images


#----- check coordinates

# NB! incorrect coordinates should be checked and fixed in Wildlife Insights
# however, here we will provisionally exclude any sites with incorrect coords


# function to make map
make_map <- function(x) {
  deployments %>%
    filter(project_id == x) %>%
    distinct(placename, longitude, latitude) %>%
    leaflet() %>%
    addProviderTiles(provider = "Esri.NatGeoWorldMap") %>%
    addCircleMarkers(radius = 2, color = "black",
                     label = ~placename)
}


# check individual projects

# gurupi
make_map(2002545)
# remove non-team sites from gurupi project
deployments <- deployments %>%
  filter(! (project_id == 2002545 & str_detect(placename, "CT-RBG-E"))) %>%
  print()

# terra do meio
make_map(2002554)

# jamari
make_map(2002562)
# remove non-team sites from jamari project
jamari_non_team_cams <- readRDS(here("bin", "jamari-non-team-cams.rds"))
deployments <- deployments %>%
  filter(! placename %in% jamari_non_team_cams) %>%
  print()

# juruena
make_map(2002576)
# remove "sem numero" sites from juruena project
deployments <- deployments %>%
  filter(placename != "Sem-numero") %>%
  print()

# maraca
make_map(2002584)

# tumucumaque
make_map(2003586)

# tapajos
make_map(2004835)

# caxiuana
make_map(2006780)

# tapirape
make_map(2007402)
# tapirape is currently a mess. remove it altogether
deployments <- deployments %>%
  filter(project_id != 2007402) %>%
  print()

# jari
make_map(2007439)

# rio acre
make_map(2009348)

# descobrimento
make_map(2011116)

# bom jesus
#make_map(2011268)

# monte pascoal
make_map(2012253)

# update projects and images based on corrected deployments
projects <- projects %>%
  filter(project_id %in% deployments$project_id) %>%
  print()

images <- images %>%
  filter(deployment_id %in% deployments$deployment_id) %>%
  print()


# save aggregated data
florestal_fixed_coords <- list(projects=projects,
                               deployments=deployments,
                               images=images)
saveRDS(florestal_fixed_coords, here("output", "florestal_fixed_coords.rds"))

