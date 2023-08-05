context("Perform reverse geocoding (rtry_revgeocoding)")


test_that("basic test", {
  # following CRAN’s “graceful failure” policy
  # in case OSM service not working
  skip_on_cran()

  input_coordinate <- head(data_coordinates, 1)
  input_lat_lon <- data.frame(lat = input_coordinate$Latitude, lon = input_coordinate$Longitude)

  output <- rtry_revgeocoding(input_lat_lon, "john.doe@example.com")
  output_address <- paste(ifelse(!is.na(output$town), output$town, output$city), output$country, sep = ", ")

  expect_equal(class(output), "data.frame")
  expect_equal(length(output), 5)
  expect_equal(colnames(output), c("full_address", "town", "city", "country", "country_code"))
})


test_that("rtry_revgeocoding handles empty argument", {
  message = "Please make sure you have entered a data frame with latitude and longitude."

  expect_message(rtry_revgeocoding(), message)
})


test_that("rtry_revgeocoding handles missing email address", {
  input_coordinate <- head(data_coordinates, 1)
  input_lat_lon <- data.frame(lat = input_coordinate$Latitude, lon = input_coordinate$Longitude)

  message = "Please make sure you have provided a valid email address."

  expect_message(rtry_revgeocoding(input_lat_lon), message)
})


test_that("rtry_revgeocoding handles invalid email address", {
  input_coordinate <- head(data_coordinates, 1)
  input_lat_lon <- data.frame(lat = input_coordinate$Latitude, lon = input_coordinate$Longitude)

  message = "Please provide a valid email address."

  expect_message(rtry_revgeocoding(input_lat_lon, "email"), message)
})
