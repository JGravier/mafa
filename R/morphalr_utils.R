#' Create minimal bounding rectangles
#'
#' @description
#' Create minimal bounding oriented rectangles of polygons.
#'
#' @param sfpolygon A sf object composed of polygons.
#' @return A sf object composed of minimal oriented bounding rectangle.
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_utils_mbboxoriented <- function(sfpolygon){
  #### extract minimal bounding box
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
