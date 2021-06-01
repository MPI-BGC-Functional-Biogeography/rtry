context("Explore data (rtry_explore)")


test_that("basic test", {
  TRYdata_explore <- rtry_explore(TRYdata_14833, DataID, DataName)

  expect_equal(class(TRYdata_explore), c("tbl_df", "tbl", "data.frame"))
  expect_equal(ncol(TRYdata_explore), 3)
  expect_equal(colnames(TRYdata_explore), c("DataID", "DataName", "Count"))
})


test_that("rtry_explore handles one or more empty arguments", {
  message = "Please specify the input data and/or attribute names you would like to group together."

  expect_message(rtry_explore(), message)
  expect_message(rtry_explore(input = input), message())
})
