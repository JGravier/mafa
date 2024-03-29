% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mafa_clustering.R
\name{mafa_clustering}
\alias{mafa_clustering}
\title{Clustering of spatial entities}
\usage{
mafa_clustering(sf, pca_center, pca_scale, hca_method)
}
\arguments{
\item{sf}{sf object.}

\item{pca_center}{logical or numeric value indicating whether columns should be centered as in as in \code{dudi.pca()}.}

\item{pca_scale}{logical value indicating whether columns should be scaled as in \code{dudi.pca()}.}

\item{hca_method}{character string defining the clustering method as implemented in \code{hclust()} of \code{fastcluster} package: \code{"single"}, \code{"average"},
\code{"complete"}, \code{"ward.D"}, \code{"ward.D2"}, \code{"mcquitty"}, \code{"centroid"} or \code{"median"}.}
}
\value{
clustering object of class \code{hclust}.
}
\description{
Compute clustering of spatial entities based on HCA on distance matrix of the coordinates of PCA.
}
\seealso{
\code{\link[ade4:dudi.pca]{ade4::dudi.pca()}}

\code{\link[fastcluster:hclust]{fastcluster::hclust()}}
}
