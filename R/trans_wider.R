#' Transform data from long to wide table
#'
#' This function transforms the original long table format of the data into a wide table format.
#'
#' @param input Input data frame or data table.
#' @param names_from The column(s) from which the output column names to be obtained.
#' @param values_from The column(s) from which the output values to be obtained.
#' @param values_fn (Optional) Function to be applied to the output values.
#' @param showOverview Default \code{TRUE} displays the dimension of the wide table.
#' @return A data frame of the transformed wide table.
#' @references This function makes use of the \code{\link[tidyr]{pivot_wider}} function
#'             within the \code{tidyr} package.
#' @seealso \code{\link{rtry_select_row}}, \code{\link{rtry_select_col}}, \code{\link{rtry_select_anc}},
#'          \code{\link{rtry_join_left}}
#' @examples
#' # Provide the standardized trait values per observation, together with species names
#' # and the georeferences of the sampling site (Latitude and Longtude), if availalbe,
#' # in a wide table format. Several steps are necessary:
#'
#' # 1. Select only the trait records that have standardized numeric values.
#' #    The complete.cases() is used to ensure the cases are complete, i.e. have no
#' #    missing values.
#' num_traits <- rtry_select_row(data_TRY_15160,
#'                 complete.cases(TraitID) & complete.cases(StdValue))
#'
#' # 2. Select the relevant columns for transformation.
#' num_traits <- rtry_select_col(num_traits,
#'                 ObservationID, AccSpeciesID, AccSpeciesName, TraitID, TraitName,
#'                 StdValue, UnitName)
#'
#' # 3. Extract the values of georeferences and the corresponding ObservationID.
#' lat <- rtry_select_anc(data_TRY_15160, Latitude)
#' lon <- rtry_select_anc(data_TRY_15160, Longitude)
#'
#' # 4. Merge the relevant data frames based on the ObservationID using rtry_join_left().
#' num_traits_georef <- rtry_join_left(num_traits, lat, baseOn = ObservationID)
#' num_traits_georef <- rtry_join_left(num_traits_georef, lon, baseOn = ObservationID)
#'
#' # 5. Perform wide table transformation of TraitID, TraitName and UnitName based on
#' #    ObservationID, AccSpeciesID and AccSpeciesName with cell values from StdValue.
#' #    If several records with StdValue were provided for one trait with the same
#' #    ObservationID, AccSpeciesID and AccSpeciesName, calculate their mean.
#' num_traits_georef_wider <- rtry_trans_wider(num_traits_georef,
#'                              names_from = c(TraitID, TraitName, UnitName),
#'                              values_from = c(StdValue),
#'                              values_fn = list(StdValue = mean))
#'
#' # Expected messages:
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
#'
#' # Learn more via the vignette (Workflow for general data preprocessing using rtry):
#' # vignette("rtry-workflow-general")
#' @export
rtry_trans_wider <- function(input,
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
