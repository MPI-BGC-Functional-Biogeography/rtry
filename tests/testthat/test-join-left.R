context("Merge two data frames - left join (rtry_join_left)")


test_that("basic test", {
  df1 <- data.frame(ObservationID = c(1:6), x = c("DE","US","UK","CN","NL","RU"))
  df2 <- data.frame(ObservationID = c(2, 4, 6, 7, 8), y = c("1.0","5.5","2.3","1.2","0.4"))

  df <- rtry_join_left(df1, df2)

  expect_equal(class(df), c("data.frame"))
  expect_equal(dim(df), c(6, 3))
})


test_that("rtry_join_left handles missing specified common column", {
  message = "Please make sure the column specified in 'baseOn', by default: `ObservationID`, exists in both data frames."

  df1 <- data.frame(ObservationID = c(1:6), x = c("DE","US","UK","CN","NL","RU"))
  df2 <- data.frame(ID = c(2, 4, 6, 7, 8), y = c("1.0","5.5","2.3","1.2","0.4"))

  expect_message(rtry_join_left(df1, df2), message)
})


test_that("rtry_join_left handles empty or missing argument", {
  message = "Please specify the two data frames you would like to merge."

  expect_message(rtry_join_left(), message)
  expect_message(rtry_join_left(x = x), message)
})
