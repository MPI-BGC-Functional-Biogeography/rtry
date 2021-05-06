context("Combine data by columns (rtry_bind_col)")


test_that("basic test", {
  df1 <- data.frame(
    id = 1:10,
    value = rnorm(10)
  )

  df2 <- data.frame(
    char = letters[1:10]
  )

  df <- rtry_bind_col(df1, df2)

  expect_equal(class(df), "data.frame")
  expect_equal(ncol(df), 3)
  expect_equal(nrow(df), 10)
  expect_equal(colnames(df), c("id", "value", "char"))
})


test_that("rtry_bind_col handles empty argument", {
  message = "Please specify at least two data frames to be combined by columns."

  expect_message(rtry_bind_col(), message)
})


test_that("rtry_bind_col handles NULL values", {
  expect_equal(rtry_bind_col(NULL), NULL)
})
