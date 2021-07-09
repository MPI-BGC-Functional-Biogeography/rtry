#' Merge two data frames (left join)
#'
#' This function merges two data frames based on a specified common column (by default: \code{ObservationID})
#' and returns all records from the left data frame (\code{x}) together with the matched records
#' from the right data frame (\code{y}) for further processing. In order words, this functions performs
#' a left join on the two provided data frames.
#'
#' @param x The left data frame, imported by \code{rtry_import()} or in data table format
#' @param y The right data frame, imported by \code{rtry_import()} or in data table format
#' @param baseOn Default \code{ObservationID}, the common column used for merging
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the data after merging
#' @return A data table of the merged data
#' @examples
#' \dontrun{
#' rtry_merge_col(TRYdata1, TRYdata2)
#' }
#' @export
rtry_merge_col <- function(x = "", y = "", baseOn = ObservationID, showOverview = TRUE){
  # Bind the variable OrigObsDataID locally to the function
  ObservationID <- NULL

  # If any of the data frame is missing, show the message
  if(missing(x) || missing(y)){
    message("Please specify the two data frames you would like to merge")
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
      message("Please make sure the column specified in 'baseOn' (by default: `ObservationID`) exists in both data frames.")
    }
  }
}
