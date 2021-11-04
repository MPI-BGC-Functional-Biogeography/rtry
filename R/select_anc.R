#' Select ancillary data in wide table format
#'
#' This function selects one specified ancillary data together with the \code{ObservationID}
#' from the imported data and transforms it into a wide table format for further processing.
#' It works for only one ancillary data in \code{DataName} at a time.
#'
#' @param input Input data frame or data table.
#' @param name The name of ancillary data (\code{DataName} in the TRY data) to be selected.
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the selected data.
#' @return An object of the same type as the input data.
#' @references This function makes use of the \code{\link[base]{subset}} and \code{\link[dplyr]{distinct}} functions
#'             within the \code{base} and \code{dplyr} packages respectively. It also uses the functions
#'             \code{\link{rtry_select_col}} and \code{\link{rtry_remove_col}}.
#' @examples
#' # Obtain a list of ObservationID and the corresponding ancillary data of interest
#' # (e.g. "Latitude") from the provided sample data (data_TRY_15160)
#' Latitude <- rtry_select_anc(data_TRY_15160, Latitude)
#'
#' # Expected message:
#' # dim:   98 2
#' # col:   ObservationID Latitude
#' @export
rtry_select_anc <- function(input, name, showOverview = TRUE){
  # Bind the variables locally to the function
  ObservationID <- NULL
  DataName <- NULL
  StdValue <- NULL

  # If either of the arguments input or name is missing, show the message
  if(missing(input) || missing(name)){
    message("Please specify the input data and/or the name of ancillary data you would like to select.")
  }
  else{
    # Add quotations around the ancillary name (DataName)
    anc_name <- deparse(substitute(name))

    # Select the necessary columns for extracting the unique ancillary data and the corresponding ObservationID
    input <- rtry_select_col(input, ObservationID, DataName, StdValue, showOverview = FALSE)

    # Extract the rows where the DataName equals to the desired ancillary data name (name)
    input <- subset(input, DataName == anc_name)

    # Change the column StdValue into the name of the ancillary data (name)
    colnames(input)[which(names(input) == "StdValue")] <- anc_name

    # Delete the column DataName now that it is redundant
    input <- rtry_remove_col(input, DataName, showOverview = FALSE)

    # Select only the unique rows from the input data frame
    input <- dplyr::distinct(input, ObservationID, .keep_all = TRUE)

    # Copy the unique combination of ObservationID and ancillary data into selectedAnc
    selectedAnc <- input


    # If the argument showOverview is set to be TRUE, print the dimension and column names of the selected ancillary data
    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(selectedAnc), sep = " "))
      message("col:   ", paste0(colnames(selectedAnc), sep = " "))
    }

    # Return the ObservationID and the corresponding ancillary data (if any) in a wide table format
    return(selectedAnc)
  }
}
