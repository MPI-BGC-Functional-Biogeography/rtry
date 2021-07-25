#' Transform TRY data from long to wide table
#'
#' This function transforms the original long table format of the TRY data into a wide table format.
#'
#' @param input Input data, imported by \code{rtry_import()} function or in data table format
#' @param names_from The column(s) from which the output column names to be obtained
#' @param values_from The column(s) from which the output values to be obtained
#' @param values_fn (Optional) Function to be applied to the output values
#' @param showOverview Default \code{TRUE} displays the dimension of the result data table
#' @return The transformed wide table
#' @examples
#' \dontrun{
#' rtry_trans_wider(TRYdata,
#'                  names_from = c(TraitID, TraitName, UnitName),
#'                  values_from = c(StdValue, ErrorRisk),
#'                  values_fn = list(StdValue = mean, ErrorRisk = mean))
#' }
#' @references \href{https://rdrr.io/github/tidyverse/tidyr/man/pivot_wider.html}{tidyr::pivot_wider()}
#' @export
rtry_trans_wider <- function(input = "",
                             names_from = NULL,
                             values_from = NULL,
                             values_fn = NULL,
                             showOverview = TRUE){
  # If =the argument input is missing, show the message
  if(missing(input)){
    message("Please specify the input data for transforming from long table to wide table.")
  }
  else{
    # Copy the input data into a new variable
    longTable <- input

    # Perform long table to wide table transformation using the pivot_wider function
    wideTable <- tidyr::pivot_wider(longTable,
                                    names_from = {{names_from}},
                                    values_from = {{values_from}},
                                    values_fn = {{values_fn}})

    # If the argument showOverview is set to be TRUE, print the dimension of the wide table
    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(wideTable), sep = " "))
    }

    # Return the wide table
    return(wideTable)
  }
}
