
#----- load libraries
library(here)
library(tidyverse)

#----- read data
raw_data_bundle <- readRDS(here("output", "raw_data_bundle.rds"))

projects <- raw_data_bundle$projects
deployments <- raw_data_bundle$deployments
images <- raw_data_bundle$images

