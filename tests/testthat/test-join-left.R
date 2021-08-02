context("Merge two data frames - left join (rtry_join_left)")


test_that("basic test", {
  lon <- rtry_select_aux(TRYdata_15160, Longitude)
  lat <- rtry_select_aux(TRYdata_15160, Latitude)

  georef <- rtry_join_left(lon, lat)

  expect_equal(class(georef), c("data.table", "data.frame"))
  expect_equal(dim(georef), c(97, 3))
})


test_that("rtry_join_left handles missing specified common column", {
  message = "Please make sure the column specified in 'baseOn', by default: `ObservationID`, exists in both data frames."

  lon <- rtry_select_aux(TRYdata_15160, Longitude)
  lat <- rtry_select_aux(TRYdata_15160, Latitude)

  lat <- rtry_rm_col(lat, ObservationID)

  expect_message(rtry_join_left(lon, lat), message)
})


test_that("rtry_join_left handles empty or missing argument", {
  message = "Please specify the two data frames you would like to merge."

  expect_message(rtry_join_left(), message)
  expect_message(rtry_join_left(x = x), message)
})
