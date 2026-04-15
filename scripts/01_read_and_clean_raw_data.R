
#----- load libraries
library(here)
library(tidyverse)


#----- read data

# projects
projects <- read_csv(here("input", "projects.csv")) %>%
  select(project_id, project_short_name) %>%
  print()

# deployments
deployments <- read_csv(here("input", "deployments.csv")) %>%
  select(project_id, deployment_id, placename,
         longitude, latitude, start_date, end_date,
         camera_functioning, subproject_name, event_name) %>%
  print()

# images
# read and combine all images files at once
images_files <- fs::dir_ls(here("input"), regexp = "images")
images_files
images <- read_csv(images_files) %>%
  select(project_id, deployment_id, 
         class, order, family, genus, species,
         timestamp, is_blank) %>%
  filter(is_blank == 0) %>%
  select(-is_blank) %>%
  filter(! is.na(genus)) %>%
  print()

