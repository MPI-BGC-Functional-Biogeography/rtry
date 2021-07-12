context("Filter data (rtry_filter)")


test_that("basic test", {
  filter1 <- rtry_filter(TRYdata_15160, OrigValueStr %in% c("adult", "mature", "mature, healthy", "unknown"))

  expect_equal(class(filter1), c("data.table", "data.frame"))
  expect_equal(dim(filter1), c(863, 28))
})


test_that("rtry_filter handles empty or missing argument", {
  message = "Please specify the input data and/or criteria for filtering."

  expect_message(rtry_filter(), message)
  expect_message(rtry_filter(input = input), message)
})
