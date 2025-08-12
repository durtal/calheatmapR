test_that("calheatmapROutput creates valid shiny output", {
  output <- calheatmapROutput("test_id")
  
  expect_s3_class(output, "shiny.tag.list")
  expect_true(grepl("test_id", as.character(output)))
})

test_that("calheatmapROutput handles custom width and height", {
  output <- calheatmapROutput("test_id", width = "500px", height = "300px")
  
  expect_s3_class(output, "shiny.tag.list")
  expect_true(grepl("width:\\s*500px", as.character(output)))
  expect_true(grepl("height:\\s*300px", as.character(output)))
})

test_that("calheatmapROutput has correct default dimensions", {
  output <- calheatmapROutput("test_id")
  
  expect_true(grepl("width:\\s*100%", as.character(output)))
  expect_true(grepl("height:\\s*400px", as.character(output)))
})

test_that("renderCalheatmapR returns a render function", {
  # Create a simple expression for testing
  expr <- quote({
    simple_data <- list("1354406400" = 70)
    calheatmapR(simple_data)
  })
  
  render_func <- renderCalheatmapR(expr)
  
  expect_type(render_func, "closure")
  expect_s3_class(render_func, "shiny.render.function")
})