#' Compute Miller circularity index
#'
#' @description
#' Compute Miller circularity index of polygons.
#'
#' @details
#' \eqn{I_M = \frac{4\pi A_p}{P_p^2}}, with \eqn{A_p} the area of a polygon and \eqn{P_{p}} its perimeter.
#' It is the ratio between the area of the polygon and a theoretical circle with the same perimeter.
#' In this sense, Miller similarity index to a circle is also written \eqn{I_M = \frac{A_p}{\pi(\frac{P_p}{2\pi})^2}}.
#' Miller index is normalized between `[0-1]`.
#'
#'
#' @param sfpolygons A sf object composed of polygons
#' @return `sfpoygons` with miller_index as a new variable
#'
#' @references Robert, Sandrine, Éric Grosso, Pascal Chareille, et Hélène Noizet. 2014. « MorphAL (Morphological Analysis) : un outil d’analyse de morphologie urbaine ». In Archéologie de l’espace urbain, édité par Elisabeth Lorans et Xavier Rodier, 451‑63. Perspectives Villes et Territoires. Tours: Presses universitaires François-Rabelais. [https://doi.org/10.4000/books.pufr.7717]( https://doi.org/10.4000/books.pufr.7717).
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_circularity <- function(sfpolygons){
  sfpolygons_as_multilinestring <- sf::st_cast(x = sfpolygons, to = "MULTILINESTRING")
  perimeter_polygon <- tibble::tibble(perimeter_polygon = as.numeric(sf::st_length(x = sfpolygons_as_multilinestring)))

  sfpolygons <- sfpolygons |>
    dplyr::mutate(area_polygon = as.numeric(sf::st_area(x=sf::st_geometry(sfpolygons)))) |>
    dplyr::bind_cols(perimeter_polygon) |>
    dplyr::mutate(miller_index = (4*pi*.data$area_polygon)/(.data$perimeter_polygon^2)) |>
    dplyr::select(-.data$area_polygon, -.data$perimeter_polygon)

  return(sfpolygons)
}
