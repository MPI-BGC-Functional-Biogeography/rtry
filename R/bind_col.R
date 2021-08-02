#' Bind data by columns
#'
#' This function takes a list of data frames or data tables and combines them by columns.
#' The data have to have the same number and sequence of rows.
#'
#' @param \dots A list of data frames or data tables to be combined by columns.
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data.
#' @return An object of the same type as the first input, either a data frame, \code{tbl_df}, or \code{grouped_df}.
#' @examples
#' # Assuming a user has selected different columns as separated data tables
#' # and later on would like to combine them as one for further processing.
#' data1 <- rtry_select_col(TRYdata_15160,
#'            ObsDataID, ObservationID, AccSpeciesID, AccSpeciesName,
#'            ValueKindName, TraitID, TraitName, DataID, DataName,
#'            OrigObsDataID, ErrorRisk, Comment)
#'
#' data2 <- rtry_select_col(TRYdata_15160,
#'            OriglName, OrigValueStr, OrigUnitStr, StdValue, UnitName)
#'
#' data <- rtry_bind_col(data1, data2)
#'
#' # Expected message:
#' # dim:   1782 12
#' # col:   ObsDataID ObservationID AccSpeciesID AccSpeciesName
#' #        ValueKindName TraitID TraitName DataID DataName
#' #        OrigObsDataID ErrorRisk Comment
#' #
#' # dim:   1782 5
#' # col:   OriglName OrigValueStr OrigUnitStr StdValue UnitName
#' #
#' # dim:   1782 17
#' # col:   ObsDataID ObservationID AccSpeciesID AccSpeciesName
#' #        ValueKindName TraitID TraitName DataID DataName
#' #        OrigObsDataID ErrorRisk Comment OriglName OrigValueStr
#' #        OrigUnitStr StdValue UnitName
#' @note A common attribute is not necessary (difference to the function \code{\link{rtry_join_left}} and \code{\link{rtry_join_outer}}):
#'       the binding process simply puts the data side-by-side.
#' @seealso \code{\link{rtry_bind_row}}, \code{\link{rtry_join_left}}, \code{\link{rtry_join_outer}}
#' @references This function makes use of the \code{\link[dplyr]{bind_cols}} function within the \code{dplyr} package.
#' @export
rtry_bind_col <- function(..., showOverview = TRUE){
  # If ... is missing, show the message
  if(missing(...)){
    message("Please specify at least two data frames to be combined by columns.")
  }
  else{
    # Perform column binding
    TRYdata <- dplyr::bind_cols(...)

    # If the combined data is not NULL and if the argument showOverview is set to be TRUE
    # Print the dimension and column names of the combined data
    if(length(TRYdata) != 0 && showOverview == TRUE){
      message("dim:   ", paste0(dim(TRYdata), sep = " "))
      message("col:   ", paste0(colnames(TRYdata), sep = " "))
    }

    # Return the combined data
    return(TRYdata)
  }
}
