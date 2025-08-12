test_that("pletcher dataset is properly structured", {
  data(pletcher)
  
  expect_type(pletcher, "list")
  expect_gt(length(pletcher), 0)
  
  # Check that all names are numeric strings (timestamps)
  pletcher_names <- names(pletcher)
  expect_true(all(grepl("^[0-9]+$", pletcher_names)))
  
  # Check that all values are numeric
  pletcher_values <- unlist(pletcher, use.names = FALSE)
  expect_true(all(is.numeric(pletcher_values)))
})

test_that("pletcher dataset has valid timestamp format", {
  data(pletcher)
  
  # Get first few timestamps and convert to dates
  timestamps <- as.numeric(names(pletcher)[1:5])
  
  # Timestamps should be Unix timestamps (seconds since 1970-01-01)
  # They should be reasonable values (between 2010 and 2020 roughly)
  min_timestamp <- as.numeric(as.POSIXct("2010-01-01"))
  max_timestamp <- as.numeric(as.POSIXct("2020-01-01"))
  
  expect_true(all(timestamps >= min_timestamp))
  expect_true(all(timestamps <= max_timestamp))
})

test_that("pletcher dataset has valid value ranges", {
  data(pletcher)
  
  pletcher_values <- unlist(pletcher, use.names = FALSE)
  
  # Values should be percentages (0-100) based on the documentation
  expect_true(all(pletcher_values >= 0))
  expect_true(all(pletcher_values <= 100))
})

test_that("pletcher dataset can be used with calheatmapR", {
  data(pletcher)
  
  # Should work without errors
  widget <- calheatmapR(pletcher)
  
  expect_s3_class(widget, "htmlwidget")
  expect_identical(widget$x$data, pletcher)
})

test_that("pletcher dataset documentation matches actual data", {
  data(pletcher)
  
  # Based on the documentation, this should be about Todd Pletcher racehorse trainer
  # performance over a 3-month period
  expect_gt(length(pletcher), 50)  # Should have data for multiple days
  expect_lt(length(pletcher), 500) # But not too many for a 3-month period
  
  # All values should be reasonable percentages
  pletcher_values <- unlist(pletcher, use.names = FALSE)
  expect_true(any(pletcher_values > 50))  # Should have some good performance days
  expect_true(any(pletcher_values < 50))  # And some not-so-good days
})