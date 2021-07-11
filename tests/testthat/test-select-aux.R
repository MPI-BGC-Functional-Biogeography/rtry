context("Select TRY auxiliary data in wide table format (rtry_select_aux)")


test_that("basic test", {
  df_sel_aux1 <- rtry_select_aux(TRYdata_14833, Latitude)

  expect_equal(class(df_sel_aux1), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_aux1), c(162, 2))

  df_sel_aux2 <- rtry_select_aux(TRYdata_14833, Longitude)

  expect_equal(class(df_sel_aux2), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_aux2), c(161, 2))

  df_sel_aux3 <- rtry_select_aux(TRYdata_14833, Altitude)

  expect_equal(class(df_sel_aux3), c("data.table", "data.frame"))
  expect_equal(dim(df_sel_aux3), c(83, 2))
})


test_that("rtry_select_aux handles empty or missing argument", {
  message = "Please specify the input data and/or the name of auxiliary data you would like to select."

  expect_message(rtry_select_aux(), message)
  expect_message(rtry_select_aux(input = input), message)
})
