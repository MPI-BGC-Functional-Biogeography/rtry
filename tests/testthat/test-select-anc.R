context("Select TRY ancillary data in wide table format (rtry_select_anc)")


test_that("basic test", {
  df_sel_aux1 <- rtry_select_anc(data_TRY_15160, 59)

  expect_equal(class(df_sel_aux1), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_aux1), c(98, 2))

  df_sel_aux2 <- rtry_select_anc(data_TRY_15160, 60)

  expect_equal(class(df_sel_aux2), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_aux2), c(97, 2))

  df_sel_aux3 <- rtry_select_anc(data_TRY_15160, 61)

  expect_equal(class(df_sel_aux3), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_aux3), c(23, 2))
})


test_that("rtry_select_anc handles empty or missing argument", {
  message = "Please specify the input data and/or the id of ancillary data you would like to select."

  expect_message(rtry_select_anc(), message)
  expect_message(rtry_select_anc(input = input), message)
})
