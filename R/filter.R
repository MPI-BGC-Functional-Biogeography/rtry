#' Filter TRY data
#'
#' This function filters data from the input data based on the specified criteria
#' and by default this filtering is performed based on the corresponding \code{ObservationID}.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Criteria for filtering
#' @param baseOn Default \code{ObservationID}, the parameter used for filtering
#' @param showOverview Default \code{TRUE} displays the dimension of data table after filtering
#' @return A data table of the input data after filtering
#' @examples
#' \dontrun{
#' rtry_filter(TRYdata, OrigValueStr %in% c("juvenile", "Juvenile", "juvenile, 6 weeks"))
#' }
#' @seealso \code{\link{rtry_filter_keyword}}
#' @note This function by default filters data based on the unique identifier \code{ObservationID}
#' listed in the TRY data, therefore, if the column \code{ObservationID} has been removed, this function
#' might not work (unless another attribute is defined when calling the function).
#' @export
rtry_filter <- function(input = "", ..., baseOn = ObservationID, showOverview = TRUE){
  ObservationID <- NULL  # bind the variable ObservationID locally to the function

  if(missing(input) || missing(...)){
    message("Please specify the input data and/or criteria for filtering.")
  }
  else{
    baseOn <- deparse(substitute(baseOn))

    exclude <- subset(input, ...)
    exclude <- unique(exclude[[baseOn]])

    input$exclude <- input[[baseOn]] %in% exclude

    filteredData <- subset(input, input$exclude == FALSE, select = -(exclude))

    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(filteredData), sep = " "))
    }

    return(filteredData)
  }
}
