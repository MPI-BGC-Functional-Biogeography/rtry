#' Explore TRY data
#'
#' This function takes the data table imported by \code{rtry_import()} and converts it into
#' a grouped data table based on the specified column names.
#' Note the the output data is grouped by the first attribute if not specified using the parameter \code{sortBy}.
#' To provide a first understanding of the data, an additional column is added to show the total count within each group.
#'
#' @param input Input data, imported by \code{rtry_import()} function or in data table format
#' @param ... Attribute names to group together
#' @param sortBy (Optional) Specify the attribute name used to reorder the rows
#' @param showOverview Default \code{TRUE} displays the dimension of the result data table
#' @return A data table of the unique values grouped by the desired attribute(s)
#' @examples
#' \dontrun{
#' rtry_explore(TRYdata, AccSpeciesID, DataID, DataName, TraitID, TraitName)
#' rtry_explore(TRYdata, AccSpeciesID, DataID, DataName, TraitID, TraitName, sortBy = DataName)
#' }
#' @references \href{https://www.rdocumentation.org/packages/dplyr/versions/0.7.1/topics/group_by}{dplyr::group_by()}
#' @export
rtry_explore <- function(input = "", ..., sortBy = "", showOverview = TRUE){
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or attribute names you would like to group together.")
  }
  else{
    input <- dplyr::group_by(input, ...)
    input <- dplyr::summarise(input, Count = dplyr::n(), .groups = 'drop')

    input <- dplyr::arrange(input, {{sortBy}})

    uniqueData <- input

    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(uniqueData), sep = " "))
    }

    return(uniqueData)
  }
}
