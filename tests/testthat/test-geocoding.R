context("Perform geocoding (rtry_geocoding)")


test_that("basic test", {
  # following CRAN’s “graceful failure” policy
  # in case OSM service not working
  skip_on_cran()

  input_location <- head(data_locations, 1)
  input_address <- paste(input_location$Location, input_location$Country, sep = ", ")

  expect_equal(input_address, "Hajdúdorog, Hungary")

  output <- rtry_geocoding(input_address, "john.doe@example.com")

  expect_equal(class(output), "data.frame")
  expect_equal(length(output), 2)
  expect_equal(colnames(output), c("lat", "lon"))
})


test_that("rtry_geocoding handles empty argument", {
  message = "Please make sure you have entered an address."

  expect_message(rtry_geocoding(), message)
})


test_that("rtry_geocoding handles missing email address", {
  input_location <- head(data_locations, 1)
  input_address <- paste(input_location$Location, input_location$Country, sep = ", ")

  message = "Please make sure you have provided a valid email address."

  expect_message(rtry_geocoding(input_address), message)
})


test_that("rtry_geocoding handles invalid email address", {
  input_location <- head(data_locations, 1)
  input_address <- paste(input_location$Location, input_location$Country, sep = ", ")

  message = "Please provide a valid email address."

  expect_message(rtry_geocoding(input_address, "email"), message)
})
