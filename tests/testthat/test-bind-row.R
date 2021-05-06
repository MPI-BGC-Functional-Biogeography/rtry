context("Combine data by rows (rtry_bind_row)")


test_that("basic test", {
  df1 <- data.frame(
    id = 1:10,
    value = rnorm(10)
  )

  df2 <- data.frame(
    id = 11:20,
    value = rnorm(10)
  )

  df <- rtry_bind_row(df1, df2)

  expect_equal(class(df), "data.frame")
  expect_equal(ncol(df), 2)
  expect_equal(nrow(df), 20)
  expect_equal(colnames(df), c("id", "value"))
})


test_that("rtry_bind_row handles empty argument", {
  message = "Please specify at least two data frames to be combined by rows."

  expect_message(rtry_bind_row(), message)
})


test_that("rtry_bind_row handles NULL values", {
  expect_equal(rtry_bind_row(NULL), NULL)
})
