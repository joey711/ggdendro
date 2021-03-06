# Add comment
# 
# Author: Andrie
#----------------------------------------------------------------------------------


#' Creates dendrogram plot using ggplot.
#' 
#' Creates dendrogram plot using ggplot.
#' 
#' @param data Either a dendro object or an object that can be coerced to class dendro using the \code{\link{dendro_data}} function, i.e. objects of class dendrogram, hclust or tree
#' @param segments If TRUE, show line segments
#' @param labels if TRUE, shows segment labels
#' @param leaf_labels if TRUE, shows leaf labels
#' @param rotate if TRUE, rotates plot by 90 degrees
#' @param theme_dendro if TRUE, applies a blank theme to plot (see \code{\link{theme_dendro}}) 
#' @param ... other parameters passed to \code{\link[ggplot2]{geom_text}}
#' @export
#' @return A \code{\link[ggplot2]{ggplot}} object
#' @seealso \code{\link{dendro_data}}
#' @examples
#' library(ggplot2)
#' hc <- hclust(dist(USArrests), "ave")
#' ### demonstrate plotting directly from object class hclust
#' ggdendrogram(hc, rotate=FALSE)
#' ggdendrogram(hc, rotate=TRUE)
#' ### demonstrate converting hclust to dendro using dendro_data first
#' hcdata <- dendro_data(hc)
#' ggdendrogram(hcdata, rotate=TRUE, size=2) + opts(title="Dendrogram in ggplot2")
ggdendrogram <- function(data, segments=TRUE, labels=TRUE, leaf_labels=TRUE, 
    rotate=FALSE, theme_dendro=TRUE, ...){
  stopifnot(require(ggplot2))
  dataClass <- if(inherits(data, "dendro")) data$class else class(data)
  angle <- if(dataClass %in% c("dendrogram", "hclust")){
        ifelse(rotate, 0, 90)
      } else {
        ifelse(rotate, 90, 0)
      }
  hjust <- if(dataClass %in% c("dendrogram", "hclust")){
        ifelse(rotate, 0, 1)
      } else {
        0.5
      }
  if(!is.dendro(data)) data <- dendro_data(data)
  p <- ggplot()
  if(all(segments, !is.null(data$segments))){
    p <- p + geom_segment(data=segment(data), 
        aes_string(x="x", y="y", xend="xend", yend="yend"))
  }
  if(all(labels, !is.null(data$labels))){
    p <- p + geom_text(data=label(data), 
        aes_string(x="x", y="y", label="label"), hjust=hjust, angle=angle, ...)
  }
  if(all(leaf_labels, !is.null(data$leaf_labels))){
    p <- p + geom_text(data=leaf_label(data), 
        aes_string(x="x", y="y", label="label"), hjust=hjust, angle=angle, ...)
  }
  if(rotate){
    p <- p + coord_flip()
    p <- p + scale_y_reverse(expand=c(0.2, 0))
  } else {
    p <- p + scale_y_continuous(expand=c(0.2, 0))
  }
  if(theme_dendro) p <- p + theme_dendro()
  p
}


#' Creates completely blank theme in ggplot.
#' 
#' Sets most of the \code{ggplot} options to blank, by returning blank \code{opts} for the panel grid, panel background, axis title, axis text, axis line and axis ticks.
#' @export
theme_dendro <- function(){
  stopifnot(require(ggplot2))
  theme_blank <- ggplot2::theme_blank
  ggplot2::opts(
      panel.grid.major = theme_blank(),
      panel.grid.minor = theme_blank(),
      panel.background = theme_blank(),
      axis.title.x = theme_text(colour=NA),
      axis.title.y = theme_blank(),
      axis.text.x = theme_blank(),
      axis.text.y = theme_blank(),
      axis.line = theme_blank(),
      axis.ticks = theme_blank()
  )
}


