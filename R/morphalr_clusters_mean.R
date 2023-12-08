#' Compute mean of center-scale values of columns by cluster
#'
#' @description
#' Compute mean of center-scale values of columns group by clusters.
#'
#'
#' @param sf sf object.
#' @param clustering hclust object, e.g. the result of `morphalr_clustering()`.
#' @param cutting numeric value of cutting threshold.
#' @return a tibble.
#'
#' @seealso [morphalr_clustering()]
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_clusters_mean <- function(sf, clustering, cutting){
  sfdf <- sf::st_drop_geometry(x = sf)
  cluster_cut <- stats::cutree(clustering, k = cutting)
  sfdf$cluster <- factor(cluster_cut, levels = 1:cutting, labels = paste("cluster", 1:cutting))
  sfdf <- sfdf |>
    dplyr::group_by(.data$cluster) |>
    dplyr::summarise(dplyr::across(dplyr::everything(), mean, .names = "{.col}"))

  return(sfdf)
}
