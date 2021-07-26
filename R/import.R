#' Import data
#'
#' This function, by default, imports the data file (.txt) exported from the TRY database
#' as a data.table for further processing. It can also be used to import other file formats,
#' such as .csv files with comma as separator.
#'
#' @param input Path to the data file
#' @param separator Data separator. Default \code{"\t"} for the TRY data output
#' @param encoding File encoding. Default \code{"Latin-1"}
#' @param quote Default \code{""} reads the fields as is. If the fields in the data file are by a double quote, use \code{"\""} instead
#' @param showOverview Default \code{TRUE} displays the input path, the dimension and the column names of the imported data
#' @return A data table of the input data
#' @examples
#' \dontrun{
#' rtry_import("./data/7956.txt")
#' rtry_import("./data/coordinates.csv", separator = ",", encoding = "UTF-8", quote = "\"")
#' }
#' @export
rtry_import <- function(input = "", separator = "\t", encoding = "Latin-1", quote = "", showOverview = TRUE){
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
