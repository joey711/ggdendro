\name{dendrogram_data}
\alias{dendrogram_data}
\title{Extract data frame from dendrogram object for plotting using ggplot.}
\usage{
  dendrogram_data(x, type = c("rectangle", "triangle"),
    ...)
}
\arguments{
  \item{x}{object of class "dendrogram", e.g. the output of
  as.dendrogram()}

  \item{type}{The type of plot, indicating the shape of the
  dendrogram.  "Rectangle" will draw rectangular lines,
  while "triangle" will draw triangular lines.}

  \item{...}{ignored}
}
\description{
  Extract data frame from dendrogram object for plotting
  using ggplot
}
\seealso{
  \code{\link{ggdendrogram}}

  Other dendro_data methods:
  \code{\link{dendro_data.dendrogram}},
  \code{\link{dendro_data.rpart}},
  \code{\link{dendro_data.tree}},
  \code{\link{rpart_labels}}

  Other dendrogram/hclust functions:
  \code{\link{dendro_data.dendrogram}}
}
\keyword{internal}

