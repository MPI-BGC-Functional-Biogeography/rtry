#' Bind data by rows
#'
#' This function takes a sequence of data imported by \code{rtry_import()}
#' and combines them by rows. The data should share the same number of columns
#' and column names.
#'
#' @param ... A sequence of data frame to be combined by rows
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data
#' @return A data table of the input data
#' @examples
#' # Combine the two provided sample data (TRYdata_15160 and TRYdata_15160)
#' data <- rtry_bind_row(TRYdata_15160, TRYdata_15161)
#'
#' # Expected output:
#' # dim:   6409 28
#' # col:   LastName FirstName DatasetID Dataset SpeciesName
#' #        AccSpeciesID AccSpeciesName ObservationID ObsDataID TraitID
#' #        TraitName DataID DataName OriglName OrigValueStr OrigUnitStr
#' #        ValueKindName OrigUncertaintyStr UncertaintyName Replicates
#' #        StdValue UnitName RelUncertaintyPercent OrigObsDataID ErrorRisk
#' #        Reference Comment V28
#' @export
rtry_bind_row <- function(..., showOverview = TRUE){
  # If ... is missing, show the message
  if(missing(...)){
    message("Please specify at least two data frames to be combined by rows")
  }
  else{
    # Perform row binding
    TRYdata <- rbind(...)

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
