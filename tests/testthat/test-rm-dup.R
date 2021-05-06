context("Remove duplicates (rtry_rm_dup)")


test_that("basic test", {
  df <- data.frame(OrigObsDataID = c(0, 2, 0, 1, 4, 0, 1), value = 1:7)

  df_rm <- rtry_rm_dup(df)

  expect_equal(class(df_rm), "data.frame")
  expect_equal(ncol(df_rm), 2)
  expect_equal(nrow(df_rm), 3)
  expect_equal(colnames(df_rm), c("OrigObsDataID", "value"))
})


test_that("rtry_rm_dup handles data without the column 'OrigObsDataID'", {
  message = "Please make sure the column 'OrigObsDataID' exists in the input data."

  df <- data.frame(x = c(0, 2, 0, 1, 4, 0, 1), value = 1:7)

  expect_message(rtry_rm_dup(df), message)
})


test_that("rtry_rm_dup handles empty argument", {
  message = "Please specify the input data for removing duplicates."

  expect_message(rtry_rm_dup(), message)
})
