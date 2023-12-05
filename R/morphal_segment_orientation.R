#' Compute segment orientation.
#'
#' @description
#' Compute orientations of segments (lines).
#'
#' @param sfsegments A sf object
#' @return A sf object composed of lines with orientations
#'
#' @importFrom Rdpack reprompt
#' @export

morphal_segment_orientation <- function(sfsegments) {
  ggg <- sf::st_geometry(sfsegments)

  #### check validity of geometry
  if (!unique(sf::st_geometry_type(ggg)) %in% c('MULTILINESTRING', 'LINESTRING')) {
    stop("Input should be LINESTRING or MULTILINESTRING")
  }

  #### transform data as long LINESTRING sf
  if (sf::st_geometry_type(ggg) == 'MULTILINESTRING') {
    sfsegments <- sfsegments |> sf::st_cast('LINESTRING')
  }

  #### compute orientation
  sfsegmentswgs84 <- st_transform(x = sfsegments, crs = 4326)
  coordinatessegments <- st_coordinates(sfsegmentswgs84)

  orientations <- tibble()

  for (i in 1:length(unique(coordinates[,3]))) {
    coordinatesmatrix <- coordinates[coordinates[,3]==i,, drop = FALSE]
    computeorientation <- geosphere::bearing(p1 = coordinatesmatrix[,1:2]) |>
      as_tibble() |>
      filter(!is.na(value))

    orientations <- orientations |>
      bind_rows(computeorientation)
  }

  return(orientations)
}
