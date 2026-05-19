#' Funçao para calcular time lag entre start_date e primeira foto, e end_date e ultima fot
#'
#' @param nome_arquivo Data file name
#' @returns filtered dataframe
#' @author
#' Elildo Carvalho Jr
#' @export
#' @examples
#' calculate_time_lag()
#' @import tidyverse
#' @import lubridate

calculate_time_lag <- function(df, year) {
  
  temp_deployment <- deployments %>%
    filter(project_id == df, year(start_date) == year) %>%
    distinct(deployment_id, start_date, end_date)
  
  temp_images <- images %>%
    filter(deployment_id %in% temp_deployment$deployment_id) %>%
    distinct(deployment_id,timestamp) %>%
    mutate(photo_date = as.Date(timestamp))
  
  lags <- left_join(temp_images, temp_deployment, by = "deployment_id") %>%
    group_by(deployment_id) %>%
    filter(photo_date == max(photo_date) | photo_date == min(photo_date)) %>%
    mutate(diff_start = as.numeric(difftime(photo_date, start_date, units = "days")),
           diff_end = as.numeric(difftime(end_date, photo_date, units = "days"))) %>%
    summarise(diff_start = min(diff_start),
              diff_end = min(diff_end)) %>%
    filter(diff_start > 7 | diff_start < 0 | diff_end > 7 | diff_end < 0) %>%
    arrange(deployment_id)
  
  assign("lags", lags, envir = .GlobalEnv)  

  }

