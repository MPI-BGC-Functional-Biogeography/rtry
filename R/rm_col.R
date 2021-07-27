#' Remove columns
#'
#' This function removes specified columns from the imported data for further processing.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Column names to be removed
#' @param showOverview Default \code{TRUE} displays the dimension of the selected columns
#' @return A data table of the remaining columns of the input data
#' @examples
#' # Remove certain columns from the provided sample data (TRYdata_15160)
#' data_rm_col <- rtry_rm_col(TRYdata_15160,
#'                  LastName, FirstName, DatasetID, Dataset, SpeciesName,
#'                  OrigUncertaintyStr, UncertaintyName, Replicates,
#'                  RelUncertaintyPercent, Reference, V28)
#'
#' # Expected output:
#' # dim:   1782 17
#' # col:   AccSpeciesID AccSpeciesName ObservationID ObsDataID TraitID TraitName
#'          DataID DataName OriglName OrigValueStr OrigUnitStr ValueKindName
#'          StdValue UnitName OrigObsDataID ErrorRisk Comment
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
