# function to make map
make_map <- function(x) {
  deployments %>%
    filter(project_id == x) %>%
    distinct(placename, longitude, latitude) %>%
    leaflet() %>%
    addProviderTiles(provider = "Esri.NatGeoWorldMap") %>%
    addCircleMarkers(radius = 2, color = "black",
                     label = ~placename)
}