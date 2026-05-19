
# clean environment
rm(list=ls())


#----- load libraries
library(here)
library(tidyverse)
library(leaflet)


#----- load functions
source(here("R", "calculate_time_lag.R"))
source(here("R", "plot_deployment_operation.R"))



#----- read data
florestal_fixed_coords <- readRDS(here("output", "florestal_fixed_coords.rds"))
projects <- florestal_fixed_coords$projects
deployments <- florestal_fixed_coords$deployments
images <- florestal_fixed_coords$images


#----- check dates

# NB! incorrect dates should be checked and fixed in Wildlife Insights
# however, here we will provisionally exclude any deployments with incorrect dates


# check individual projects and years
# the idea is to compare the lags table with the plot of deployment operation
# use common sense to decide if lags and gaps are ok of if they point to problems
# lets summarily remove any suspicious deployment (provisionally)
# or redefine end_date if this is the case
# hopefuly we can automate this process in the future



#----- gurupi

calculate_time_lag(2002545, 2016)
print(lags)
plot_deployment_operation(2002545, 2016)
# change start:
# change end: "CT-RBG-1-14 2016-10-23", 

calculate_time_lag(2002545, 2017)
print(lags)
plot_deployment_operation(2002545, 2017)

calculate_time_lag(2002545, 2018)
print(lags)
plot_deployment_operation(2002545, 2018)

calculate_time_lag(2002545, 2019)
print(lags)
plot_deployment_operation(2002545, 2019)

calculate_time_lag(2002545, 2020)
print(lags)
plot_deployment_operation(2002545, 2020)
# remove: "CT-RBG-2-85 09/14/2020"
deployments <- deployments %>%
  filter(deployment_id != "CT-RBG-2-85 09/14/2020") %>%
  print()

calculate_time_lag(2002545, 2021)
print(lags)
plot_deployment_operation(2002545, 2021)


calculate_time_lag(2002545, 2022)
print(lags)
plot_deployment_operation(2002545, 2022)
# change start:
# change end: "CT-RBG-2-73 2022-09-22"
# remove: "CT-RBG-2-84 2022-09-24"
deployments <- deployments %>%
  filter(deployment_id != "CT-RBG-2-84 2022-09-24") %>%
  print()

calculate_time_lag(2002545, 2023)
print(lags)
plot_deployment_operation(2002545, 2023)

calculate_time_lag(2002545, 2024)
print(lags)
plot_deployment_operation(2002545, 2024)
# change end: "CT-RBG-1-04 2024-07-26", "CT-RBG-1-21 2024-07-26", "CT-RBG-2-42 2024-07-26",
# "CT-RBG-2-80 2024-07-24", "CT-RBG-2-84 2024-07-27"

calculate_time_lag(2002545, 2025)
print(lags)
plot_deployment_operation(2002545, 2025)
# change end: "CT-RBG-2-83 2025-07-26", "CT_RBG-2-85 2025-07-26"



#----- terra do meio

calculate_time_lag(2002554, 2016)
print(lags)
plot_deployment_operation(2002554, 2016)
# change end: "CT-TDM-1-74 2016-06-12"

calculate_time_lag(2002554, 2017)
print(lags)
plot_deployment_operation(2002554, 2017)
# change start: "CT-TDM-1-121 2017-06-01"

calculate_time_lag(2002554, 2018)
print(lags)
plot_deployment_operation(2002554, 2018)
# change start: "CT-TDM-1-11 2018-07-06", "CT-TDM-1-86 2018-07-02"
# change end: "CT-TDM-1-17 2018-07-05", "CT-TDM-1-32 2018-07-04", "CT-TDM-1-43 2018-07-04"
# remove: "CT-TDM-1-87 2018-07-02"

calculate_time_lag(2002554, 2019)
print(lags)
plot_deployment_operation(2002554, 2019)
# change end: "CT-TDM-2-22 2019-09-06"
# expand end: "CT-TDM-2-42 2019-09-08"
#deployments <- deployments %>%
#  filter(deployment_id != "CT-RBG-2-133 2016-10-24") %>%
#  print()

calculate_time_lag(2002554, 2022)
print(lags)
plot_deployment_operation(2002554, 2022)
# change end: "CT-TDM-2-05 2022-06-17", "CT-TDM-2-31 2022-06-13", "CT-TDM-2-66 2022-06-20"
# expand end: "CT-TDM-2-25 2022-06-21"

