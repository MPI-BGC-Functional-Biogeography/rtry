#' Transform data from long to wide table
#'
#' This function transforms the original long table format of the data into a wide table format.
#'
#' @param input Input data, imported by \code{rtry_import()} function or in data table format
#' @param names_from The column(s) from which the output column names to be obtained
#' @param values_from The column(s) from which the output values to be obtained
#' @param values_fn (Optional) Function to be applied to the output values
#' @param showOverview Default \code{TRUE} displays the dimension of the result data table
#' @return The transformed wide table
#' @examples
#' # Select only the trait records that has standardized numeric values
#' # Then select the relevant columns for transformation
#' num_traits <- rtry_select_row(TRYdata_15160,
#'                 complete.cases(TraitID) & complete.cases(StdValue))
#' num_traits <- rtry_select_col(num_traits,
#'                 ObservationID, AccSpeciesID, AccSpeciesName, TraitID, TraitName,
#'                 StdValue, UnitName)
#'
#' # Extract the unique value of latitude and longitude data
#' # and the corresponding ObservationID
#' lat <- rtry_select_aux(TRYdata_15160, Latitude)
#' lon <- rtry_select_aux(TRYdata_15160, Longitude)
#'
#' # Merge the relevant data frames based on the ObservationID using rtry_merge_col (left join)
#' num_traits_georef <- rtry_merge_col(num_traits, lat)
#' num_traits_georef <- rtry_merge_col(num_traits_georef, lon)
#'
#' # Perform wide table transformation on TraitID, TraitName and UnitName
#' # With cell values to be the mean values calculated for StdValue
#' num_traits_georef_wider <- rtry_trans_wider(num_traits_georef,
#'                              names_from = c(TraitID, TraitName, UnitName),
#'                              values_from = c(StdValue),
#'                              values_fn = list(StdValue = mean))
#'
#' # Expected output:
#' # dim:   150 28
#' # dim:   150 7
#' # col:   ObservationID AccSpeciesID AccSpeciesName TraitID TraitName
#' #        StdValue UnitName
#' #
#' # dim:   98 2
#' # col:   ObservationID Latitude
#' #
#' # dim:   97 2
#' # col:   ObservationID Longitude
#' #
#' # dim:   150 8
#' # col:   ObservationID AccSpeciesID AccSpeciesName TraitID TraitName
#' #        StdValue UnitName Latitude
#' #
#' # dim:   150 9
#' # col:   ObservationID AccSpeciesID AccSpeciesName TraitID TraitName
#' #        StdValue UnitName Latitude Longitude
#' #
#' # dim:   146 7
#' #
#' # Learn more via the vignette (Workflow for general data preprocessing using rtry):
#' # vignette("rtry-workflow-general")
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
