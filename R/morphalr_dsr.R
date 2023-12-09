#' Compute distance to minimal bounding rectangle
#'
#' @description
#' Compute the distance of a polygon to its minimal bounding rectangle (DSR).
#'
#' @details
#' \eqn{DSR = 1 - \frac{A_p}{A_{mbb}}}, with \eqn{A_p} the area of a polygon and \eqn{A_{mbb}}
#' the area of its minimal oriented bounding box. DSR is normalized between `[0-1]`.
#'
#' @param sfpolygons A sf object composed of polygons
#' @return `sfpoygons` with DSR as a new variable
#'
#' @references Ali, Atef Bel Hadj. 2001. « Qualité géométrique des entités géographiques surfaciques. Application à l’appariement et définition d’une typologie des écarts geométriques ». Phdthesis, université Gustave Effeil ; Anciennement Université de Marne La vallée. [https://hal.science/tel-03244834](https://hal.science/tel-03244834), p. 92.
#' @references Robert, Sandrine, Éric Grosso, Pascal Chareille, et Hélène Noizet. 2014. « MorphAL (Morphological Analysis) : un outil d’analyse de morphologie urbaine ». In Archéologie de l’espace urbain, édité par Elisabeth Lorans et Xavier Rodier, 451‑63. Perspectives Villes et Territoires. Tours: Presses universitaires François-Rabelais. [https://doi.org/10.4000/books.pufr.7717]( https://doi.org/10.4000/books.pufr.7717).
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_dsr <- function(sfpolygons){
  # create a list of polygons
  listpolygons <- sfpolygons |>
    tibble::rowid_to_column(var = 'rowidboundingbox') |>
    dplyr::group_by(.data$rowidboundingbox) |>
    dplyr::group_split()

  listboundingbox <- lapply(listpolygons, morphalr_mbboxoriented) # apply morphalr_mbboxoriented function

  sfboudingbox <- dplyr::bind_rows(listboundingbox)

  #### compute DSR
  area_bbox <- sfboudingbox |>
    dplyr::mutate(area_bbox = as.numeric(sf::st_area(x=.data$geometry)))

  sfpolygons <- sfpolygons |>
    dplyr::mutate(area_polygon = as.numeric(sf::st_area(x=sf::st_geometry(sfpolygons)))) |>
    dplyr::bind_cols(
      area_bbox |> sf::st_drop_geometry()
    ) |>
    dplyr::mutate(dsr = 1 - (.data$area_polygon/.data$area_bbox) ) |>
    dplyr::select(-.data$area_bbox, -.data$area_polygon)

  return(sfpolygons)

}
