#' Funçao para plotar operacao dos deployments
#'
#' @param nome_arquivo Data file name
#' @returns filtered dataframe
#' @author
#' Elildo Carvalho Jr
#' @export
#' @examples
#' plot_deployment_operation()
#' @import tidyverse
#' @import lubridate

plot_deployment_operation <- function(df, year) {
  
  temp_deployment <- deployments %>%
    filter(project_id == df, year(start_date) == year) %>%
    distinct(deployment_id, start_date, end_date)
  
  temp_images <- images %>%
    filter(deployment_id %in% temp_deployment$deployment_id) %>%
    distinct(deployment_id,timestamp) %>%
    mutate(photo_date = as.Date(timestamp))
  
  p <- left_join(temp_images, temp_deployment, by = "deployment_id") %>%
    group_by(deployment_id, start_date, end_date, photo_date) %>%
    count() %>%
    ungroup() %>%
    ggplot() +
    geom_segment(aes(x=start_date,
                     #y=reorder(deployment_id, desc(start_date)),
                     y=reorder(deployment_id, desc(deployment_id)),
                     xend=end_date, yend=deployment_id),
                 linewidth = 0.1, color="black") +
    geom_point(aes(x = photo_date,
                   y = deployment_id, size = n),
               color = "blue", alpha = 0.5) +
    #theme_classic() +
    theme(axis.text=element_text(size=8),
          axis.title=element_blank()) +
    theme(legend.position = "none")
  
  return(p)
  
}