calculate_time_lag(2002554, 2023)
print(lags)
plot_deployment_operation(2002554, 2023)
# change end: "CT-TDM-2-102 2023-06-21"
# remove: CT-TDM-2-46 2023-06-23

calculate_time_lag(2002554, 2025)
print(lags)
plot_deployment_operation(2002554, 2025)
# change start: "CT-TDM-2-56 2025-06-29"
# change end: "CT-TDM-2-16 2025-06-27", "CT-TDM-2-91 2025-07-01"



#----- jamari

calculate_time_lag(2002562, 2016)
print(lags)
plot_deployment_operation(2002562, 2016)
# change start: "CT-669 2016-09-21"

calculate_time_lag(2002562, 2017)
print(lags)
plot_deployment_operation(2002562, 2017)
# change start: "CT-745 2017-11-08"
# change end: "CT-709 2017-11-04"
# remove: "CT-668 2017-11-12"

calculate_time_lag(2002562, 2018)
print(lags)
plot_deployment_operation(2002562, 2018)

calculate_time_lag(2002562, 2019)
print(lags)
plot_deployment_operation(2002562, 2019)
# change end: "CT-561 2019-08-06", "CT-591 2019-07-27"

calculate_time_lag(2002562, 2020)
print(lags)
plot_deployment_operation(2002562, 2020)
# change end: "CT-630 2020-11-06"

calculate_time_lag(2002562, 2021)
print(lags)
plot_deployment_operation(2002562, 2021)
# change end: "CT-524 2021-11-04", "CT-592 2021-11-06", "CT-705 2021-11-07"

calculate_time_lag(2002562, 2023)
print(lags)
plot_deployment_operation(2002562, 2023)
# change start: 
# change end: "CT-143 23/09/2023", "CT-259 11/11/2023", "CT-631 26/09/2023", "CT-745 19/09/2023"
# remove: "CT-144 23/09/2023", "CT-708 20/09/2023", "CT-745 19/09/2023"

calculate_time_lag(2002562, 2024)
print(lags)
plot_deployment_operation(2002562, 2024)
# change start: 
# change end: "CT-182 20/09/2024", "CT-258 20/09/2024", "CT-562 18/09/2024", 
# "CT-593 22/09/2024", "CT-630 22/09/2024", "CT-631 22/09/2024", "CT-632 22/09/2024",
# "CT-707 24/09/2024"
# remove: "CT-560 17/09/2024", "CT-670 11/11/2024", "CT-708 19/09/2024", "CT-743 25/09/2024"

calculate_time_lag(2002562, 2025)
print(lags)
plot_deployment_operation(2002562, 2025)
# change start: "CT-744  25/10/2025"
# change end: "CT-144 08/10/2025", "CT-146 08/10/2025", "CT-183 07/10/2025",
# "CT-220 07/10/2025", "CT-221 07/10/2025", "CT-447 01/10/2025",
# "CT-591 04/10/2025", "CT-592 04/10/2025", "CT-593 04/10/2025", 
# "CT-599 01/10/2025", "CT-669 04/10/2025", "CT-670 03/10/2025", 
# "CT-783 04/10/2025"
# add days to photo date: "CT-521 01/10/2025"
# remove: "CT-257 07/10/2025", "CT-258 07/10/2025", 
deployments <- deployments %>%
  filter(! deployment_id %in% c("CT-667 06/10/2025", "CT-706 06/10/2025")) %>%
  print()


#----- juruena

calculate_time_lag(2002576, 2016)
print(lags)
plot_deployment_operation(2002576, 2016)

calculate_time_lag(2002576, 2017)
print(lags)
plot_deployment_operation(2002576, 2017)
# change start: "CT-PNJU-1-26 2017-06-05", "CT-PNJU-1-7 2017-06-05"
# change end: "CT-PNJU-2-11 05/31/2017", "CT-PNJU-2-3 2017-06-01", "CT-PNJU-2-9 2017-06-01"
# remove: "CT-PNJU-1-11 2017-05-31", "CT-PNJU-2-37 2017-06-04", "CT-PNJU-2-4 2017-06-03"

calculate_time_lag(2002576, 2018)
print(lags)
plot_deployment_operation(2002576, 2018)
# change start: "CT-PNJU-1-27 2018-06-15"

calculate_time_lag(2002576, 2019)
print(lags)
plot_deployment_operation(2002576, 2019)
# change start: "CT-PNJU-1-36 2019-06-04"
# change end: "CT-PNJU-1-25 2019-06-09"

