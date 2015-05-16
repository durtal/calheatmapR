#' Calendar Heatmap label
#'
#' Configure options with respect to the labels in a Calendar Heatmap
#'
#' @param calheatmapR Calendar Heatmap to configure options for
#' @param position Position of the label, with respect to the domain
#' @param align Alignment of the label, with respect to the domain
#' @param rotate Rotation for a vertical label, default is NULL, but accepts "left"
#' or "right"
#' @param width Applied when label is rotated, defines width of label
#' @param offset Additional control for label positioning
#' @param height Height of the domain label (in pixels)
#' @param itemName Name of entity on calender being presented
#'
#' @return a calheatmapR with customised label options
#'
#' @export
chLabel <- function(calheatmapR, position = c("bottom", "left", "top", "right"),
                    align = c("center", "right", "left"), rotate = NULL,
                    width = 100, offset = list(x = 0, y = 0), height = NULL,
                    itemName = c("item", "items")) {

    # build list of attributes
    labelAttrs <- list()
    labelAttrs$position <- match.arg(position)
    labelAttrs$align <- match.arg(align)
    if(!is.null(rotate)) {
        labelAttrs$rotate <- match.arg(rotate, choices = c("right", "left"))
    }
    labelAttrs$width <- width
    labelAttrs$offset <- offset
    labelAttrs$height <- height

    # add labelAttrs to existing attrs in calheatmapR
    calheatmapR$x$attrs$label <- labelAttrs
    calheatmapR$x$attrs$itemName <- itemName

    # return calheatmapR
    return(calheatmapR)
}
