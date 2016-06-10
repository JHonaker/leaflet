leafletHeatmapDependencies <- function() {
    list(
        htmltools::htmlDependency(
            "leaflet-heat",
            "0.2.0",
            system.file("htmlwidgets/plugins/Leaflet.Heat", package = "leaflet"),
            script = c('leaflet-heat.js')
        )
    )        
}

addHeatLayer <- function(
  map, lng = NULL, lat = NULL, layerId = NULL, group = NULL,
  radius = 25, blur = 15, intensity = 1, max = 1.0,
  minOpacity = 0.1, maxZoom = NULL, gradient = NULL,
  data = getMapData(map)) {
    map$dependencies <- c(map$dependencies, leafletHeatmapDependencies())

    pts = derivePoints(data, lng, lat, missing(lng), missing(lat), "addHeatLayer")

    invokeMethod(
       map, data, "addHeatLayer", pts$lat, pts$lng, intensity,
       Filter(
       Negate(is.null),
       list(
         minOpacity = minOpacity,
         maxZoom = maxZoom,
         max = max,
         radius = radius,
         blur = blur,
         gradient = gradient
     )),
     layerId
   ) %>%
     expandLimits(pts$lat,pts$lng)
}

removeHeatLayer <- function(map, layerId = NULL) {
    invokeMethod(map, getMapData(map), 'removeHeatLayer', layerId)
}

clearHeatLayer <- function(map, layerId = NULL) {
    invokeMethod(map, NULL, 'clearHeatLayer')
}
