#' Select ancillary data in wide table format
#'
#' This function selects one specified ancillary data together with the \code{ObservationID}
#' from the imported data and transforms it into a wide table format for further processing.
#' It works for only one ancillary data in \code{DataID} at a time.
#'
#' @param input Input data frame or data table.
#' @param id The ID of ancillary data (\code{DataID} in the TRY data) to be selected.
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the selected data.
#' @return An object of the same type as the input data.
#' @references This function makes use of the \code{\link[base]{subset}} and \code{\link[dplyr]{distinct}} functions
#'             within the \code{base} and \code{dplyr} packages respectively. It also uses the functions
#'             \code{\link{rtry_select_col}} and \code{\link{rtry_remove_col}}.
#' @examples
#' # Obtain a list of ObservationID and the corresponding ancillary data of interest
#' # using the specified DataID (e.g. DataID 59 for latitude) from the provided sample
#' # data (data_TRY_15160)
#' Latitude <- rtry_select_anc(data_TRY_15160, 59)
#'
#' # Expected message:
#' # dim:   98 2
#' # col:   ObservationID Latitude
#' @export
rtry_select_anc <- function(input, id, showOverview = TRUE){
  # Bind the variables locally to the function
  ObservationID <- NULL
  DataID <- NULL
  DataName <- NULL
  StdValue <- NULL
  OrigValueStr <- NULL

  # If either of the arguments input or id is missing, show the message
  if(missing(input) || missing(id)){
    message("Please specify the input data and/or the id of ancillary data you would like to select.")
  }
  else{
    # Add quotations around the ancillary id (DataID)
    anc_id <- deparse(substitute(id))

    # Select the necessary columns for extracting the unique ancillary data and the corresponding ObservationID
    input <- rtry_select_col(input, ObservationID, DataID, DataName, StdValue, OrigValueStr, showOverview = FALSE)

    # Extract the rows where the DataID equals to the desired ancillary data id (id)
    input <- subset(input, DataID == anc_id)

    # Obtain the DataName for the given DataID
    anc_name <- unique(input$DataName)

    # Check if the entire StdValue column has no value other than NA
    if(all(is.na(input$StdValue))){
      # Print message
      message("Since the 'StdValue' column has no value other than NA, the column 'OrigValueStr' is used instead.")

      # Change the column OrigValueStr into the name of the ancillary data (anc_name)
      colnames(input)[which(names(input) == "OrigValueStr")] <- anc_name

      # Delete the columns that are redundant
      input <- rtry_remove_col(input, DataID, DataName, StdValue, showOverview = FALSE)
    }
    else{
      # Change the column StdValue into the name of the ancillary data (anc_name)
      colnames(input)[which(names(input) == "StdValue")] <- anc_name

      # Delete the columns that are redundant
      input <- rtry_remove_col(input, DataID, DataName, OrigValueStr, showOverview = FALSE)
    }

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