calculate_time_lag(2002576, 2020)
print(lags)
plot_deployment_operation(2002576, 2020)
# change end: "CT-PNJU-1-13 08/20/2020", "CT-PNJU-1-26 08/18/2020", "CT-PNJU-1-34 08/18/2020",
# "CT-PNJU-1-4 08/21/2020", "CT-PNJU-1-5 08/17/2020", "CT-PNJU-2-12 08/19/2020"
# remove: "CT-PNJU-1-19 08/18/2020", "CT-PNJU-2-16 08/19/2020"
deployments <- deployments %>%
  filter(! deployment_id %in% c("CT-PNJU-1-19 08/18/2020", "CT-PNJU-2-16 08/19/2020")) %>%
  print()

calculate_time_lag(2002576, 2022)
print(lags)
plot_deployment_operation(2002576, 2022)
# change start: "CT-PNJU-1-24 2022-08-15", "CT-PNJU-2-8 2022-08-11"
# change end: "CT-PNJU-1-25 2022-08-15", "CT-PNJU-1-8 2022-08-13", "CT-PNJU-2-36 2022-08-08"
# remove: "CT-PNJU-2-10 2022-08-11", "CT-PNJU-2-28 2022-08-10"

calculate_time_lag(2002576, 2024)
print(lags)
plot_deployment_operation(2002576, 2024)
# change start: 
# change end: "CT-PNJU-1-11 2024-06-19", "CT-PNJU-2-14 2024-07-03", "CT-PNJU-2-16 2024-07-05"
# remove: "CT-PNJU-2-22 2024-06-20", "CT-PNJU-2-34 2024-06-18"



#----- maraca

calculate_time_lag(2002584, 2018)
print(lags)
plot_deployment_operation(2002584, 2018)
# change start: "CT-EEM-2-40 2018-12-18"
# change end: "CT-EEM-1-13 2018-12-14", "CT-EEM-2-39 2018-12-18", "CT-EEM-2-40 2018-12-18"

calculate_time_lag(2002584, 2021)
print(lags)
plot_deployment_operation(2002584, 2021)
# change end: "CT-EEM-1-5 2021-03-06", "CT-EEM-2-54 2021-03-04"
# remove: "CT-EEM-2-59 2021-03-05"

calculate_time_lag(2002584, 2025)
print(lags)
plot_deployment_operation(2002584, 2025)
# change start: "CT-EEM-2-25 2025-12-02", "CT-EEM-2-26 2025-12-01", "CT-EEM-2-35 2025-12-01", "CT-EEM-2-36 2025-12-01" 
# change end: "CT-EEM-2-32 2025-11-30", "CT-EEM-2-33 2025-12-01", "CT-EEM-2-53 2025-12-01"
# remove: "CT-EEM-2-22 2025-11-29", "CT-EEM-2-60 2025-12-03"



#----- tumucumaque

calculate_time_lag(2003586, 2021)
print(lags, n=Inf)
plot_deployment_operation(2003586, 2021)
# change start: "CT-PNMT-40 11/02/2021"
# change end: "CT-PNMT-1 2021-11-01", "CT-PNMT-12 2021-11-05", "CT-PNMT-19 2021-11-05", 
# "CT-PNMT-21 2021-11-06", "CT-PNMT-29 2021-11-01", "CT-PNMT-39 11/02/2021", "CT-PNMT-40 11/02/2021", 
# "CT-PNMT-45 11/05/2021", "CT-PNMT-47 11/03/2021", "CT-PNMT-48 11/03/2021", 
# "CT-PNMT-59 11/03/2021", 
# remove: "CT-PNMT-34 11/01/2021", "CT-PNMT-49 11/03/2021", "CT-PNMT-55 11/03/2021",
# "CT-PNMT-62 11/03/2021"
deployments <- deployments %>%
  filter(! deployment_id %in% c("CT-PNMT-14 2021-11-05", "CT-PNMT-42 11/02/2021",
                                "CT-PNMT-51 11/03/2021", "CT-PNMT-6 11/01/2021",
                                "CT-PNMT-9 11/02/2021")) %>%
  print()

