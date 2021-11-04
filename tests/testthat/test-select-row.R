context("Select data by rows (rtry_select_row)")


test_that("basic test", {
  df_sel_row1 <- rtry_select_row(TRYdata_15160, DataID %in% c(59, 60))

  expect_equal(class(df_sel_row1), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_row1), c(195, 28))


  df_sel_row2 <- df_sel_row <- rtry_select_row(TRYdata_15160, DataID %in% c(59))

  expect_equal(class(df_sel_row2), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_row2), c(98, 28))


  df_sel_row3 <- rtry_select_row(TRYdata_15160, DataID %in% c(59), getAncillary = TRUE)

  expect_equal(class(df_sel_row3), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_row3), c(1354, 28))


  df_sel_row4 <- rtry_select_row(TRYdata_15160, DataID %in% c(59), getAncillary = TRUE, rmDuplicates = TRUE)

  expect_equal(class(df_sel_row4), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_row4), c(1329, 28))
})


test_that("rtry_select_row handles empty or missing argument", {
  message = "Please specify the input data and/or criteria for row selection."

  expect_message(rtry_select_row(), message)
  expect_message(rtry_select_row(input = input), message)
})
