context("Transform long table into wide table (rtry_trans_wider)")


test_that("basic test", {
  df <- data.frame(
    Country = c("DE", "US", "DE", "UK", "UK", "DE"),
    Year = c("2010", "2010", "2011", "2011", "2012", "2013"),
    Count = c(10, 11, 12, 12, 13, 14)
    )

  df_wider <- rtry_trans_wider(df, names_from = "Year", values_from = "Count")

  expect_equal(class(df_wider), c("tbl_df", "tbl", "data.frame"))
  expect_equal(ncol(df_wider), 5)
  expect_equal(nrow(df_wider), 3)
})


test_that("rtry_trans_wider handles empty argument", {
  message = "Please specify the input data for transforming from long table to wide table."

  expect_message(rtry_trans_wider(), message)
})
