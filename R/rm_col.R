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
  # If either of the arguments input or ... is missing, show the message
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or column names you would like to remove.")
  }
  else{
    # Remove the specified columns from the input data
    input <- dplyr::select(input, -c(...))

    # Copy the processed data into a new variable
    remainingColumns <- input

    # If the argument showOverview is set to be TRUE, print the dimension and column names of the processed data
    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(remainingColumns), sep = " "))
      message("col:   ", paste0(colnames(remainingColumns), sep = " "))
    }

    # Return the remaining columns of data
    return(remainingColumns)
  }
}
