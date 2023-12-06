#' Compute distance to convex hull
#'
#' @description
#' Compute the distance of a polygon to its convex hull (DSC).
#'
#' @details
#' \eqn{DSC = 1 - \frac{A_p}{A_{ch}}}, with \eqn{A_p} the area of a polygon and \eqn{A_{ch}} the area of its convex hull.
#' DSC is normalized between `[0-1]`.
#'
#'
#' @param sfpolygons A sf object composed of polygons
#' @return `sfpoygons` with DSC as a new variable
#'
#' @references Robert, Sandrine, Éric Grosso, Pascal Chareille, et Hélène Noizet. 2014. « MorphAL (Morphological Analysis) : un outil d’analyse de morphologie urbaine ». In Archéologie de l’espace urbain, édité par Elisabeth Lorans et Xavier Rodier, 451‑63. Perspectives Villes et Territoires. Tours: Presses universitaires François-Rabelais. [https://doi.org/10.4000/books.pufr.7717]( https://doi.org/10.4000/books.pufr.7717).
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_dsc <- function(sfpolygons){
  # create convex hull polygons
  sfconvexhull <- sf::st_convex_hull(x = sfpolygons)
  sfconvexhull <- sf::st_as_sf(sf::st_geometry(sfconvexhull)) |>
    dplyr::rename(geometry = .data$x)

  # compute DCR
  area_convexhull <- sfconvexhull |>
    dplyr::mutate(area_convexhull = as.numeric(sf::st_area(x=sf::st_geometry(sfconvexhull))))

  sfpolygons <- sfpolygons |>
    dplyr::mutate(area_polygon = as.numeric(sf::st_area(x=sf::st_geometry(sfpolygons)))) |>
    dplyr::bind_cols(
      area_convexhull |> sf::st_drop_geometry()
    ) |>
    dplyr::mutate(dsc = 1 - (.data$area_polygon/.data$area_convexhull) ) |>
    dplyr::select(-.data$area_convexhull, -.data$area_polygon)

  return(sfpolygons)

}
