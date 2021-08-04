#' Remove duplicates in data
#'
#' This function removes the duplicates from the input data using the duplicate identifier
#' \code{OrigObsDataID} provided within the TRY data. Once the function is called and executed,
#' the number of duplicates removed will be displayed on the console as reference.
#'
#' @param input Input data frame or data table.
#' @param showOverview Default \code{TRUE} displays the the dimension of the data after removing the duplicates.
#' @return An object of the same type as the input data after removing the duplicates.
#' @references This function makes use of the \code{\link[base]{subset}} function
#'             within the \code{base} package.
#' @note This function depends on the duplicate identifier \code{OrigObsDataID} listed
#'       in the data exported from the TRY database, therefore, if the column \code{OrigObsDataID}
#'       has been removed, this function will not work. Also, if the original value of an
#'       indicated duplicate is a restricted value, which has not been requested from
#'       the TRY database (if only public data were requested), the duplicate will be
#'       removed and this may result in data loss.
#' @examples
#' # Remove the duplicates within the provided sample data (TRYdata_15160)
#' data_rm_dup <- rtry_rm_dup(TRYdata_15160)
#'
#' # Expected message:
#' # 45 duplicates removed.
#' # dim:   1737 28
#' @export
rtry_rm_dup <- function(input, showOverview = TRUE){
  # Bind the variable OrigObsDataID locally to the function
  OrigObsDataID <- NULL

  # If the argument input is missing, show the message
  if(missing(input)){
    message("Please specify the input data for removing duplicates.")
  }
  else{
    # If the column OrigObsDataID exists in the input data, continue the duplicates removal process
    if("OrigObsDataID" %in% colnames(input)){
      # Select all the rows within the input data where the OrigObsDataID is larger than 0
      exclude <- subset(input, OrigObsDataID > 0)

      # Obtain a list of unique OrigObsDataID
      exclude <- unique(exclude$OrigObsDataID)

      # Add a new column exclude in the input data
      # Check which rows of input data is on the list to be excluded, marked TRUE
      # Count the number of duplicates
      input$exclude <- input$OrigObsDataID %in% exclude
      numDuplicates <- length(which(input$exclude == TRUE))

      # Select all the rows where the exclude column equals FALSE
      # Then, remove the exclude column
      input <- subset(input, input$exclude == FALSE, select = -(exclude))

      # Copy the processed input into a new variable
      # Print the information on how many duplicates were removed
      inputRemovedDuplicates <- input
      message(numDuplicates, " duplicates removed.")

      # If the argument showOverview is set to be TRUE, print the dimension of the data after duplicates removal
      if(showOverview == TRUE){
        message("dim:   ", paste0(dim(inputRemovedDuplicates), sep = " "))
      }

      # Return the data after duplicates removal
      return(inputRemovedDuplicates)
    }
    # If the column OrigObsDataID does not exist in the input data, show the message
    else{
      message("Please make sure the column 'OrigObsDataID' exists in the input data.")
    }
  }
}
