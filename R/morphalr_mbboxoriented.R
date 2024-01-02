#' Minimal oriented bounding rectangles
#'
#' @description
#' Create minimal oriented bounding rectangles of polygons.
#'
#' @param sfpolygon sf object composed of polygons.
#' @return sf object composed of minimal oriented bounding rectangles.
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_mbboxoriented <- function(sfpolygon){
  # extract minimal bounding box
  xyminbbox <- shotGroups::getMinBBox(as.matrix(sf::st_coordinates(sfpolygon)[,1:2]))$pts
  # add a point to close polygon
  xyminbbox <- rbind(xyminbbox, xyminbbox[1,])
  # create polygon as sf object
  minbboxpolygon <- sf::st_sfc(
      sf::st_polygon(
        list(
          cbind(
            xyminbbox[,1],
            xyminbbox[,2]
            ))),
    crs = sf::st_crs(sfpolygon)
    )
  minbboxpolygon <- sf::st_as_sf(minbboxpolygon) |>
    dplyr::rename(geometry = .data$x)

  return(minbboxpolygon)
}
