
#----- load libraries
library(here)
library(tidyverse)

#----- read data
raw_data_bundle <- readRDS(here("output", "raw_data_bundle.rds"))

projects <- raw_data_bundle$projects
deployments <- raw_data_bundle$deployments
images <- raw_data_bundle$images


# keep only TEAM sites

# check and fix coordinates

# check and fix start and end dates

# check and fix photo dates


# save fixed data
data_bundle <- list(projects=projects,
                    deployments=deployments,
                    images=images)
saveRDS(data_bundle, here("output", "data_bundle.rds"))
