#' Segment orientation
#'
#' @description
#' Compute orientations of segments (i.e. lines).
#'
#' @param sfsegments sf object with sfc as `"MULTILINESTRING"` or `"LINESTRING"`.
#' @param looking look direction parameter: `"N"` North or `"E"` East (default is North).
#' @param perpendicular logical parameter. If `TRUE`, perpendiculars to orientations between `[0;90]` (i.e. `[-90;0]`) degrees are recalculated in the interval `[0;90]` (default is `FALSE`).
#' @return sf object composed of segments (i.e. lines) with orientations.
#'
#' @references Robert, Sandrine, Éric Grosso, Pascal Chareille, et Hélène Noizet. 2014. « MorphAL (Morphological Analysis) : un outil d’analyse de morphologie urbaine ». In Archéologie de l’espace urbain, édité par Elisabeth Lorans et Xavier Rodier, 451‑63. Perspectives Villes et Territoires. Tours: Presses universitaires François-Rabelais. [https://doi.org/10.4000/books.pufr.7717]( https://doi.org/10.4000/books.pufr.7717).
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_segment_orientation <- function(sfsegments, looking = 'N', perpendicular = FALSE) {
  ggg <- sf::st_geometry(sfsegments)

  #### check validity of geometry
  if (!unique(sf::st_geometry_type(ggg)) %in% c('MULTILINESTRING', 'LINESTRING')) {
    stop("Input should be LINESTRING or MULTILINESTRING")
  }

  #### transform data as long LINESTRING sf
  if (!unique(sf::st_geometry_type(ggg)) == 'MULTILINESTRING') {
    sfsegments <- sfsegments |> sf::st_cast('LINESTRING')
  }

  #### compute orientation
  sfsegmentswgs84 <- sf::st_transform(x = sfsegments, crs = 4326)
  coordinatessegments <- sf::st_coordinates(sfsegmentswgs84)

  orientations <- geosphere::bearing(p1 = coordinatessegments[,1:2]) |>
    tibble::as_tibble() |>
    dplyr::bind_cols(coordinatessegments[,3] |>
                       tibble::as_tibble() |>
                       dplyr::rename(idline = .data$value)) |>
    dplyr::group_by(.data$idline) |>
    dplyr::filter(dplyr::row_number() == 1) |>
    dplyr::rename(orientation = .data$value)

  #### looking parameter
  if (looking == 'N') {
    orientations <- orientations |>
      dplyr::mutate(orientation = dplyr::case_when(
        .data$orientation >= -180 & .data$orientation < -90 ~ .data$orientation + 180,
        .data$orientation > 90 & .data$orientation <= 180 ~ .data$orientation - 180,
        TRUE ~ .data$orientation
      ))
  } else if (looking == 'E') {
    orientations <- orientations |>
      dplyr::mutate(orientation = .data$orientation - 90) |>
      dplyr::mutate(orientation = dplyr::case_when(
        .data$orientation >= -270 & .data$orientation < -90 ~ .data$orientation + 180,
        TRUE ~ .data$orientation
      ))
  }

  orientations <- orientations |>
    dplyr::ungroup() |>
    dplyr::select(.data$orientation)

  #### perpendicular parameter
  if (perpendicular == TRUE) {
    orientations <- orientations |>
      dplyr::mutate(orientation = dplyr::if_else(
        condition = .data$orientation >= -90 & .data$orientation < 0, true = .data$orientation + 90, false = .data$orientation
      ))
  }

  orientations <- sfsegments |>
    dplyr::bind_cols(orientations)

  return(orientations)
}
