library(leaflet)
library(Rcpp)




leaflet() %>%
  fitBounds(lng1 = -86, lng2 = -82, lat1 = 8, lat2 = 11) %>%
  addProviderTiles(providers$OpenStreetMap.Mapnik, group = "Open StreeT Map") %>%
  addTiles(urlTemplate ="https://mts1.google.com/vt/lyrs=s&hl=en&src=app&x={x}&y={y}&z={z}&s=G", attribution = 'Google', group = "Google Maps") %>%
  addMarkers(data= datos, clusterOptions = markerClusterOptions(),
             group = "Registros",
             popup = paste(
               "Especie: ", datos$Especie, "<br>",
               "Nombre común: ", datos$Nombre_com, "<br>",
               "Registros: ", datos$Total, "<br>",
               "Provincia: ", datos$provincia, "<br>",
               "Cantón: ", datos$canton, "<br>",
               "Distrito: ", datos$distrito, "<br>")) %>%
  addMarkers(data= fuera,
             group = "Registros eliminados",
             popup = paste(
               "Especie: ", fuera$Especie, "<br>",
               "Nombre común: ", fuera$Nombre_com, "<br>",
               "Registros: ", fuera$Total, "<br>",
               "Sitio: ", fuera$Lugar, "<br>",
               "Plataforma: ", fuera$Plataforma)) %>%
  addMarkers(data= titi1, group = "Registros titi",
             popup = paste(
               "Especie: ", titi1$Especie, "<br>",
               "Nombre común: ", titi1$Nombre_com, "<br>",
               "Registros: ", titi1$Total, "<br>",
               "Provincia: ", titi1$provincia, "<br>",
               "Cantón: ", titi1$canton, "<br>",
               "Distrito: ", titi1$distrito, "<br>")) %>%
  addMarkers(data= congo1, group = "Registros congo",
             popup = paste(
               "Especie: ", congo1$Especie, "<br>",
               "Nombre común: ", congo1$Nombre_com, "<br>",
               "Registros: ", congo1$Total, "<br>",
               "Provincia: ", congo1$provincia, "<br>",
               "Cantón: ", congo1$canton, "<br>",
               "Distrito: ", congo1$distrito, "<br>")) %>%
  addMarkers(data= araña1, group = "Registros araña",
             popup = paste(
               "Especie: ", araña1$Especie, "<br>",
               "Nombre común: ", araña1$Nombre_com, "<br>",
               "Registros: ", araña1$Total, "<br>",
               "Provincia: ", araña1$provincia, "<br>",
               "Cantón: ", araña1$canton, "<br>",
               "Distrito: ", araña1$distrito, "<br>")) %>%
  addMarkers(data= cara_blanca1, group = "Registros cara blanca",
             popup = paste(
               "Especie: ", cara_blanca1$Especie, "<br>",
               "Nombre común: ", cara_blanca1$Nombre_com, "<br>",
               "Registros: ", cara_blanca1$Total, "<br>",
               "Provincia: ", cara_blanca1$provincia, "<br>",
               "Cantón: ", cara_blanca1$canton, "<br>",
               "Distrito: ", cara_blanca1$distrito, "<br>")) %>%
  addPolygons(
    data = sf_datos_suma,
    stroke=T, fillOpacity = 0,
    color="red", weight=0.8, opacity= 2.0,
    group = "Distritos con registros",
    popup = paste(
      "Provincia: ", sf_datos_suma$provincia, "<br>",
      "Cantón: ", sf_datos_suma$canton, "<br>",
      "Distrito: ", sf_datos_suma$distrito, "<br>",
      "Registros: ", sf_datos_suma$Total, "<br>")) %>%
  addHeatmap(data = datos,
             lng = ~longitude, lat = ~latitude, intensity = ~Total,
             blur = 10, max = max(datos$Total), radius = 15,
             group = "Densidad") %>%
  addPolygons(data= asp_wgs84, color = "#35b541", fill = TRUE, fillColor = "#35b541", stroke = T, weight = 3, opacity = 0.5,
              group = "ASP",
              popup = paste("Área Silvestre Protegida:", asp_wgs84$nombre_asp, "Área de conservación:", asp_wgs84$nombre_ac, sep = '<br/>')) %>%
  addPolygons(data = ac_wgs84, color = "#35b541", fill = TRUE, fillColor = "#35b541", stroke = T, weight = 3, opacity = 0.5,
              group = "Área de Conservación",
              popup = paste(
                "Área de conservación: ", ac_wgs84$AREA_CONSE, "<br>")) %>%
  addPolylines(data = redvial_wgs84, color = "#818c8c", fill = TRUE, fillColor = "#818c8c", stroke = T, weight = 3, opacity = 0.5,
               group = "Red Vial",
               smoothFactor = 10) %>%
  addLayersControl(baseGroups = c("OpenStreetMap", "Google Maps"),
                   overlayGroups = c("Registros", "Registros eliminados", "Registros titi", "Registros congo", "Registros araña", "Registros cara blanca", "Distritos con registros", "Densidad", "ASP", "Área de Conservación", "Red Vial"),
                   options = layersControlOptions(collapsed = TRUE))  %>%
  addScaleBar()  %>%
  hideGroup(c("Registros eliminados", "Distritos con registros", "Registros titi", "Registros congo", "Registros araña", "Registros cara blanca", "Densidad", "ASP", "Área de Conservación", "Red Vial")) %>%
  addMiniMap(
    toggleDisplay = TRUE,
    position = "bottomleft",
    tiles = providers$OpenStreetMap.Mapnik)
