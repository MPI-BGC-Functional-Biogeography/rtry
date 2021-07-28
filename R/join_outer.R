#' Outer join for two data frames
#'
#' This function merges two data frames based on the row names of the  specified common column
#' (by default: \code{ObservationID}) and returns all rows from both tables, join records from
#' the left (\code{x}) which have matching keys in the right data frame (\code{y}).
#' In order words, this functions performs an outer join on the two provided data frames,
#' i.e. the join table will contain all records from both the tables.
#'
#' @param x The left data frame, imported by \code{rtry_import()} or in data table format
#' @param y The right data frame, imported by \code{rtry_import()} or in data table format
#' @param baseOn Default \code{ObservationID}, the common column used for merging
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the data after merging
#' @return A data table of the merged data
#' @examples
#' # Assume user has obtained a unique list of auxiliary data (e.g. Longitude and Latitude)
#' # using rtry_select_aux() and would like to merge all the georeferenced data into one data
#' # table according to the identifier ObservationID, does not matter if either Longitude or
#' # Latitude data is not recorded
#' lon <- rtry_select_aux(TRYdata_15160, Longitude)
#' lat <- rtry_select_aux(TRYdata_15160, Latitude)
#'
#' georef <- rtry_join_outer(lon, lat)
#'
#' # Expected output:
#' # dim:   97 2
#' # col:   ObservationID Longitude
#' #
#' # dim:   98 2
#' # col:   ObservationID Latitude
#' #
#' # dim:   98 3
#' # col:   ObservationID Longitude Latitude
#' @seealso \code{\link{rtry_join_left}}, \code{\link{rtry_bind_col}}, \code{\link{rtry_bind_row}}
#' @export
rtry_join_outer <- function(x = "", y = "", baseOn = ObservationID, showOverview = TRUE){
  # Bind the variable OrigObsDataID locally to the function
  ObservationID <- NULL

  # If any of the data frame is missing, show the message
  if(missing(x) || missing(y)){
    message("Please specify the two data frames you would like to merge.")
  }
  else{
    # Add quotations around the value in the baseOn argument when baseOn is not a character class
    col_name <- deparse(substitute(baseOn))

    # If the baseOn column exists in both data frame, continue the duplicates removal process
    if(col_name %in% colnames(x) && col_name %in% colnames(y)){
      # Perform left join using the merge function
      mergedXY <- merge(x, y, by = col_name, all = TRUE)

      # If the argument showOverview is set to be TRUE, print the dimension and column names of the merged data
      if(showOverview == TRUE){
        message("dim:   ", paste0(dim(mergedXY), sep = " "))
        message("col:   ", paste0(colnames(mergedXY), sep = " "))
      }

      # Return the merged data
      return(mergedXY)
    }
    # If the baseOn column does not exist in the input data, show the message
    else{
      message("Please make sure the column specified in 'baseOn', by default: `ObservationID`, exists in both data frames.")
    }
  }
}
