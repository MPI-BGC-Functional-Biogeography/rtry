#' Filter TRY data using keywords
#'
#' This function filters data from the input data based on the specified keyword(s)
#' and the corresponding \code{ObservationID}.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param attribute Attribute (column name) for filtering
#' @param ... Values (keywords) for filtering
#' @param caseSensitive Default \code{TRUE} performs case-sensitive filtering
#' @param exactMatch Default \code{TRUE} performs exact match filtering, overrides all conflicting arguments
#' @param showOverview Default \code{TRUE} displays the dimension of data table after filtering
#' @return A data table of the input data after filtering
#' @examples
#' \dontrun{
#' rtry_filter_keyword(TRYdata, OrigValueStr, c("juvenile"), caseSensitive = FALSE, exactMatch = FALSE)
#' }
#' @seealso \code{\link{rtry_filter}}
#' @export
rtry_filter_keyword <- function(input = "", attribute = NULL, ..., caseSensitive = TRUE, exactMatch = TRUE, showOverview = TRUE){
  if(missing(input) || missing(attribute) || missing(...)){
    message("Please specify the input data and/or attribute and/or keywords for filtering.")
  }
  else{
    attribute <- deparse(substitute(attribute))

    if(exactMatch == TRUE){
      if(caseSensitive == FALSE){
        message("argument 'caseSensitive = FALSE' will be ignored.")
      }
      exclude <- subset(input, input[[attribute]] %in% ...)
    }

    else{
      exclude <- subset(input, grepl(paste(..., collapse = "|"), input[[attribute]], ignore.case = !caseSensitive))
    }

    exclude <- unique(exclude$ObservationID)

    input$exclude <- input$ObservationID %in% exclude

    filteredData <- subset(input, input$exclude == FALSE, select = -(exclude))

    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(filteredData), sep = " "))
    }

    return(filteredData)
  }
}
