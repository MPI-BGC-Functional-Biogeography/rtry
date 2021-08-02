context("Combine data by columns (rtry_bind_col)")


test_that("basic test", {
  df1 <- rtry_select_col(TRYdata_15160,
                           ObsDataID, ObservationID, AccSpeciesID, AccSpeciesName,
                           ValueKindName, TraitID, TraitName, DataID, DataName,
                           OrigObsDataID, ErrorRisk, Comment)

  df2 <- rtry_select_col(TRYdata_15160,
                           OriglName, OrigValueStr, OrigUnitStr, StdValue, UnitName)

  df <- rtry_bind_col(df1, df2)

  expect_equal(class(df), c("data.table", "data.frame"))
  expect_equal(ncol(df), 17)
  expect_equal(nrow(df), 1782)
  expect_equal(colnames(df), c("ObsDataID", "ObservationID", "AccSpeciesID", "AccSpeciesName",
                               "ValueKindName", "TraitID", "TraitName", "DataID", "DataName",
                               "OrigObsDataID", "ErrorRisk", "Comment",
                               "OriglName", "OrigValueStr", "OrigUnitStr", "StdValue", "UnitName"))
})


test_that("rtry_bind_col handles empty argument", {
  message = "Please specify at least two data frames to be combined by columns."

  expect_message(rtry_bind_col(), message)
})


test_that("rtry_bind_col handles NULL values", {
  expect_equal(dim(rtry_bind_col(NULL)), c(0, 0))
})
