#' Remove TRY columns
#'
#' This function removes specified columns from the imported data for further processing.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Column names to be removed
#' @param showOverview Default \code{TRUE} displays the dimension of the selected columns
#' @return A data table of the remaining columns of the input data
#' @examples
#' \dontrun{
#' rtry_rm_col(TRYdata, Reference, Comment)
#' }
#' @seealso \code{\link{rtry_select_col}}
#' @references \href{https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/select}{dplyr::select()}
#' @export
rtry_rm_col <- function(input, ..., showOverview = TRUE){
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or column names you would like to remove.")
  }
  else{
    input <- dplyr::select(input, -c(...))
    remainingColumns <- input

    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(remainingColumns), sep = " "))
      message("ls:    ", paste0(ls(remainingColumns), sep = " "))
    }

    return(remainingColumns)
  }
}
