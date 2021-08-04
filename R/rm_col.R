#' Remove columns
#'
#' This function removes specified columns from the imported data for further processing.
#'
#' @param input Input data frame or data table.
#' @param \dots Names of columns to be removed separated by commas. \code{:} can be used
#'              for selecting a range of consecutive variables.
#' @param showOverview Default \code{TRUE} displays the dimension of the remaining data.
#' @return An object of the same type as the input data.
#' @references This function makes use of the \code{\link[dplyr]{select}} function
#'             within the \code{dplyr} package.
#' @seealso \code{\link{rtry_select_col}}
#' @examples
#' # Remove certain columns from the provided sample data (TRYdata_15160)
#' data_rm_col <- rtry_rm_col(TRYdata_15160,
#'                  LastName, FirstName, DatasetID, Dataset, SpeciesName,
#'                  OrigUncertaintyStr, UncertaintyName, Replicates,
#'                  RelUncertaintyPercent, Reference, V28)
#'
#' # Expected message:
#' # dim:   1782 17
#' # col:   AccSpeciesID AccSpeciesName ObservationID ObsDataID TraitID TraitName
#' #        DataID DataName OriglName OrigValueStr OrigUnitStr ValueKindName
#' #        StdValue UnitName OrigObsDataID ErrorRisk Comment
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
