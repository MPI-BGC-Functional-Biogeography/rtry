#' Outer join for two data frames
#'
#' This function merges two data frames or data tables based on a specified common column and
#' returns all rows from both data, join records from the left (\code{x}) which have matching
#' keys in the right data frame (\code{y}). In order words, this functions performs an outer
#' join on the two provided data frames, i.e. the join table will contain all records from
#' both data frames or data tables.
#'
#' @param x A data frame or data table to be coerced and will be considered as the data on the left.
#' @param y A data frame or data table to be coerced and will be considered as the data on the right.
#' @param baseOn The common column used for merging.
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the merged data.
#' @return An object of the same type of the input data. The merged data is by default lexicographically sorted
#'         on the common column. The columns are the common column followed by the remaining columns in
#'         \code{x} and then those in \code{y}.
#' @references This function makes use of the \code{\link[base]{merge}} function
#'             within the \code{base} package.
#' @seealso \code{\link{rtry_join_left}}, \code{\link{rtry_bind_col}}, \code{\link{rtry_bind_row}}
#' @examples
#' # Assume a user has obtained two unique data tables, one with the ancillary data
#' # Longitude and one with Latitude (e.g. using rtry_select_anc()), and would like to
#' # merge two data tables into one according to the common identifier ObservationID.
#' # It does not matter if either Longitude or Latitude data has no record
#' lon <- rtry_select_anc(data_TRY_15160, 60)
#' lat <- rtry_select_anc(data_TRY_15160, 59)
#'
#' georef <- rtry_join_outer(lon, lat, baseOn = ObservationID)
#'
#' # Expected messages:
#' # dim:   97 2
#' # col:   ObservationID Longitude
#' #
#' # dim:   98 2
#' # col:   ObservationID Latitude
#' #
#' # dim:   98 3
#' # col:   ObservationID Longitude Latitude
#' @export
rtry_join_outer <- function(x, y, baseOn, showOverview = TRUE){
  # If any of the data frame is missing, show the message
  if(missing(x) || missing(y) || missing(baseOn)){
    message("Please specify the two data frames and/or the common attribute `baseOn` that you would like to use for merging.")
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
      message("Please make sure the column specified in `baseOn` exists in both data frames.")
    }
  }
}
