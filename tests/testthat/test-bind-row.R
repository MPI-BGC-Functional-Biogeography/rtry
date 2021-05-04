context("Combine data by rows (rtry_bind_row)")


test_that("rtry_bind_row handles empty argument", {
  message = "Please specify at least two data frames to be combined by rows."

  expect_message(rtry_bind_row(), message)
})


test_that("rtry_bind_row handles NULL values", {
  expect_equal(rtry_bind_row(NULL), NULL)
})
