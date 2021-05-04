#' Remove duplicates in TRY data
#'
#' This function identifies and removed the duplicates from the input data.
#' Once the function is called and executed, the number of duplicates removed will be displayed on the console as reference.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param showOverview Default \code{TRUE} displays the the dimension of data table after removal
#' @return A data table of the input data after removing the duplicates
#' @examples
#' \dontrun{
#' rtry_rm_dup(TRYdata)
#' }
#' @note This function depends on the duplicate identifier \code{OrigObsDataID} listed in the TRYdata,
#' therefore, if the column \code{OrigObsDataID} has been removed, this function will not work. Also,
#' if the imported TRYdata contains restricted dataset that belongs to another dataset (i.e. having an
#' \code{OrigObsDataID}), these restricted data will also be removed resulting in data loss.
#' @export
rtry_rm_dup <- function(input = "", showOverview = TRUE){
  if(missing(input)){
    message("Please specify the input data for removing duplicates.")
  }
  else{
    exclude <- subset(input, OrigObsDataID > 0)

    exclude <- unique(exclude$OrigObsDataID)

    input$exclude <- input$OrigObsDataID %in% exclude
    numDuplicates <- length(which(input$exclude == TRUE))

    input <- subset(input, input$exclude == FALSE, select = -(exclude))

    inputRemovedDuplicates <- input
    message(numDuplicates, " duplicates removed.")

    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(inputRemovedDuplicates), sep = " "))
    }

    return(inputRemovedDuplicates)
  }
}
