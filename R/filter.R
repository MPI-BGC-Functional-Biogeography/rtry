#' Filter data
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
#' # Filter observations where the plant developmental status (DataID 413)
#' # is "juvenile" or "unknown" while excluding the whole observation
#' data_filter <- rtry_filter(TRYdata_15160,
#'                  (DataID %in% 413) & (OrigValueStr %in% c("juvenile", "unknown")),
#'                  baseOn = ObservationID)
#'
#' # Expected output:
#' # dim:   1618 28
#'
#' # Learn more applications of the filtering function via the command:
#' # vignette("rtry-workflow-general")
#' @seealso \code{\link{rtry_filter_keyword}}
#' @note This function by default filters data based on the unique identifier \code{ObservationID}
#' listed in the TRY data, therefore, if the column \code{ObservationID} has been removed, this function
#' might not work (unless another attribute is defined when calling the function).
#' @export
rtry_filter <- function(input = "", ..., baseOn = ObservationID, showOverview = TRUE){
  # Bind the variable ObservationID locally to the function
  ObservationID <- NULL

  # If either of the arguments input or ... is missing, show the message
  if(missing(input) || missing(...)){
    message("Please specify the input data and/or criteria for filtering.")
  }
  else{
    # Add quotations around the value in the baseOn argument
    baseOn <- deparse(substitute(baseOn))

    # Select all the rows that fit the criteria within the input data
    exclude <- subset(input, ...)

    # Obtain a list of unique specified baseOn (by default: ObservationID)
    exclude <- unique(exclude[[baseOn]])

    # Add a new column exclude in the input data
    # Check which rows of input data is on the list to be excluded, marked TRUE
    input$exclude <- input[[baseOn]] %in% exclude

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
