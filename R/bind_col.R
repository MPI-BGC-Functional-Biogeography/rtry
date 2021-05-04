#' Bind TRY data by columns
#'
#' This function takes a sequence of data imported by \code{rtry_import()} and combined them by columns.
#'
#' @param ... A sequence of data frame to be combined by columns
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data
#' @return A data table of the input data
#' @export
rtry_bind_col <- function(..., showOverview = TRUE){
  if(missing(...)){
    message("Please specify at least two data frames to be combined by columns.")
  }
  else{
    TRYdata <- cbind(...)

    if(!is.null(TRYdata) && showOverview == TRUE){
      message("dim:   ", paste0(dim(TRYdata), sep = " "))
      message("ls:    ", paste0(ls(TRYdata), sep = " "))
    }

    return(TRYdata)
  }
}
