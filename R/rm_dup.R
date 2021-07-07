#' Remove duplicates in TRY data
#'
#' This function identifies and removed the duplicates from the input data using the
#' duplicate identifier \code{OrigObsDataID} provided within the TRY data.
#' Once the function is called and executed, the number of duplicates removed
#' will be displayed on the console as reference.
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
