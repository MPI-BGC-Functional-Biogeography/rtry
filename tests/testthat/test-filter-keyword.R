context("Filter data by keywords (rtry_filter_keyword)")


test_that("basic test", {
  filter1 <- rtry_filter_keyword(TRYdata_14833, OrigValueStr, c("adult", "mature", "unknown"),
                                 caseSensitive = FALSE, exactMatch = FALSE)

  expect_equal(class(filter1), c("data.table", "data.frame"))
  expect_equal(dim(filter1), c(5157, 28))
})


test_that("rtry_filter handles empty or missing argument", {
  message = "Please specify the input data and/or attribute and/or keywords for filtering."

  expect_message(rtry_filter_keyword(), message)
  expect_message(rtry_filter_keyword(input = input), message)
})
