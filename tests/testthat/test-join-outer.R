context("Merge two data frames - outer join (rtry_join_outer)")


test_that("basic test", {
  lon <- rtry_select_aux(TRYdata_15160, Longitude)
  lat <- rtry_select_aux(TRYdata_15160, Latitude)

  georef <- rtry_join_outer(lon, lat)

  expect_equal(class(georef), c("data.table", "data.frame"))
  expect_equal(dim(georef), c(98, 3))
})


test_that("rtry_join_outer handles missing specified common column", {
  message = "Please make sure the column specified in 'baseOn', by default: `ObservationID`, exists in both data frames."

  lon <- rtry_select_aux(TRYdata_15160, Longitude)
  lat <- rtry_select_aux(TRYdata_15160, Latitude)

  lat <- rtry_rm_col(lat, ObservationID)

  expect_message(rtry_join_outer(lon, lat), message)
})


test_that("rtry_join_outer handles empty or missing argument", {
  message = "Please specify the two data frames you would like to merge."

  expect_message(rtry_join_outer(), message)
  expect_message(rtry_join_outer(x = x), message)
})
