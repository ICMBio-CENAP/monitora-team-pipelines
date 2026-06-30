
# clean environment
rm(list=ls())


#----- setup
source("02_scripts/00_setup.R")


#----- read data
florestal_fixed_taxonomy <- readRDS("01_entrada/dados_processados/florestal_fixed_taxonomy.rds")
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
  mutate(end_date = case_when(end_date > start_date + 29 ~ start_date + 29,
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


rn_data_gurupi <- make_rn_object(2002545)
rn_data_gurupi

rn_data_tdm <- make_rn_object(2002554)
rn_data_tdm

rn_data_jamari <- make_rn_object(2002562)
rn_data_jamari
rn_data_jamari[1746,] 

rn_data_juruena <- make_rn_object(2002576)
rn_data_juruena

rn_data_maraca <- make_rn_object(2002584)
rn_data_maraca


saveRDS(rn_data_gurupi, "01_entrada/dados_processados/BernP_data_gurupi.rds")
saveRDS(rn_data_tdm, "01_entrada/dados_processados/BernP_data_tdm.rds")
saveRDS(rn_data_jamari, "01_entrada/dados_processados/BernP_data_jamari.rds")
saveRDS(rn_data_juruena, "01_entrada/dados_processados/BernP_data_juruena.rds")
saveRDS(rn_data_maraca, "01_entrada/dados_processados/BernP_data_maraca.rds")

