#' Add clusters of spatial entities
#'
#' @description
#' Add clusters of spatial entities from selected cutting threshold of the `morphalr_clustering()` result.
#'
#'
#' @param sf sf object.
#' @param clustering hclust object, e.g. the result of `morphalr_clustering()`.
#' @param cutting numeric value of cutting threshold.
#' @return sf object with clusters as a new variable.
#'
#'
#' @seealso [morphalr_clustering()]
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_clusters <- function(sf, clustering, cutting){
  cluster_cut <- stats::cutree(clustering, k = cutting)
  sf$cluster <- factor(cluster_cut, levels = 1:cutting, labels = paste("cluster", 1:cutting))

  return(sf)
}
