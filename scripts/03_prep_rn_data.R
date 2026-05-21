
# clean environment
rm(list=ls())


#----- load libraries
library(here)
library(tidyverse)


#----- read data
florestal_fixed_taxonomy <- readRDS(here("output", "florestal_fixed_taxonomy.rds"))
projects <- florestal_fixed_taxonomy$projects
deployments <- florestal_fixed_taxonomy$deployments
images <- florestal_fixed_taxonomy$images
rm(florestal_fixed_taxonomy)


#----- select usable timeframe
# i.e., remove years with non-catalogued data in wildlife insights

# for gurupi, all photos processed
# ok

# for terra do meio, upper limit 2024
deployments <- deployments %>%
  filter(
    if_else(
      project_id == 2002554,
      # if TRUE, apply this condition
      year(start_date) <= 2024,
      # if FALSE, keep
      TRUE
    )
  ) %>%
  print()


# for jamari, upper limit 2024
deployments <- deployments %>%
  filter(
    if_else(
      project_id == 2002562,
      # if TRUE, apply this condition
      year(start_date) <= 2024,
      # if FALSE, keep
      TRUE
    )
  ) %>%
  print()


# for juruena, all photos processed
# ok

# for maraca, upper limit 2021
deployments <- deployments %>%
  filter(
    if_else(
      project_id == 2002584,
      # if TRUE, apply this condition
      year(start_date) <= 2024,
      # if FALSE, keep
      TRUE
    )
  ) %>%
  print()


# now, update images keeping only catalogued deployments
images <- images %>%
  filter(deployment_id %in% deployments$deployment_id) %>%
  print()



#----- keep only sites with > 2 years of data

moreThan2Years <- deployments %>%
  distinct(placename, year(start_date)) %>%
  group_by(placename) %>%
  count() %>%
  filter(n >1) %>%
  print(n=Inf) %>%
  pull(placename)
moreThan2Years

deployments <-deployments %>%
  filter(placename %in% moreThan2Years) %>%
  print()

images <- images %>%
  filter(deployment_id %in% deployments$deployment_id) %>%
  print()



#----- use only data from first 30 days of sampling

# reset end dates using max photo date
deployments <- deployments %>%
  mutate(end_date = case_when(end_date > start_date + 30 ~ start_date + 30,
                              .default = end_date)) %>%
  print()

# crop images using updated end_date
# lets also add start_date because we will need this to create "count" object
images <- images %>%
  left_join(deployments %>%
              distinct(deployment_id, start_date, end_date),
            by = "deployment_id") %>%
  filter(photo_date <= end_date) %>%
  print()



#----- remove deployments with < 5 days sampling
# 5 days is the length of a sampling occasion

deployments <- deployments %>%
  filter(difftime(end_date, start_date, units = "days") >= 5) %>%
  print()

images <- images %>%
  filter(deployment_id %in% deployments$deployment_id) %>%
  print()



##########################################################################
##########################################################################
#----- from raw data to array format for multi-species Royle-Nichols model
##########################################################################
##########################################################################


# lets do it separately for each project 
# in the near future we can try a multi-region model

trials <- deployments %>%
  distinct(deployment_id, .keep_all = TRUE) %>%
  # keep only selected project
  filter(project_id == 2002545) %>%
  # create sampling_event and number of trialss
  mutate(sampling_event = year(start_date),
         trials = round(as.numeric(end_date-start_date)/5)) %>%
  distinct(deployment_id, placename, sampling_event, trials) %>%
  arrange(deployment_id, placename, sampling_event) %>%
  print()


counts <- images %>%
  # keep only deployments in trials
  filter(deployment_id %in% trials$deployment_id) %>%
  # crop photos out of sampling range
  filter(photo_date >= start_date,
         photo_date <= start_date + 29) %>%
  # create species and sampling_event
  mutate(species = paste(genus, species),
         sampling_event = year(start_date)) %>%
  select(deployment_id, sampling_event, species, start_date, photo_date) %>%
  arrange(sampling_event, deployment_id, photo_date) %>%
  # create dategroups
  group_by(deployment_id) %>%
  mutate(days_since_start = as.numeric(photo_date - min(start_date)),
         dategroup = (days_since_start %/% 5) + 1) %>%
  ungroup() %>%
  distinct(sampling_event, deployment_id, species, dategroup) %>%
  group_by(sampling_event, deployment_id, species) %>%
  summarise(y = n_distinct(dategroup)) %>%
  ungroup() %>%
  print()



rn_data_2002545 <- counts %>%
  full_join(trials) %>%
  select(placename, sampling_event, species, trials, y) %>%
  # complete
  group_by(placename, sampling_event) %>%
  mutate(trials = max(trials)) %>%
  ungroup() %>%
  complete(species,
           nesting(placename, sampling_event, trials),
           fill = list(y = 0)) %>%
  ungroup() %>%
  drop_na(species) %>%
  arrange(species, placename, sampling_event) %>%
  select(placename, sampling_event, species, trials, y) %>%
  print(n=50)



saveRDS(rn_data_2002545, here("output","rn_data_2002545.rds"))
