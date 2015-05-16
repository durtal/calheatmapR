#' Calendar Heatmap legend
#'
#' Configure options with respect to the legend in a Calendar Heatmap
#'
#' @param calheatmapR Calendar Heatmap to configure options for
#' @param legend Numeric vector, assigns each range of values to a colour
#' @param display Whether to display the legend
#' @param cellSize Size of the legend cells (in pixels)
#' @param cellPadding Padding between each legend cell (in pixels)
#' @param margin Margins around each legend cell (in pixels)
#' @param verticalPosition Vertical position of the legend
#' @param horizontalPosition Horizontal position of the legend
#' @param orientation Orientation of the legend
#' @param colours Set of colours to compute the heatmap colours, either array or
#' list.  List object would contain a 'min' and 'max' elements, with optional
#' elements of 'empty', 'base' and 'overflow'
#'
#' @return a calheatmapR with customised label options
#'
#' @note see \href{https://kamisama.github.io/cal-heatmap/#legend}{here} for options
#'
#' @export
chLegend <- function(calheatmapR, legend = c(10, 20, 30, 40), display = TRUE,
                    cellSize = 10, cellPadding = 2, margin = c(10, 0, 0, 0),
                    verticalPosition = c("bottom", "top", "center"),
                    horizontalPosition = c("left", "center", "right"),
                    orientation = c("horizontal", "vertical"),
                    colours = NULL) {

    # build list of attributes
    legendAttrs <- list()
    legendAttrs$legend <- legend
    legendAttrs$displayLegend <- display
    legendAttrs$legendCellSize <- cellSize
    legendAttrs$legendCellPadding <- cellPadding
    legendAttrs$legendMargin <- margin
    legendAttrs$legendVerticalPosition <- match.arg(verticalPosition)
    legendAttrs$legendHorizontalPosition <- match.arg(horizontalPosition)
    legendAttrs$legendOrientation <- match.arg(orientation)
    legendAttrs$legendColors <- colours

    # add legendAttrs to existing attrs in calheatmapR
    calheatmapR$x$attrs <- mergeLists(calheatmapR$x$attrs, legendAttrs)

    # return calheatmapR
    return(calheatmapR)
}
