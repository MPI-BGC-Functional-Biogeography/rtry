context("Import CSV file (rtry_import)")


test_that("basic test", {
  input_path_1 <- system.file("testdata", "data_TRY_15160.txt", package = "rtry")
  input_1 <- rtry_import(input_path_1)

  expect_equal(class(input_1), c("data.table", "data.frame"))


  input_path_2 <- system.file("testdata", "locations.csv", package = "rtry")
  input_2 <- rtry_import(input_path_2, separator = ",", quote = "\"")

  expect_equal(class(input_2), c("data.table", "data.frame"))
})


test_that("rtry_import handles empty argument", {
  message = "Please specify the input file."

  expect_message(rtry_import(), message)
})
