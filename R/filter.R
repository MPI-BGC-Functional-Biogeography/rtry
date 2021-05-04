#' Filter TRY data
#'
#' This function filters data from the input data based on the specified criteria and the corresponding \code{ObservationID}.
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
#' @export
rtry_filter <- function(input = "", ..., baseOn = ObservationID, showOverview = TRUE){
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
