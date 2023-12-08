#' Compute clustering of spatial entities
#'
#' @description
#' Compute clustering of spatial entities based on HCA on distance matrix of coordinates of PCA.
#'
#'
#' @param sf sf object.
#' @param pca_center logical or numeric value, centering option as in `dudi.pca()`. TRUE: centering by the mean, FALSE: no centering
#' @param pca_scale logical value indicating whether the column vectors should be scaled as in `dudi.pca()`.
#' @param hca_method character string defining the clustering method implemented in `fastcluster::hclust()`: `"single"`, `"single"`,
#' `"complete"`, `"ward.D"`, `"ward.D2"`, `"mcquitty"`, `"centroid"` or `"median"`.
#' @return clustering object of class `hclust`.
#'
#'
#' @seealso [dudi.pca()]
#' @seealso [fastcluster::hclust()]
#'
#' @importFrom Rdpack reprompt
#' @importFrom rlang .data
#' @export

morphalr_clustering <- function(sf, pca_center, pca_scale, hca_method){
  # compute PCA
  dfentities <- sf::st_drop_geometry(x = sf)
  ncoldf <- ncol(x = dfentities)
  pcasf <- ade4::dudi.pca(df = dfentities, center = pca_center, scale = pca_scale , scannf = FALSE, nf = ncoldf)
  # compute distance matrix
  dist_coord_pca <- ade4::dist.dudi(pcasf, amongrow = TRUE)
  #compute HCA
  clustering <- fastcluster::hclust(d = dist_coord_pca, method = hca_method)

  return(clustering)
}
