#' Filter data using keywords
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
#' @note This function filters data based on the unique identifier \code{ObservationID}
#' listed in the TRY data, therefore, if the column \code{ObservationID} has been removed, this function
#' will not work.
#' @examples
#' \dontrun{
#' rtry_filter_keyword(TRYdata, OrigValueStr, c("juvenile"), caseSensitive = FALSE, exactMatch = FALSE)
#' }
#' @seealso \code{\link{rtry_filter}}
#' @export
rtry_filter_keyword <- function(input = "",
                                attribute = NULL,
                                ...,
                                caseSensitive = TRUE,
                                exactMatch = TRUE,
                                showOverview = TRUE){
  # If either of the arguments input or attribute or ... is missing, show the message
  if(missing(input) || missing(attribute) || missing(...)){
    message("Please specify the input data and/or attribute and/or keywords for filtering.")
  }
  else{
    # Add quotations around the value in the attribute argument
    attribute <- deparse(substitute(attribute))

    # If the argument exactMatch is set to be TRUE, this function performs bascially the same as the rtry_filter function
    # Priority of exactMatch is higher than caseSensitive
    # So if exactMatch is set to be TRUE and caseSensitive is set to be FALSE, the caseSensitive FALSE will be ignored
    if(exactMatch == TRUE){
      if(caseSensitive == FALSE){
        message("argument 'caseSensitive = FALSE' will be ignored.")
      }
      # Select the rows that fit the criteria within the input data
      exclude <- subset(input, input[[attribute]] %in% ...)
    }

    # If the argument exactMatch is set to be FALSE, select the rows that fit the criteria within the input data
    # Note that the ... are keywords in this case
    # As long as the keyword exists in the attribute column, that row will be selected
    else{
      exclude <- subset(input, grepl(paste(..., collapse = "|"), input[[attribute]], ignore.case = !caseSensitive))
    }

    # Obtain a list of unique specified ObservationID within the selected rows
    exclude <- unique(exclude$ObservationID)

    # Add a new column exclude in the input data
    # Check which rows of input data is on the list to be excluded, marked TRUE
    input$exclude <- input$ObservationID %in% exclude

    # Select all the rows where the exclude column equals FALSE
    # Then, remove the exclude column
    input <- subset(input, input$exclude == FALSE, select = -(exclude))

    # Copy the processed input into a new variable
    filteredData <- input

    # If the argument showOverview is set to be TRUE, print the dimension of the filtered data
    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(filteredData), sep = " "))
    }

    # Return the filtered data
    return(filteredData)
  }
}
