context("Exclude (remove) data (rtry_exclude)")


test_that("basic test", {
  exclude1 <- rtry_exclude(data_TRY_15160,
                         OrigValueStr %in% c("adult", "mature", "mature, healthy", "unknown"),
                         baseOn = ObservationID)

  expect_equal(class(exclude1), c("data.table", "data.frame"))
  expect_equal(dim(exclude1), c(863, 28))
})


test_that("rtry_exclude handles empty or missing argument", {
  message = "Please specify the input data and/or criteria and/or baseOn for excluding."

  expect_message(rtry_exclude(), message)
  expect_message(rtry_exclude(input = input), message)
  expect_message(rtry_exclude(input = input, criteria), message)
})
