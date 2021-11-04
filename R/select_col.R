#' Select columns
#'
#' This function selects the specified columns from the input data.
#'
#' @param input Input data frame or data table.
#' @param \dots Column names to be selected.
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the selected columns.
#' @return An object of the same type as the input data.
#' @references This function makes use of the \code{\link[dplyr]{select}} function
#'             within the \code{dplyr} package.
#' @seealso \code{\link{rtry_remove_col}}
#' @examples
#' # Select certain columns from the provided sample data (data_TRY_15160)
#' data_selected <- rtry_select_col(data_TRY_15160,
#'                    ObsDataID, ObservationID, AccSpeciesID, AccSpeciesName,
#'                    ValueKindName, TraitID, TraitName, DataID, DataName, OriglName,
#'                    OrigValueStr, OrigUnitStr, StdValue, UnitName, OrigObsDataID,
#'                    ErrorRisk, Comment)
#'
#' # Expected message:
#' # dim:   1782 17
#' # col:   ObsDataID ObservationID AccSpeciesID AccSpeciesName ValueKindName TraitID
#' #        TraitName DataID DataName OriglName OrigValueStr OrigUnitStr StdValue
#' #        UnitName OrigObsDataID ErrorRisk Comment
#' @export
rtry_select_col <- function(input, ..., showOverview = TRUE){
  # If either of the arguments input or ... is missing, show the message
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or column names you would like to select.")
  }
  else{
    # Select all the specified columns within the input data
    input <- dplyr::select(input, ...)

    # Copy the selected columns into a new variable
    selectedColumns <- input

    # If the argument showOverview is set to be TRUE, print the dimension and column names of the selected data
    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(selectedColumns), sep = " "))
      message("col:   ", paste0(colnames(selectedColumns), sep = " "))
    }

    # Return the selected columns
    return(selectedColumns)
  }
}
