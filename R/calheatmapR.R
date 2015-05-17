#' calheatmapR for plotting a calendar heatmap
#'
#' R interface to interactive plotting using the
#' \href{https://github.com/kamisama/cal-heatmap}{cal-heatmap} Javascript library
#'
#' @param data a list object, each element's name is a timestamp in seconds, with
#' a corresponding number, see \href{http://kamisama.github.io/cal-heatmap/#data-format}{here}
#' for details.
#' @param width width of element
#' @param height height of element
#'
#' @import htmlwidgets
#'
#' @source D3.js was created by Mike Bostock, see \url{http://d3js.org}, and
#' cal-heatmap.js was created by Wan Qi Chen, see \url{https://github.com/kamisama/cal-heatmap}
#'
#' @export
calheatmapR <- function(data, width = NULL, height = NULL) {

  # forward options using x
  x = list(
    data = data
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'calheatmapR',
    x,
    width = width,
    height = height,
    package = 'calheatmapR'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
calheatmapROutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'calheatmapR', width, height, package = 'calheatmapR')
}

#' Widget render function for use in Shiny
#'
#' @export
renderCalheatmapR <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, calheatmapROutput, env, quoted = TRUE)
}

#' Todd Pletcher racehorse trainer performance
#'
#' List containing data about racehorse trainer Todd Pletcher, tracking the
#' percentage of horses his horses beat in races they entered, over a 3month
#' period
#'
#' @docType data
#' @keywords dataset
#' @name pletcher
NULL
