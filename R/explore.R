#' Explore data
#'
#' This function takes the data table imported by \code{rtry_import()} and converts it into
#' a grouped data table based on the specified column names.
#' Note that the output data are grouped by the first attribute if not specified using the parameter \code{sortBy}.
#' To provide a first understanding of the data, an additional column is added to show the total count within each group.
#'
#' @param input Input data, imported by \code{rtry_import()} function or in data table format
#' @param \dots Attribute names to group together
#' @param sortBy (Optional) Specify the attribute name used to re-order the rows
#' @param showOverview Default \code{TRUE} displays the dimension of the result data table
#' @return A data table of the unique values grouped by the desired attribute(s)
#' @examples
#' # Explore the unique values in the provided sample data (TRYdata_15160)
#' # based on the attributes AccSpeciesID, DataID, DataName, TraitID and TraitName,
#' # and sorted by DataName
#' data_explore <- rtry_explore(TRYdata_15160,
#'                   AccSpeciesID, DataID, DataName, TraitID, TraitName,
#'                   sortBy = DataName)
#'
#' # Expected output:
#' # dim:   235 6
#' @references \href{https://www.rdocumentation.org/packages/dplyr/versions/0.7.1/topics/group_by}{dplyr::group_by()}
#' @export
rtry_explore <- function(input = "", ..., sortBy = "", showOverview = TRUE){
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
