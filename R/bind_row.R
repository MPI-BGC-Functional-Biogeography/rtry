#' Bind TRY data by rows
#'
#' This function takes a sequence of data imported by \code{rtry_import()}
#' and combines them by rows. The data should share the same number of columns
#' and column names.
#'
#' @param ... A sequence of data frame to be combined by rows
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data
#' @return A data table of the input data
#' @examples
#' \dontrun{
#' rtry_bind_row(data1, data2)
#' }
#' @export
rtry_bind_row <- function(..., showOverview = TRUE){
  # If ... is missing, show the message
  if(missing(...)){
    message("Please specify at least two data frames to be combined by rows")
  }
  else{
    # Perform row binding
    TRYdata <- rbind(...)

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
