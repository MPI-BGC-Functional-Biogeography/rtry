context("Select data columns (rtry_select_col)")


test_that("basic test", {
  df <- data.frame(
    id = 1:10,
    value = rnorm(10),
    char1 = letters[1:10],
    char2 = letters[11:20]
  )

  df_sel_col1 <- rtry_select_col(df, id, value, char2)

  expect_equal(class(df_sel_col1), "data.frame")
  expect_equal(ncol(df_sel_col1), 3)
  expect_equal(nrow(df_sel_col1), 10)
  expect_equal(colnames(df_sel_col1), c("id", "value", "char2"))

  df_sel_col2 <- rtry_select_col(df, id, value)

  expect_equal(class(df_sel_col2), "data.frame")
  expect_equal(ncol(df_sel_col2), 2)
  expect_equal(nrow(df_sel_col2), 10)
  expect_equal(colnames(df_sel_col2), c("id", "value"))
})


test_that("rtry_select_col handles empty or missing argument", {
  message = "Please specify the input data and/or column names you would like to select."

  expect_message(rtry_select_col(), message)
  expect_message(rtry_select_col(input = input), message)
  expect_message(rtry_select_col(... = col_names), message)
})
