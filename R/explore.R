#' Explore data
#'
#' This function takes a data frame or data table and converts it into a grouped data frame of unique values
#' based on the specified column names. A column (\code{Count}) is added, which shows the number of records
#' within each group. The data are grouped by the first attribute if not specified with the argument \code{sortBy}.
#'
#' @param input Data frame or data table, e.g. from \code{rtry_import()}.
#' @param \dots Attribute names to group together.
#' @param sortBy (Optional) Default \code{""} indicates no sorting is applied to the grouped data.
#'               Specify the attribute name used to re-order the rows in ascending order.
#' @param showOverview Default \code{TRUE} displays the dimension of the result data table.
#' @return A data frame of unique values grouped and sorted by the specified attribute(s).
#' @references This function makes use of the \code{\link[dplyr]{group_by}}, \code{\link[dplyr]{summarise}}
#'             and \code{\link[dplyr]{arrange}} functions within the \code{dplyr} package.
#' @examples
#' # Explore the unique values in the provided sample data (TRYdata_15160)
#' # based on the attributes AccSpeciesID, AccSpeciesName, TraitID, TraitName, DataID
#' # and DataName, sorted by TraitID
#' data_explore <- rtry_explore(TRYdata_15160,
#'                   AccSpeciesID, AccSpeciesName, TraitID, TraitName, DataID, DataName,
#'                   sortBy = TraitID)
#'
#' # Expected message:
#' # dim:   235 7
#'
#' # Learn more applications of the explore function via the vignette (Workflow for
#' # general data preprocessing using rtry): vignette("rtry-workflow-general").
#' @export
rtry_explore <- function(input, ..., sortBy = "", showOverview = TRUE){
  # If either of the arguments input or ... is missing, show the message
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or attribute names you would like to group together.")
  }
  else{
    # Group the input data based on the specified columns
    # Compute a summary for each group
    input <- dplyr::group_by(input, ...)
    input <- dplyr::summarise(input, Count = dplyr::n(), .groups = 'drop')

    # If the sortBy argument is specified, re-order the rows accordingly
    input <- dplyr::arrange(input, {{sortBy}})

    # Copy the processed data into a new variable
    uniqueData <- input

    # If the argument showOverview is set to be TRUE, print the dimension of the data exploration
    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(uniqueData), sep = " "))
    }

    # Return the data exploration result
    return(uniqueData)
  }
}
