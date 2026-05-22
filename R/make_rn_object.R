#' Funçao para criar objeto para modelo royle-nichols
#'
#' @param nome_arquivo Data file name
#' @returns filtered dataframe
#' @author
#' Elildo Carvalho Jr
#' @export
#' @examples
#' make_rn_object()
#' @import tidyverse
#' @import lubridate

make_rn_object <- function(x) {
  
  trials <- deployments %>%
    # keep only selected project
    filter(project_id == x) %>%
    distinct(deployment_id, .keep_all = TRUE) %>%
    # create sampling_event and number of trialss
    mutate(sampling_event = year(start_date),
           #trials = round(as.numeric(end_date-start_date)/5),
           # use ceiling instead of round so that we always get next upper integer
           trials = ceiling(as.numeric(end_date-start_date)/5)) %>%
    distinct(deployment_id, placename, sampling_event, trials) %>%
    arrange(deployment_id, placename, sampling_event)
  
  
  counts <- images %>%
    # keep only deployments in trials
    filter(deployment_id %in% trials$deployment_id) %>%
    distinct(deployment_id, genus, species, start_date, photo_date) %>%
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
    ungroup()
  
  
  rn_data <- counts %>%
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
    select(placename, sampling_event, species, trials, y)
  
  
  assign("rn_data", rn_data, envir = .GlobalEnv)  
  
}

