#' Left join for two data frames
#'
#' This function merges two data frames or data tables based on a specified common column and
#' returns all records from the left data frame (\code{x}) together with the matched records
#' from the right data frame (\code{y}), while discards all the records in the right data frame
#' that does not exist in the left data frame. In other words, this function performs a left join
#' on the two provided data frames or data tables.
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
#' @examples
#' # Assume a user has obtained two unique data tables, one with the auxiliary data
#' # Longitude and one with Latitude (e.g. using rtry_select_aux()), and would like to
#' # add a column Latitude to the data table with Longitude based on the common
#' # identifier ObservationID
#' lon <- rtry_select_aux(TRYdata_15160, Longitude)
#' lat <- rtry_select_aux(TRYdata_15160, Latitude)
#'
#' georef <- rtry_join_left(lon, lat, baseOn = ObservationID)
#'
#' # Expected message:
#' # dim:   97 2
#' # col:   ObservationID Longitude
#' #
#' # dim:   98 2
#' # col:   ObservationID Latitude
#' #
#' # dim:   97 3
#' # col:   ObservationID Longitude Latitude
#' @seealso \code{\link{rtry_join_outer}}, \code{\link{rtry_bind_col}}, \code{\link{rtry_bind_row}}
#' @export
rtry_join_left <- function(x, y, baseOn, showOverview = TRUE){
  # If any of the data frame is missing, show the message
  if(missing(x) || missing(y) || missing(baseOn)){
    message("Please specify the two data frames and/or the common attribute `baseOn` that you would like to use for merging.")
  }
  else{
    # Add quotations around the value in the baseOn argument
    col_name <- deparse(substitute(baseOn))

    # If the baseOn column exists in both data frame, continue the duplicates removal process
    if(col_name %in% colnames(x) && col_name %in% colnames(y)){
      # Perform left join using the merge function
      mergedXY <- merge(x, y, by = col_name, all.x = TRUE)

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
