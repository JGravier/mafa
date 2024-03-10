#' Morphological complexity
#'
#' @description
#' Compute morphological complexity index of polygons.
#'
#' @details
#' \eqn{I_c = \frac{N_{pv}}{P_p}}, with \eqn{N_{pv}} the number of vertices of a polygon and \eqn{P_p} its perimeter.
#'
#'
#' @param sfpolygons A sf object composed of polygons.
#' @return `sfpoygons` with index as a new column, named `complexity_index`.
#'
#' @references Marie, Maxime, Abdelkrim Bensaid, et Daniel Delahaye. 2009. « Le rôle de la distance dans l’organisation des pratiques et des paysages agricoles : l’exemple du fonctionnement des exploitations laitières dans l’arc atlantique ». Cybergeo: European Journal of Geography. [https://doi.org/10.4000/cybergeo.22366](https://doi.org/10.4000/cybergeo.22366).
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

mafa_complexity <- function(sfpolygons){
  sfpolygons_as_multilinestring <- sf::st_cast(x = sfpolygons, to = "MULTILINESTRING")
  perimeter_polygon <- tibble::tibble(perimeter_polygon = as.numeric(sf::st_length(x = sfpolygons_as_multilinestring)))

  # count vertices
  count_vertices <- sf::st_coordinates(x = sfpolygons) |>
    tibble::as_tibble() |>
    dplyr::group_by(.data$L2) |>
    dplyr::count() |>
    dplyr::ungroup() |>
    dplyr::select(.data$n)

  # compute complexity
  sfpolygons <- sfpolygons |>
    dplyr::bind_cols(perimeter_polygon) |>
    dplyr::bind_cols(count_vertices) |>
    dplyr::mutate(complexity_index = .data$n/.data$perimeter_polygon) |>
    dplyr::select(-.data$n, -.data$perimeter_polygon)

  return(sfpolygons)
}
