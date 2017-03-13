output$contacts_map <- renderLeaflet({
  leaflet() %>%
    addTiles() %>%
    #addProviderTiles("Stamen.TonerLite",options = providerTileOptions(noWrap = TRUE)) %>%
    #setView(lat = 40.175576,lng = 44.513343, zoom = 7)
    addMarkers(lat=40.175576, lng=44.513343,popup="UN FAO office, Yerevan, Armenia")
})

output$mymap <- renderLeaflet({
  leaflet() %>%
    #addProviderTiles("Stamen.TonerLite",options = providerTileOptions(noWrap = TRUE)) %>%
    addProviderTiles("CartoDB.Positron") %>%
    addMarkers(lat = com_lats, lng = com_lngs,
               popup=paste0("Total Damage: ",as.character(map_database[["SUM(damages)"]]),br(),
                            "Total Loss: ",as.character(map_database[["SUM(loss)"]])),
               clusterOptions = markerClusterOptions()) %>%
    setView(lat = 40.175576,lng = 44.513343, zoom = 5)
})