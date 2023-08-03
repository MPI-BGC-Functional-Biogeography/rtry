#' Import data
#'
#' This function imports a data file as a \code{data.table} for further processing.
#' The default arguments are set to import tabulartor delimited data files in text
#' format (\code{.txt}) exported from the TRY database. It can also be used to
#' import other file formats, such as \code{.csv} files with comma separated values.
#'
#' @param input Path to the data file.
#' @param separator Default \code{"\t"} for the TRY data output. Data separator.
#' @param encoding Default \code{"Latin-1"}. File encoding.
#' @param quote Default \code{""} reads the fields as is.
#'              If the fields in the data file are by a double quote, use \code{"\""} instead.
#' @param showOverview Default \code{TRUE} displays the input path, the dimension and
#'                     the column names of the imported data.
#' @references This function makes use of the \code{\link[data.table]{fread}} function
#'             within the \code{data.table} package.
#' @return A \code{data.table}.
#' @examples
#' # Example 1: Import data exported from the TRY database
#' # Specify file path to the raw data provided within the rtry package
#' input_path <- system.file("testdata", "data_TRY_15160.txt", package = "rtry")
#'
#' # For own data and Windows users the path might rather look similar to this:
#' # input_path <- "C:/Users/User/Desktop/data_TRY_15160.txt"
#'
#' # Import data file using rtry_import
#' input <- rtry_import(input_path)
#'
#' # Explicit notation:
#' # input <- rtry_import(input_path, separator = "\t", encoding = "Latin-1",
#' #            quote = "", showOverview = TRUE)
#'
#' # Expected message:
#' # input: ~/R/R-4.0.5/library/rtry/testdata/data_TRY_15160.txt
#' # dim:   1782 28
#' # col:   LastName FirstName DatasetID Dataset SpeciesName AccSpeciesID AccSpeciesName
#' #        ObservationID ObsDataID TraitID TraitName DataID DataName OriglName
#' #        OrigValueStr OrigUnitStr ValueKindName OrigUncertaintyStr UncertaintyName
#' #        Replicates StdValue UnitName RelUncertaintyPercent OrigObsDataID ErrorRisk
#' #        Reference Comment V28
#'
#' # Example 2: Import CSV file
#' # Specify file path to the raw data provided within the rtry package
#' input_path <- system.file("testdata", "data_locations.csv", package = "rtry")
#'
#' # Import data file using rtry_import
#' input <- rtry_import(input_path, separator = ",", encoding = "UTF-8",
#'            quote = "\"", showOverview = TRUE)
#'
#' # Expected message:
#' # input: ~/R/R-4.0.5/library/rtry/testdata/data_locations.csv
#' # dim:   20 3
#' # col:   Country code Country Location
#' @export
rtry_import <- function(input, separator = "\t", encoding = "Latin-1", quote = "", showOverview = TRUE){
  # If the arguments input is missing, show the message
  if(missing(input)){
    message("Please specify the input file.")
  }
  else{
    # Read the input data and have it as data.table format
    TRYdata <- data.table::fread(input,
                                 header = TRUE,
                                 sep = separator,
                                 dec = ".",
                                 encoding = encoding,
                                 quote = quote,
                                 data.table = TRUE)

    # If the argument showOverview is set to be TRUE, print the input file path, dimension and column names of the input data
    if(showOverview == TRUE){
      message("input: ", input)
      message("dim:   ", paste0(dim(TRYdata), sep = " "))
      message("col:   ", paste0(colnames(TRYdata), sep = " "))
    }

    # Return the data table of the input data
    return(TRYdata)
  }
}
