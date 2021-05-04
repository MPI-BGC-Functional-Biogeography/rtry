#' Export pre-processed TRY data
#'
#' This function exports the pre-processed data as a CSV file.
#' If the specified output directory does not exist, it will be created.
#'
#' @param data The data to be saved
#' @param output Output path
#' @param quote Default \code{TRUE} inserts double quotes around any character or factor columns
#' @param encoding File encoding. Default \code{"UTF-8"}
#' @examples
#' \dontrun{
#' rtry_export(TRYdata, "./output/TRYdata_processed.csv")
#' }
#' @export
rtry_export <- function(data = "", output = "", quote = TRUE, encoding = "UTF-8"){
  if(missing(data) || missing(output)){
    message("Please make sure you have specified the data to be saved or the output path.")
  }
  else{
    if (!dir.exists(dirname(output))){
      dir.create(dirname(output))
      message("New directory created at: ", paste0(dirname(output), sep = " "))
    }

    utils::write.csv(x = data, file = output, quote = quote, fileEncoding = encoding)
    message("File saved at: ", output)
  }
}
