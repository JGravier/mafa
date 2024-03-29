% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mafa_complexity.R
\name{mafa_complexity}
\alias{mafa_complexity}
\title{Morphological complexity}
\usage{
mafa_complexity(sfpolygons)
}
\arguments{
\item{sfpolygons}{A sf object composed of polygons.}
}
\value{
\code{sfpoygons} with index as a new column, named \code{complexity_index}.
}
\description{
Compute morphological complexity index of polygons.
}
\details{
\eqn{I_c = \frac{N_{pv}}{P_p}}, with \eqn{N_{pv}} the number of vertices of a polygon and \eqn{P_p} its perimeter.
}
\references{
Marie, Maxime, Abdelkrim Bensaid, et Daniel Delahaye. 2009. « Le rôle de la distance dans l’organisation des pratiques et des paysages agricoles : l’exemple du fonctionnement des exploitations laitières dans l’arc atlantique ». Cybergeo: European Journal of Geography. \url{https://doi.org/10.4000/cybergeo.22366}.
}
