#' Select rows
#'
#' This function selects rows based on specified criteria
#' and the corresponding \code{ObservationID} from the imported data for further processing.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param \dots Criteria for row selection
#' @param getAuxiliary Default \code{FALSE}, set to \code{TRUE} selects all auxiliary data based on the row selection criteria
#' @param rmDuplicates Default \code{FALSE}, set to \code{TRUE} calls the \code{rtry_rm_dup()} function
#' @param showOverview Default \code{TRUE} displays the dimension of the data after row selection
#' @return A data table of the selected rows of the input data
#' @examples
#' # Select all traits records where DataID equals to 59 or 60
#' # together with all the corresponding auxiliary data without any duplicates
#' # within the provided sample data (TRYdata_15160)
#' data_selected <- rtry_select_row(TRYdata_15160,
#'                    (TraitID > 0) | (DataID %in% c(59, 60)),
#'                    getAuxiliary = TRUE,
#'                    rmDuplicates = TRUE)
#'
#' # Expected output:
#' # 45 duplicates removed.
#' # dim:   1737 28
#' @seealso \code{\link{rtry_rm_dup}}
#' @note This function by default filters data based on the unique identifier \code{ObservationID}
#' listed in the TRY data, therefore, if the column \code{ObservationID} has been removed, this function
#' will not work.
#' @export
rtry_select_row <- function(input = "", ..., getAuxiliary = FALSE, rmDuplicates = FALSE, showOverview = TRUE){
  # Bind the variable ObservationID locally to the function
  ObservationID <- NULL

  # If either of the arguments input or ... is missing, show the message
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or criteria for row selection.")
  }
  else{
    # Select all the rows that fit the criteria within the input data
    selectedRows <- subset(input, ...)

    # If the argument getAuxiliary is set to be TRUE, obtain a list of unique ObservationID from the selected rows
    # Select all the rows that have the listed ObservationID
    if(getAuxiliary == TRUE){
      auxiliary <- unique(selectedRows$ObservationID)
      selectedRows <- subset(input, ObservationID %in% auxiliary)
    }

    # If the argument rmDuplicates is set to be TRUE
    # Call the rtry_rm_dup functions to remove duplicates within the selected data
    if(rmDuplicates == TRUE){
      selectedRows <- rtry_rm_dup(selectedRows, showOverview = FALSE)
    }

    # If the argument showOverview is set to be TRUE, print the dimension of the selected data
    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(selectedRows), sep = " "))
    }

    # Return the selected rows
    return(selectedRows)
  }
}
