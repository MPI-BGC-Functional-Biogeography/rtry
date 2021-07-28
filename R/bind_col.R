#' Bind data by columns
#'
#' This function takes a sequence of data imported by \code{rtry_import()}
#' and combines them by columns. The data should share the same number of rows.
#'
#' @param \dots A sequence of data frame to be combined by columns
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data
#' @return A data table of the input data
#' @examples
#' # Assuming user has selected different columns as separated data tables
#' # and later on would like to combine as one for further processing
#' # Note: the binding process simply put the data side-by-side
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
#' # Expected output:
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
#' @seealso \code{\link{rtry_merge_col}}
#' @export
rtry_bind_col <- function(..., showOverview = TRUE){
  # If ... is missing, show the message
  if(missing(...)){
    message("Please specify at least two data frames to be combined by columns.")
  }
  else{
    # Perform column binding
    TRYdata <- cbind(...)

    # If the combined data is not NULL and if the argument showOverview is set to be TRUE
    # Print the dimension and column names of the combined data
    if(!is.null(TRYdata) && showOverview == TRUE){
      message("dim:   ", paste0(dim(TRYdata), sep = " "))
      message("col:   ", paste0(colnames(TRYdata), sep = " "))
    }

    # Return the combined data
    return(TRYdata)
  }
}
