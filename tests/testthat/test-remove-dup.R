context("Remove duplicates (rtry_remove_dup)")


test_that("basic test", {
  df_rm <- rtry_remove_dup(TRYdata_15160)

  expect_equal(class(df_rm), c("data.table", "data.frame"))
  expect_equal(ncol(df_rm), 28)
  expect_equal(nrow(df_rm), 1737)
  expect_equal(colnames(df_rm), c("LastName", "FirstName", "DatasetID", "Dataset", "SpeciesName",
                                  "AccSpeciesID", "AccSpeciesName", "ObservationID", "ObsDataID",
                                  "TraitID", "TraitName", "DataID", "DataName", "OriglName",
                                  "OrigValueStr", "OrigUnitStr", "ValueKindName", "OrigUncertaintyStr",
                                  "UncertaintyName", "Replicates", "StdValue", "UnitName",
                                  "RelUncertaintyPercent", "OrigObsDataID", "ErrorRisk", "Reference",
                                  "Comment", "V28"))
})


test_that("rtry_remove_dup handles data without the column 'OrigObsDataID'", {
  message = "Please make sure the column 'OrigObsDataID' exists in the input data."

  df <- data.frame(x = c(0, 2, 0, 1, 4, 0, 1), value = 1:7)

  expect_message(rtry_remove_dup(df), message)
})


test_that("rtry_remove_dup handles empty argument", {
  message = "Please specify the input data for removing duplicates."

  expect_message(rtry_remove_dup(), message)
})
