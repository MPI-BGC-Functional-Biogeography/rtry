context("Remove data columns (rtry_rm_col)")


test_that("basic test", {
  df <- data.frame(
    id = 1:10,
    value = rnorm(10),
    char1 = letters[1:10],
    char2 = letters[11:20]
  )

  df_rm1 <- rtry_rm_col(df, char1)

  expect_equal(class(df_rm1), "data.frame")
  expect_equal(ncol(df_rm1), 3)
  expect_equal(nrow(df_rm1), 10)
  expect_equal(colnames(df_rm1), c("id", "value", "char2"))

  df_rm2 <- rtry_rm_col(df, char1, char2)

  expect_equal(class(df_rm2), "data.frame")
  expect_equal(ncol(df_rm2), 2)
  expect_equal(nrow(df_rm2), 10)
  expect_equal(colnames(df_rm2), c("id", "value"))
})


test_that("rtry_rm_col handles empty or missing argument", {
  message = "Please specify the input data and/or column names you would like to remove."

  expect_message(rtry_rm_col(), message)
  expect_message(rtry_rm_col(input = input), message)
  expect_message(rtry_rm_col(... = col_names), message)
})
