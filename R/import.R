#' Import TRY data
#'
#' This function, by default, imports the text file exported from the TRY database
#' as a data.table for further processing. It can also be used to import other data file,
#' such as .csv file with comma as separator.
#'
#' @param input Path to the text file downloaded from TRY
#' @param separator Data separator. Default \code{"\t"} for the TRY data output
#' @param encoding File encoding. Default \code{"Latin-1"}
#' @param quote Default \code{""} reads the fields as is. If the fields start with a double quote, use \code{"\""} instead
#' @param showOverview Default \code{TRUE} displays the input path, dimension and column names of the input data
#' @return A data table of the input data
#' @examples
#' \dontrun{
#' rtry_import("./data/7956.txt")
#' rtry_import("./data/coordinates.csv", separator = ",", encoding = "UTF-8", quote = "\"")
#' }
#' @export
rtry_import <- function(input = "", separator = "\t", encoding = "Latin-1", quote = "", showOverview = TRUE){
  if(missing(input)){
    message("Please specify the input file.")
  }
  else{
    TRYdata <- data.table::fread(input, header = TRUE, sep = separator, dec = ".", encoding = encoding, quote = quote, data.table = TRUE)

    if(showOverview == TRUE){
      message("input: ", input)
      message("dim:   ", paste0(dim(TRYdata), sep = " "))
      message("ls:    ", paste0(ls(TRYdata), sep = " "))
    }

    return(TRYdata)
  }
}
