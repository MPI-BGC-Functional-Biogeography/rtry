#' Bind TRY data by columns
#'
#' This function takes a sequence of data imported by \code{rtry_import()}
#' and combines them by columns. The data should share the same number of rows.
#'
#' @param ... A sequence of data frame to be combined by columns
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data
#' @return A data table of the input data
#' @examples
#' \dontrun{
#' rtry_bind_col(TRYdata1, TRYdata2)
#' }
#' @export
rtry_bind_col <- function(..., showOverview = TRUE){
  # If ... is missing, show the message
  if(missing(...)){
    message("Please specify at least two data frames to be combined by columns.")
  }
  else{
    # Perform column binding
    TRYdata <- cbind(...)

    # If the combined data is not NULL and if the argument showOverview is set to be TRUE
    # Print the dimension and column names of the combined data
    if(!is.null(TRYdata) && showOverview == TRUE){
      message("dim:   ", paste0(dim(TRYdata), sep = " "))
      message("col:   ", paste0(colnames(TRYdata), sep = " "))
    }

    # Return the combined data
    return(TRYdata)
  }
}
