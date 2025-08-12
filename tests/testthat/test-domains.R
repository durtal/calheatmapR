test_that("chDomain modifies calheatmapR object correctly", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chDomain(widget, domain = "month", subDomain = "day")
  
  expect_s3_class(modified_widget, "htmlwidget")
  expect_equal(modified_widget$x$attrs$domain, "month")
  expect_equal(modified_widget$x$attrs$subDomain, "day")
})

test_that("chDomain handles all domain types", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  valid_domains <- c("hour", "day", "week", "month", "year")
  
  for (domain in valid_domains) {
    modified_widget <- chDomain(widget, domain = domain)
    expect_equal(modified_widget$x$attrs$domain, domain)
  }
})

test_that("chDomain handles all subDomain types", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  valid_subdomains <- c("min", "x_min", "hour", "x_hour", "day", 
                       "x_day", "week", "x_week", "month", "x_month")
  
  for (subdomain in valid_subdomains) {
    modified_widget <- chDomain(widget, subDomain = subdomain)
    expect_equal(modified_widget$x$attrs$subDomain, subdomain)
  }
})

test_that("chDomain sets default start date when NULL", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chDomain(widget, start = NULL)
  
  expect_equal(modified_widget$x$attrs$start, as.character(Sys.Date()))
})

test_that("chDomain handles custom start date", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  custom_date <- "2023-01-01"
  modified_widget <- chDomain(widget, start = custom_date)
  
  expect_equal(modified_widget$x$attrs$start, custom_date)
})

test_that("chDomain handles numeric parameters", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chDomain(widget, 
                            range = 6, 
                            cellSize = 15, 
                            cellPadding = 3,
                            cellRadius = 5,
                            gutter = 4)
  
  expect_equal(modified_widget$x$attrs$range, 6)
  expect_equal(modified_widget$x$attrs$cellSize, 15)
  expect_equal(modified_widget$x$attrs$cellPadding, 3)
  expect_equal(modified_widget$x$attrs$cellRadius, 5)
  expect_equal(modified_widget$x$attrs$domainGutter, 4)
})

test_that("chDomain handles margin parameter", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  custom_margin <- c(10, 15, 20, 25)
  modified_widget <- chDomain(widget, margin = custom_margin)
  
  expect_equal(modified_widget$x$attrs$domainMargin, custom_margin)
})

test_that("chDomain handles boolean parameters", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chDomain(widget, 
                            dynamicDimension = FALSE,
                            verticalOrientation = TRUE)
  
  expect_false(modified_widget$x$attrs$domainDynamicDimension)
  expect_true(modified_widget$x$attrs$verticalOrientation)
})

test_that("chDomain handles limit parameters", {
  simple_data <- list("1354406400" = 70)
  widget <- calheatmapR(simple_data)
  
  modified_widget <- chDomain(widget, colLimit = 3, rowLimit = 2)
  
  expect_equal(modified_widget$x$attrs$colLimit, 3)
  expect_equal(modified_widget$x$attrs$rowLimit, 2)
})