#' Export preprocessed data
#'
#' This function exports the preprocessed data as comma separated values to a \code{.csv} file.
#' If the specified output directory does not exist, it will be created.
#'
#' @param data The data to be saved.
#' @param output Output path.
#' @param quote Default \code{TRUE} inserts double quotes around any character or factor columns.
#' @return No return value, called for exporting a \code{.csv} file.
#' @param encoding Default \code{"UTF-8"}. File encoding.
#' @references This function makes use of the \code{\link[utils]{write.csv}} function
#'             within the \code{utils} package.
#' @examples
#' # Export the preprocessed data to a specific location
#' rtry_export(data_TRY_15160, file.path(tempdir(), "TRYdata_unprocessed.csv"))
#'
#' # Expected message:
#' # File saved at: C:\Users\user\AppData\Local\Temp\Rtmp4wJAvQ/TRYdata_unprocessed.csv
#' @export
rtry_export <- function(data, output, quote = TRUE, encoding = "UTF-8"){
  # If either of the input or output is missing, show the message
  if(missing(data) || missing(output)){
    message("Please make sure you have specified the data to be saved or the output path.")
  }
  else{
    # If the output directory does not exist, create one
    if (!dir.exists(dirname(output))){
      dir.create(dirname(output))
      message("New directory created at: ", paste0(dirname(output), sep = " "))
    }

    # Write the data into a CSV file at the specified location
    utils::write.csv(x = data, file = output, quote = quote, fileEncoding = encoding)
    message("File saved at: ", output)
  }
}
