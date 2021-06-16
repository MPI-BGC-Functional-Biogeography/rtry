#' Select TRY columns
#'
#' This function selects specified columns from the imported data for further processing.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Column names to be selected
#' @param showOverview Default \code{TRUE} displays the dimension of the selected columns
#' @return A data table of the selected columns of the input data
#' @examples
#' \dontrun{
#' rtry_select_col(TRYdata, DataID, DataName)
#' }
#' @seealso \code{\link{rtry_rm_col}}
#' @references \href{https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/select}{dplyr::select()}
#' @export
rtry_select_col <- function(input = "", ..., showOverview = TRUE){
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or column names you would like to select.")
  }
  else{
    input <- dplyr::select(input, ...)
    selectedColumns <- input

    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(selectedColumns), sep = " "))
      message("ls:    ", paste0(ls(selectedColumns), sep = " "))
    }

    return(selectedColumns)
  }
}
