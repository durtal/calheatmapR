test_that("chLegend modifies calheatmapR object correctly", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chLegend(widget, legend = c(10, 20, 30, 40))
  
  expect_s3_class(modified_widget, "htmlwidget")
  expect_equal(modified_widget$x$attrs$legend, c(10, 20, 30, 40))
})

test_that("chLegend handles display parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  # Test display = TRUE
  modified_widget <- chLegend(widget, display = TRUE)
  expect_true(modified_widget$x$attrs$displayLegend)
  
  # Test display = FALSE
  modified_widget <- chLegend(widget, display = FALSE)
  expect_false(modified_widget$x$attrs$displayLegend)
})

test_that("chLegend handles cell size and padding", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chLegend(widget, cellSize = 15, cellPadding = 3)
  
  expect_equal(modified_widget$x$attrs$legendCellSize, 15)
  expect_equal(modified_widget$x$attrs$legendCellPadding, 3)
})

test_that("chLegend handles margin parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  custom_margin <- c(5, 10, 15, 20)
  modified_widget <- chLegend(widget, margin = custom_margin)
  
  expect_equal(modified_widget$x$attrs$legendMargin, custom_margin)
})

test_that("chLegend handles position parameters", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  # Test vertical positions
  vertical_positions <- c("bottom", "top", "center")
  for (pos in vertical_positions) {
    modified_widget <- chLegend(widget, verticalPosition = pos)
    expect_equal(modified_widget$x$attrs$legendVerticalPosition, pos)
  }
  
  # Test horizontal positions
  horizontal_positions <- c("left", "center", "right")
  for (pos in horizontal_positions) {
    modified_widget <- chLegend(widget, horizontalPosition = pos)
    expect_equal(modified_widget$x$attrs$legendHorizontalPosition, pos)
  }
})

test_that("chLegend handles orientation parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  orientations <- c("horizontal", "vertical")
  for (orient in orientations) {
    modified_widget <- chLegend(widget, orientation = orient)
    expect_equal(modified_widget$x$attrs$legendOrientation, orient)
  }
})

test_that("chLegend handles colours parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  # Test with array of colors
  colors_array <- c("#red", "#green", "#blue")
  modified_widget <- chLegend(widget, colours = colors_array)
  expect_equal(modified_widget$x$attrs$legendColors, colors_array)
  
  # Test with list of colors
  colors_list <- list(min = "#blue", max = "#red", empty = "#gray")
  modified_widget <- chLegend(widget, colours = colors_list)
  expect_equal(modified_widget$x$attrs$legendColors, colors_list)
})

test_that("chLegend handles NULL colours parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chLegend(widget, colours = NULL)
  expect_null(modified_widget$x$attrs$legendColors)
})

test_that("chLegend handles custom legend values", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  custom_legend <- c(5, 15, 25, 35, 45)
  modified_widget <- chLegend(widget, legend = custom_legend)
  
  expect_equal(modified_widget$x$attrs$legend, custom_legend)
})