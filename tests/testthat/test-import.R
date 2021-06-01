context("Import CSV file (rtry_import)")


test_that("basic test", {
  input_path <- system.file("testdata", "locations.csv", package = "rtry")
  input <- rtry_import(input_path, separator = ",", quote = "\"")

  expect_equal(class(input), c("data.table", "data.frame"))
})


test_that("rtry_import handles empty argument", {
  message = "Please specify the input file."

  expect_message(rtry_import(), message)
})
