#' Select rows
#'
#' This function selects rows based on specified criteria
#' and the corresponding \code{ObservationID} from the imported data for further processing.
#'
#' @param input Input data frame or data table.
#' @param \dots Criteria for row selection.
#' @param getAncillary Default \code{FALSE}, set to \code{TRUE} selects all ancillary data based on the row selection criteria.
#' @param rmDuplicates Default \code{FALSE}, set to \code{TRUE} calls the function \code{\link{rtry_remove_dup}}.
#' @param showOverview Default \code{TRUE} displays the dimension of the data after row selection.
#' @return An object of the same type as the input data.
#' @references This function makes use of the \code{\link[base]{unique}} and \code{\link[base]{subset}} functions
#'             within the \code{base} package. It also uses the function \code{\link{rtry_remove_dup}}.
#' @note This function by default filters data based on the unique identifier \code{ObservationID}
#'       listed in the TRY data, therefore, if the column \code{ObservationID} has been removed,
#'       this function will not work.
#' @examples
#' # Within the provided sample data (data_TRY_15160) select the georeferenced traits
#' # records together with records for Latitude and Longitude (DataID 59 and 60) and
#' # exclude duplicate trait records
#' data_selected <- rtry_select_row(data_TRY_15160,
#'                    (TraitID > 0) | (DataID %in% c(59, 60)),
#'                    getAncillary = TRUE,
#'                    rmDuplicates = TRUE)
#'
#' # Expected message:
#' # 45 duplicates removed.
#' # dim:   1737 28
#' @export
rtry_select_row <- function(input, ..., getAncillary = FALSE, rmDuplicates = FALSE, showOverview = TRUE){
  # Bind the variable ObservationID locally to the function
  ObservationID <- NULL

  # If either of the arguments input or ... is missing, show the message
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or criteria for row selection.")
  }
  else{
    # Select all the rows that fit the criteria within the input data
    selectedRows <- subset(input, ...)

    # If the argument getAncillary is set to be TRUE, obtain a list of unique ObservationID from the selected rows
    # Select all the rows that have the listed ObservationID
    if(getAncillary == TRUE){
      ancillary <- unique(selectedRows$ObservationID)
      selectedRows <- subset(input, ObservationID %in% ancillary)
    }

    # If the argument rmDuplicates is set to be TRUE
    # Call the rtry_remove_dup function to remove duplicates within the selected data
    if(rmDuplicates == TRUE){
      selectedRows <- rtry_remove_dup(selectedRows, showOverview = FALSE)
    }

    # If the argument showOverview is set to be TRUE, print the dimension of the selected data
    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(selectedRows), sep = " "))
    }

    # Return the selected rows
    return(selectedRows)
  }
}
