#' Segments of polygons or lines
#'
#' @description
#' Extraction of segments (as `LINE`) composing polygons or lines.
#'
#' @details
#' When computing to `"MULTILINESTRING"`, output is equivalent to `sfobject` with a `GEOMETRY` of multiple segments as `LINES` in `MULTILINESTRING`.
#' When computing to `"LINESTRING"`, output is a long sf of `sfobject` where each row correspond to a segment with a `GEOMETRY` as `LINE`.
#'
#'
#' @param sfobject sf object (sfc is POLYGON or LINESTRING).
#' @param to type of sfc in sf output: `"MULTILINESTRING"` or `"LINESTRING"` (default is `"MULTILINESTRING"`).
#' @return sf object composed of segments.
#'
#' @author Diego Hernangómez
#'
#' @importFrom Rdpack reprompt
#' @export

mafa_geom_to_segment <- function(sfobject, to = 'MULTILINESTRING') {
  ggg <- sf::st_geometry(sfobject)

  #### check validity of geometry
  if (!unique(sf::st_geometry_type(ggg)) %in% c('POLYGON', 'LINESTRING')) {
    stop("Input should be LINESTRING or POLYGON")
  }

  #### loop to extract coordinates and create multilinestring
  for (k in 1:length(sf::st_geometry(ggg))) {
    sub <- ggg[k]
    geom <- lapply(
      1:(length(sf::st_coordinates(sub)[, 1]) - 1),
      function(i)
        rbind(
          as.numeric(sf::st_coordinates(sub)[i, 1:2]),
          as.numeric(sf::st_coordinates(sub)[i + 1, 1:2])
        )
    ) |>
      sf::st_multilinestring() |>
      sf::st_sfc()

    if (k == 1) {
      endgeom <- geom
    }
    else {
      endgeom <- rbind(endgeom, geom)
    }
  }

  endgeom <- endgeom |> sf::st_sfc(crs = sf::st_crs(sfobject))

  if (class(sfobject)[1] == "sf") {
    endgeom <- sf::st_set_geometry(sfobject, endgeom)
  }

  if (to == 'LINESTRING') {
    endgeom <- endgeom |> sf::st_cast('LINESTRING')
  }

  return(endgeom)
}