calculate_time_lag(2003586, 2022)
print(lags, n=Inf)
plot_deployment_operation(2003586, 2022)
# change start: "CT-PNMT-23 2022-10-08", "CT-PNMT-30 2022-10-09"
# change end: "CT-PNMT--20 2022-10-11", "CT-PNMT-13 2022-10-07", "CT-PNMT-23 2022-10-08",
# "CT-PNMT-24 2022-10-08", "CT-PNMT-29 2022-10-11", "CT-PNMT-33 2022-10-08",
# "CT-PNMT-43 2022-10-10", "CT-PNMT-44A 2022-10-10", "CT-PNMT-47 2022-10-10",
# "CT-PNMT-49 2022-10-08", 
# delete photos past end: "CT-PNMT-14 2022-10-07", "CT-PNMT-25 2022-10-08",
# "CT-PNMT-36 2022-10-12", "CT-PNMT-42 2022-10-10", "CT-PNMT-54 2022-10-10"
# remove: "CT-PNMT-16 2022-10-07", "CT-PNMT-27 2022-10-07", "CT-PNMT-53 2022-10-10",
# "CT-PNMT-9 2022-10-07"
# check what to do: "CT-PNMT-3 2022-12-07", "CT-PNMT-60 2022-10-08", "CT-PNMT-61 2022-10-08",
deployments <- deployments %>%
  filter(! deployment_id %in% c("CT-PNMT-10 2022-10-07", "CT-PNMT-11 2022-10-07")) %>%
  print()

calculate_time_lag(2003586, 2023)
print(lags, n=Inf)
plot_deployment_operation(2003586, 2023)
# change start: 
# change end: 
# remove: 

calculate_time_lag(2003586, 2024)
print(lags)
plot_deployment_operation(2003586, 2024)
# change start: 
# change end: 
# remove: 



#----- tapajos

calculate_time_lag(2004835, 2022)
print(lags)
plot_deployment_operation(2004835, 2022)
# change start: 
# change end: 
# remove: 

calculate_time_lag(2004835, 2023)
print(lags)
plot_deployment_operation(2004835, 2023)
# change start: 
# change end: 
# remove: 

calculate_time_lag(2004835, 2025)
print(lags)
plot_deployment_operation(2004835, 2025)
# change start: 
# change end: 
# remove: 



#----- caxiuana

calculate_time_lag(2006780, 2023)
print(lags)
plot_deployment_operation(2006780, 2023)
# change start: 
# change end: 
# remove: 

calculate_time_lag(2006780, 2024)
print(lags)
plot_deployment_operation(2006780, 2024)
# change start: 
# change end: 
# remove: 

calculate_time_lag(2006780, 2025)
print(lags)
plot_deployment_operation(2006780, 2025)
# change start: 
# change end: 
# remove: 



#----- tapirape
#calculate_time_lag(2007402, 2024)
#print(lags)
#plot_deployment_operation(2007402, 2024)


#----- jari

calculate_time_lag(2007439, 2024)
print(lags)
plot_deployment_operation(2007439, 2024)
# change start: 
# change end: 
# remove: 

calculate_time_lag(2007439, 2025)
print(lags)
plot_deployment_operation(2007439, 2025)
# change start: 
# change end: 
# remove: 



#----- rio acre
calculate_time_lag(2009348, 2025)
print(lags)
plot_deployment_operation(2009348, 2025)
# change start: 
# change end: 
# remove: 
deployments <- deployments %>%
  #filter(deployment_id != "CT-RBG-2-133 2016-10-24") %>%
  print()



#----- descobrimento
calculate_time_lag(2011116, 2025)
print(lags)
plot_deployment_operation(2011116, 2025)
# change start: 
# change end: 
# remove: 
deployments <- deployments %>%
  #filter(deployment_id != "CT-RBG-2-133 2016-10-24") %>%
  print()


# bom jesus
#


#----- monte pascoal
calculate_time_lag(2012253, 2025)
print(lags)
plot_deployment_operation(2011116, 2025)
# change start: 
# change end: 
# remove: 
deployments <- deployments %>%
  #filter(deployment_id != "CT-RBG-2-133 2016-10-24") %>%
  print()


# update projects and images based on corrected deployments
projects <- projects %>%
  filter(project_id %in% deployments$project_id) %>%
  print()

images <- images %>%
  filter(deployment_id %in% deployments$deployment_id) %>%
  print()


# save aggregated data
data_fixed_coordinates <- list(projects=projects,
                               deployments=deployments,
                               images=images)
saveRDS(data_fixed_coordinates, here("output", "data_fixed_coordinates.rds"))

