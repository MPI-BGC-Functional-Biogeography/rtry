context("Export data (rtry_export)")


test_that("rtry_export handles empty argument", {
  message = "Please make sure you have specified the data to be saved or the output path."

  expect_message(rtry_export(), message)
  expect_message(rtry_export(TRYdata), message)
})
