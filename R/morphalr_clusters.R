#' Add clusters of spatial entities
#'
#' @description
#' Add clusters of spatial entities from a selected cutting threshold of a `hclust` object.
#'
#'
#' @param sf sf object.
#' @param clustering `hclust` object, e.g. the result of `morphalr_clustering()`.
#' @param cutting numeric value of cutting threshold.
#' @return sf object with clusters as a new column.
#'
#'
#' @seealso [morphalr::morphalr_clustering()]
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_clusters <- function(sf, clustering, cutting){
  cluster_cut <- stats::cutree(clustering, k = cutting)
  sf$cluster <- factor(cluster_cut, levels = 1:cutting, labels = paste("cluster", 1:cutting))

  return(sf)
}
