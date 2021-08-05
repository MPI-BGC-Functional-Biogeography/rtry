context("Remove data columns (rtry_remove_col)")


test_that("basic test", {
  df <- rtry_remove_col(TRYdata_15160,
          LastName, FirstName, DatasetID, Dataset, SpeciesName,
          OrigUncertaintyStr, UncertaintyName, Replicates,
          RelUncertaintyPercent, Reference, V28)

  expect_equal(class(df), c("data.table", "data.frame"))
  expect_equal(ncol(df), 17)
  expect_equal(nrow(df), 1782)
  expect_equal(colnames(df), c("AccSpeciesID", "AccSpeciesName", "ObservationID", "ObsDataID",
                               "TraitID", "TraitName", "DataID", "DataName", "OriglName",
                               "OrigValueStr", "OrigUnitStr", "ValueKindName", "StdValue",
                               "UnitName", "OrigObsDataID", "ErrorRisk", "Comment"))
})


test_that("rtry_remove_col handles empty or missing argument", {
  message = "Please specify the input data and/or column names you would like to remove."

  expect_message(rtry_remove_col(), message)
  expect_message(rtry_remove_col(input = input), message)
  expect_message(rtry_remove_col(... = col_names), message)
})
