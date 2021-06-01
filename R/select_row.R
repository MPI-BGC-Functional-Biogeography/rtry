#' Select TRY rows
#'
#' This function selects specified rows based on the specified criteria  and the corresponding \code{ObservationID}
#' from the imported data for further processing.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Criteria for row selection
#' @param getAuxiliary Default \code{FALSE}, set to \code{TRUE} selects all auxiliary data based on the row selection criteria
#' @param rmDuplicates Default \code{FALSE}, set to \code{TRUE} calls the \code{rtry_rm_dup()} function
#' @param showOverview Default \code{TRUE} displays the dimension of the data after row selection
#' @return A data table of the selected rows of the input data
#' @examples
#' \dontrun{
#' rtry_select_row(TRYdata, (TraitID > 0) | (DataID %in% c(59, 60)))
#' rtry_select_row(TRYdata, TraitID %in% c(6), getAuxiliary = TRUE, rmDuplicates = TRUE)
#' rtry_select_row(TRYdata, ErrorRisk < 4 | DataID %in% c(59, 60, 61, 6601, 327, 413, 1961, 210, 308))
#' }
#' @seealso \code{\link{rtry_rm_dup}}
#' @export
rtry_select_row <- function(input = "", ..., getAuxiliary = FALSE, rmDuplicates = FALSE, showOverview = TRUE){
  ObservationID <- NULL  # bind the variable OrigObsDataID locally to the function

  if(missing(input) || missing(...)){
    message("Please specify the input data and/or criteria for row selection.")
  }
  else{
    selectedRows <- subset(input, ...)

    if(getAuxiliary == TRUE){
      auxiliary <- unique(selectedRows$ObservationID)

      selectedRows <- subset(input, ObservationID %in% auxiliary)
    }

    if(rmDuplicates == TRUE){
      selectedRows <- rtry_rm_dup(selectedRows, showOverview = FALSE)
    }

    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(selectedRows), sep = " "))
    }

    return(selectedRows)
  }
}
