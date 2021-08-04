#' Filter data
#'
#' This function takes the input data frame or data table and filters (excludes) all records (rows)
#' with the same value in the attribute specified in the argument \code{baseOn} if the criteria
#' specified in the arguments for filtering (\code{\dots}) are fulfilled for one of those records.
#'
#' @param input Input data frame or data table.
#' @param \dots Criteria for filtering.
#' @param baseOn The attribute on which filtering is based on. If it is set to \code{ObservationID},
#'               the function filters all records with the respective \code{ObservationID} if the
#'               specified criteria for filtering is fulfilled for one record. Alternatively, use
#'               \code{ObsDataID} to filter only the record (row) for which the specified criterion
#'               is fulfilled. Other reasonable parameter values are \code{TraitID}, \code{DataID}
#'               or \code{AccSpeciesID}.
#' @param showOverview Default \code{TRUE} displays the dimension of the data after filtering.
#' @return An object of the same type as the input data after filtering.
#' @references This function makes use of the \code{\link[base]{subset}} function
#'             within the \code{base} package.
#' @examples
#' # Example 1: Exclude observations on juvenile plants or unknown state:
#' # Identify observations where the plant developmental status (DataID 413) is either
#' # "juvenile" or "unknown", and exclude the whole observation
#' data_filtered <- rtry_filter(TRYdata_15160,
#'                    (DataID %in% 413) & (OrigValueStr %in% c("juvenile", "unknown")),
#'                    baseOn = ObservationID)
#'
#' # Expected message:
#' # dim:   1618 28
#'
#' # Example 2: Exclude outliers:
#' # Identify the outliers, i.e. trait records where the ErrorRisk is larger than 4
#' # and exclude these records (not the whole observation)
#' data_filtered <- rtry_filter(TRYdata_15160,
#'                    ErrorRisk > 4,
#'                    baseOn = ObsDataID)
#'
#' # Expected message:
#' # dim:   1778 28
#'
#' # Learn more applications of the filtering function via the vignette (Workflow for
#' # general data preprocessing using rtry): vignette("rtry-workflow-general").
#' @export
rtry_filter <- function(input, ..., baseOn, showOverview = TRUE){
  # If either of the arguments input or ... is missing, show the message
  if(missing(input) || missing(...) || missing(baseOn)){
    message("Please specify the input data and/or criteria and/or baseOn for filtering.")
  }
  else{
    # Add quotations around the value in the baseOn argument
    baseOn <- deparse(substitute(baseOn))

    # Select all the rows that fit the criteria within the input data
    exclude <- subset(input, ...)

    # Obtain a list of unique specified baseOn
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
