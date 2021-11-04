context("Combine data by rows (rtry_bind_row)")


test_that("basic test", {
  df <- rtry_bind_row(data_TRY_15160, data_TRY_15161)

  expect_equal(class(df), c("data.table", "data.frame"))
  expect_equal(ncol(df), 28)
  expect_equal(nrow(df), 6409)
  expect_equal(colnames(df), c("LastName", "FirstName", "DatasetID", "Dataset",
                               "SpeciesName", "AccSpeciesID", "AccSpeciesName", "ObservationID",
                               "ObsDataID", "TraitID", "TraitName", "DataID", "DataName",
                               "OriglName", "OrigValueStr", "OrigUnitStr", "ValueKindName",
                               "OrigUncertaintyStr", "UncertaintyName", "Replicates", "StdValue",
                               "UnitName", "RelUncertaintyPercent", "OrigObsDataID", "ErrorRisk",
                               "Reference", "Comment", "V28"))
})


test_that("rtry_bind_row handles empty argument", {
  message = "Please specify at least two data frames to be combined by rows."

  expect_message(rtry_bind_row(), message)
})


test_that("rtry_bind_row handles NULL values", {
  expect_equal(dim(rtry_bind_row(NULL)), c(0, 0))
})
