test_that("calheatmapR creates valid htmlwidget object", {
  # Test with simple numeric data
  simple_data <- list("1354406400" = 70, "1354752000" = 100)
  
  widget <- calheatmapR(simple_data)
  
  expect_s3_class(widget, "htmlwidget")
  expect_s3_class(widget, "calheatmapR")
  expect_equal(attr(widget, "package"), "calheatmapR")
  expect_identical(widget$x$data, simple_data)
})

test_that("calheatmapR handles NULL data", {
  widget <- calheatmapR(NULL)
  
  expect_s3_class(widget, "htmlwidget")
  expect_null(widget$x$data)
})

test_that("calheatmapR handles empty list", {
  widget <- calheatmapR(list())
  
  expect_s3_class(widget, "htmlwidget")
  expect_equal(widget$x$data, list())
})

test_that("calheatmapR handles width and height parameters", {
  simple_data <- list("1354406400" = 70)
  
  widget <- calheatmapR(simple_data, width = 800, height = 600)
  
  expect_equal(widget$width, 800)
  expect_equal(widget$height, 600)
})

test_that("calheatmapR handles default width and height", {
  simple_data <- list("1354406400" = 70)
  
  widget <- calheatmapR(simple_data)
  
  expect_null(widget$width)
  expect_null(widget$height)
})

test_that("calheatmapR works with pletcher dataset", {
  data(pletcher)
  
  widget <- calheatmapR(pletcher)
  
  expect_s3_class(widget, "htmlwidget")
  expect_identical(widget$x$data, pletcher)
  expect_gt(length(widget$x$data), 0)
})