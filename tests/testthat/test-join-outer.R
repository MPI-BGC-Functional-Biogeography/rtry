context("Merge two data frames - outer join (rtry_join_outer)")


test_that("basic test", {
  lon <- rtry_select_anc(data_TRY_15160, 60)
  lat <- rtry_select_anc(data_TRY_15160, 59)

  georef <- rtry_join_outer(lon, lat, baseOn = ObservationID)

  expect_equal(class(georef), c("data.table", "data.frame"))
  expect_equal(dim(georef), c(98, 3))
})


test_that("rtry_join_outer handles missing specified common column", {
  message = "Please make sure the column specified in `baseOn` exists in both data frames."

  lon <- rtry_select_anc(data_TRY_15160, 60)
  lat <- rtry_select_anc(data_TRY_15160, 59)

  lat <- rtry_remove_col(lat, ObservationID)

  expect_message(rtry_join_outer(lon, lat, baseOn = ObservationID), message)
})


test_that("rtry_join_outer handles empty or missing argument", {
  message = "Please specify the two data frames and/or the common attribute `baseOn` that you would like to use for merging."

  expect_message(rtry_join_outer(), message)
  expect_message(rtry_join_outer(x = x), message)
  expect_message(rtry_join_outer(x = x, y = y), message)
})
