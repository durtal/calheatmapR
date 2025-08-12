test_that("chLabel modifies calheatmapR object correctly", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chLabel(widget, position = "top", align = "center")
  
  expect_s3_class(modified_widget, "htmlwidget")
  expect_equal(modified_widget$x$attrs$label$position, "top")
  expect_equal(modified_widget$x$attrs$label$align, "center")
})

test_that("chLabel handles all position options", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  positions <- c("bottom", "left", "top", "right")
  for (pos in positions) {
    modified_widget <- chLabel(widget, position = pos)
    expect_equal(modified_widget$x$attrs$label$position, pos)
  }
})

test_that("chLabel handles all align options", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  alignments <- c("center", "right", "left")
  for (align in alignments) {
    modified_widget <- chLabel(widget, align = align)
    expect_equal(modified_widget$x$attrs$label$align, align)
  }
})

test_that("chLabel handles rotate parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  # Test with NULL (default)
  modified_widget <- chLabel(widget, rotate = NULL)
  expect_null(modified_widget$x$attrs$label$rotate)
  
  # Test with "left"
  modified_widget <- chLabel(widget, rotate = "left")
  expect_equal(modified_widget$x$attrs$label$rotate, "left")
  
  # Test with "right"
  modified_widget <- chLabel(widget, rotate = "right")
  expect_equal(modified_widget$x$attrs$label$rotate, "right")
})

test_that("chLabel handles width parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chLabel(widget, width = 150)
  
  expect_equal(modified_widget$x$attrs$label$width, 150)
})

test_that("chLabel handles offset parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  custom_offset <- list(x = 10, y = 20)
  modified_widget <- chLabel(widget, offset = custom_offset)
  
  expect_equal(modified_widget$x$attrs$label$offset, custom_offset)
})

test_that("chLabel handles height parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  # Test with NULL (default)
  modified_widget <- chLabel(widget, height = NULL)
  expect_null(modified_widget$x$attrs$label$height)
  
  # Test with custom height
  modified_widget <- chLabel(widget, height = 50)
  expect_equal(modified_widget$x$attrs$label$height, 50)
})

test_that("chLabel handles itemName parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  # Test with default
  modified_widget <- chLabel(widget, itemName = c("item", "items"))
  expect_equal(modified_widget$x$attrs$itemName, c("item", "items"))
  
  # Test with custom names
  custom_names <- c("event", "events")
  modified_widget <- chLabel(widget, itemName = custom_names)
  expect_equal(modified_widget$x$attrs$itemName, custom_names)
})

test_that("chLabel handles all parameters together", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chLabel(widget, 
                           position = "right",
                           align = "left",
                           rotate = "left",
                           width = 120,
                           offset = list(x = 5, y = 10),
                           height = 30,
                           itemName = c("value", "values"))
  
  expect_equal(modified_widget$x$attrs$label$position, "right")
  expect_equal(modified_widget$x$attrs$label$align, "left")
  expect_equal(modified_widget$x$attrs$label$rotate, "left")
  expect_equal(modified_widget$x$attrs$label$width, 120)
  expect_equal(modified_widget$x$attrs$label$offset, list(x = 5, y = 10))
  expect_equal(modified_widget$x$attrs$label$height, 30)
  expect_equal(modified_widget$x$attrs$itemName, c("value", "values"))
})