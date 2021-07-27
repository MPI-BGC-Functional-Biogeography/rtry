#' Select columns
#'
#' This function selects specified columns from the imported data and saves them in a new data table.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Column names to be selected
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the selected columns
#' @return A data table of the selected columns of the input data
#' @examples
#' # Select certain columns from the provided sample data (TRYdata_15160)
#' data_selected <- rtry_select_col(TRYdata_15160,
#'                    ObsDataID, ObservationID, AccSpeciesID, AccSpeciesName,
#'                    ValueKindName, TraitID, TraitName, DataID, DataName,
#'                    OriglName, OrigValueStr, OrigUnitStr, StdValue, UnitName,
#'                    OrigObsDataID, ErrorRisk, Comment)
#'
#' # Expected output:
#' # dim:   1782 17
#' # col:   ObsDataID ObservationID AccSpeciesID AccSpeciesName ValueKindName
#' #        TraitID TraitName DataID DataName OriglName OrigValueStr OrigUnitStr
#' #        StdValue UnitName OrigObsDataID ErrorRisk Comment
#' @seealso \code{\link{rtry_rm_col}}
#' @references \href{https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/select}{dplyr::select()}
#' @export
rtry_select_col <- function(input = "", ..., showOverview = TRUE){
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
