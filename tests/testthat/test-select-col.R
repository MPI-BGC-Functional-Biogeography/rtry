context("Select data by columns (rtry_select_col)")


test_that("basic test", {
  df_sel_col <- rtry_select_col(TRYdata_15160,
                        ObsDataID, ObservationID, AccSpeciesID, AccSpeciesName,
                        ValueKindName, TraitID, TraitName, DataID, DataName,
                        OriglName, OrigValueStr, OrigUnitStr, StdValue, UnitName,
                        OrigObsDataID, ErrorRisk, Comment)

  expect_equal(class(df_sel_col), c("data.table", "data.frame"))
  expect_equal(ncol(df_sel_col), 17)
  expect_equal(nrow(df_sel_col), 1782)
  expect_equal(colnames(df_sel_col), c("ObsDataID", "ObservationID", "AccSpeciesID", "AccSpeciesName",
                                       "ValueKindName", "TraitID", "TraitName", "DataID", "DataName",
                                       "OriglName", "OrigValueStr", "OrigUnitStr", "StdValue", "UnitName",
                                       "OrigObsDataID", "ErrorRisk", "Comment"))
})


test_that("rtry_select_col handles empty or missing argument", {
  message = "Please specify the input data and/or column names you would like to select."

  expect_message(rtry_select_col(), message)
  expect_message(rtry_select_col(input = input), message)
  expect_message(rtry_select_col(... = col_names), message)
})
