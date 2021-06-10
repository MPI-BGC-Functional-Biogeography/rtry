#' Bind TRY data by rows
#'
#' This function takes a sequence of data imported by \code{rtry_import()}
#' and combined them by rows. The data should share the same number of columns
#' and column names.
#'
#' @param ... A sequence of data frame to be combined by rows
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data
#' @return A data table of the input data
#' @examples
#' \dontrun{
#' rtry_bind_row(TRYdata1, TRYdata2)
#' }
#' @export
rtry_bind_row <- function(..., showOverview = TRUE){
  if(missing(...)){
    message("Please specify at least two data frames to be combined by rows")
  }
  else{
    TRYdata <- rbind(...)

    if(!is.null(TRYdata) && showOverview == TRUE){
      message("dim:   ", paste0(dim(TRYdata), sep = " "))
      message("ls:    ", paste0(ls(TRYdata), sep = " "))
    }

    return(TRYdata)
  }
}
