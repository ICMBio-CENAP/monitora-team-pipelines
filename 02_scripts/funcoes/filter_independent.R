#' Funçao para filtrar registros independentes
#'
#' @param nome_arquivo Data file name
#' @returns filtered dataframe
#' @author
#' Elildo Carvalho Jr
#' @export
#' @examples
#' filter_independent()
#' @import tidyverse
#' @import lubridate

filter_independent <- function(df, time_mins) {
  
  df <- df %>%
    arrange(project_id, deployment_id, timestamp, genus, species) %>%
    group_by(deployment_id, genus, species) %>%
    mutate(time_lag = difftime(timestamp, lag(timestamp), units = "mins")) %>%
    ungroup() %>%
    filter(is.na(time_lag) | time_lag > time_mins) %>%
    select(-time_lag)
  
  return(df)
}

