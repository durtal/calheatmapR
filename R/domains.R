#' Calendar Heatmap domain
#'
#' Configure options with respect to the domains that make up a Calendar Heatmap
#'
#' @param calheatmapR Calendar Heatmap to configure options for
#' @param domain Type of domain
#' @param subDomain Type of subDomain (must always be smaller than domain)
#' @param start Date, as a string, in YYYY-MM-DD format
#' @param range Number of domains to display
#' @param cellSize Size of each domain (in pixels)
#' @param cellPadding Space between each subDomain cell (in pixels)
#' @param cellRadius Border radius of subDomain cells, for rounder corners (in pixels)
#' @param gutter Space between each domain
#' @param margin Margins around each domain, either integer (0) or vector
#' c(0,0) or c(0,0,0,0), all of which produce the same. c(0,1) would create margins
#' of c(0,1,0,1) (in pixels)
#' @param colLimit Control the number of columns to split the domains into
#' @param rowLimit Control the number of rows to split the domains into
#' @param dynamicDimension Enable/disable dynamic width and height of domains
#' @param verticalOrientation Display Calendar Heatmap vertically
#'
#' @return a calheatmapR with customised domain options
#'
#' @export
chDomain <- function(calheatmapR,
                     domain = c("hour", "day", "week", "month", "year"),
                     subDomain = c("min", "x_min", "hour", "x_hour", "day",
                                    "x_day", "week", "x_week", "month", "x_month"),
                     start = NULL, range = 12, cellSize = 10, cellPadding = 2,
                     cellRadius = 0, gutter = 2, margin = c(0, 0, 0, 0),
                     colLimit = NULL, rowLimit = NULL, dynamicDimension = TRUE,
                     verticalOrientation = FALSE) {

    # build list of attributes
    domainAttrs <- list()
    domainAttrs$domain <- match.arg(domain)
    domainAttrs$subDomain <- match.arg(subDomain)
    if(is.null(start)) {
        start <- as.character(Sys.Date())
    }
    domainAttrs$start <- start
    domainAttrs$range <- range
    domainAttrs$cellSize <- cellSize
    domainAttrs$cellPadding <- cellPadding
    domainAttrs$cellRadius <- cellRadius
    domainAttrs$domainGutter <- gutter
    domainAttrs$domainMargin <- margin
    domainAttrs$colLimit <- colLimit
    domainAttrs$rowLimit <- rowLimit
    domainAttrs$domainDynamicDimension <- dynamicDimension
    domainAttrs$verticalOrientation <- verticalOrientation

    # merge domainAttrs with existing attrs in calheatmapR
    calheatmapR$x$attrs <- mergeLists(calheatmapR$x$attrs, domainAttrs)

    # return calheatmapR
    return(calheatmapR)
}
