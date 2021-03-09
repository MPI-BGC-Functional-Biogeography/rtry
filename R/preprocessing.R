#' Import TRY data
#'
#' This function imports the text file downloaded from the TRY database (\url{https://www.try-db.org})
#' as a data.table for further processing.
#'
#' @param input Path to the text file downloaded from TRY
#' @param separator Data separator. Default \code{"\t"} for the TRY data output
#' @param encoding File encoding. Default \code{"UTF-8"}
#' @param showOverview Default \code{TRUE} displays the input path, dimension and column names of the input data
#' @return A data table of the input data
#' @export
rtry_import <- function(input = "", separator = "\t", encoding = 'UTF-8', showOverview = TRUE){
  if(missing(input)){
    message("Please specify the input data for grouping.")
  }
  else{
    TRYdata <- data.table::fread(input, header = TRUE, sep = separator, dec = ".", encoding = encoding, quote = "", data.table = TRUE)

    if(showOverview == TRUE){
      message("input: ", input)
      message("dim:   ", paste0(dim(TRYdata), sep = " "))
      message("ls:    ", paste0(ls(TRYdata), sep = " "))
    }

    return(TRYdata)
  }
}



#' Explore TRY data
#'
#' This function takes the data table imported by \code{rtry_import()} and converts it into
#' a grouped data table based on the specified column names.
#' Note the the output data is grouped by the first attribute.
#' To provide a first understanding of the data, an additional column is added to show the total count within each group.
#'
#' @param input Input data, imported by \code{rtry_import()} function or in data table format
#' @param ... Attribute names to group together
#' @param showOverview Default \code{TRUE} displays the dimension of the result data table
#' @return A data table of the unique values grouped by the desired attribute(s)
#' @references \href{https://www.rdocumentation.org/packages/dplyr/versions/0.7.1/topics/group_by}{dplyr::group_by()}
#' @export
rtry_explore <- function(input = "", ..., showOverview = TRUE){
  if(missing(input)){
    message("Please specify the input data for grouping.")
  }
  else{
    if(missing(...)){
      message("Please specify the attribute names you would like to group together.")
      message("To group the input data by DataID and DataName, refer to the following example:")
      message("   explore_data(input = TRYdata, DataID, DataName, showOverview = TRUE)")
      message("\nAvailable column names: ", paste0(ls(input), sep=" "))
    }
    else{
      input <- dplyr::group_by(input, ...)
      input <- dplyr::summarise(input, Count = dplyr::n(), .groups = 'drop')
      uniqueData <- input

      if(showOverview == TRUE){
        message("dim:   ", paste0(dim(uniqueData), sep = " "))
      }

      return(uniqueData)
    }
  }
}



#' Bind TRY data by columns
#'
#' This function takes a sequence of data imported by \code{rtry_import()} and combined them by columns
#'
#' @param ... A sequence of data frame to be combined by columns
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data
#' @return A data table of the input data
#' @export
rtry_bind_col <- function(..., showOverview = TRUE){
  TRYdata <- cbind(...)

  if(showOverview == TRUE){
    message("dim:   ", paste0(dim(TRYdata), sep = " "))
    message("ls:    ", paste0(ls(TRYdata), sep = " "))
  }

  return(TRYdata)
}



#' Bind TRY data by rows
#'
#' This function takes a sequence of data imported by \code{rtry_import()} and combined them by rows.
#'
#' @param ... A sequence of data frame to be combined by rows
#' @param showOverview Default \code{TRUE} displays the dimension and column names of the combined data
#' @return A data table of the input data
#' @export
rtry_bind_row <- function(..., showOverview = TRUE){
  TRYdata <- rbind(...)

  if(showOverview == TRUE){
    message("dim:   ", paste0(dim(TRYdata), sep = " "))
    message("ls:    ", paste0(ls(TRYdata), sep = " "))
  }

  return(TRYdata)
}



#' Select TRY columns
#'
#' This function selects specified columns from the imported data for further processing.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Column names to be selected
#' @param showOverview Default \code{TRUE} displays the dimension of the selected columns
#' @return A data table of the selected columns of the input data
#' @references \href{https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/select}{dplyr::select()}
#' @export
rtry_select_col <- function(input = "", ..., showOverview = TRUE){
  if(missing(input)){
    message("Please specify the input data for column selection.")
  }
  else{
    if(missing(...)){
      message("Please specify the column names you would like to select.")
      message("To select the input data by DataID and DataName, refer to the following example:")
      message("   rtry_select_col(input = TRYdata, DataID, DataName, showOverview = TRUE)")
      message("\nAvailable column names: ", paste0(ls(input), sep = " "))
    }
    else{
      input <- dplyr::select(input, ...)
      selectedColumns <- input

      if(showOverview == TRUE){
        message("dim:   ", paste0(dim(selectedColumns), sep = " "))
      }

      return(selectedColumns)
    }
  }
}



#' Select TRY rows
#'
#' This function selects specified rows from the imported data for further processing.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Criteria for row selection
#' @param getAuxiliary Default \code{FALSE}, set to \code{TRUE} selects all auxiliary data based on the row selection criteria
#' @param rmDuplicates Default \code{FALSE}, set to \code{TRUE} calls the \code{rtry_rmDuplicates()} function
#' @param showOverview Default \code{TRUE} displays the dimension of the data after row selection
#' @return A data table of the selected rows of the input data
#' @export
rtry_select_row <- function(input = "", ..., getAuxiliary = FALSE, rmDuplicates = FALSE, showOverview = TRUE){
  if(missing(input)){
    message("Please specify the input data for row selection.")
  }
  else{
    if(missing(...)){
      message("Please specify the criteria for row selection.")
      message("To select the rows where TraitID is larger than 0 or where DataID is 59 or 60, refer to the following example:")
      message("   rtry_select_row(input = TRYdata, (TraitID > 0) | (DataID %in% c(59, 60)), showOverview = TRUE)")
    }
    else{
      selectedRows <- subset(input, ...)

      if(getAuxiliary == TRUE){
        auxiliary <- unique(selectedRows$ObservationID)

        selectedRows <- subset(input, ObservationID %in% auxiliary)
      }

      if(rmDuplicates == TRUE){
        selectedRows <- rtry_rmduplicates(selectedRows, showOverview = FALSE)
      }

      if(showOverview == TRUE){
        message("dim:   ", paste0(dim(selectedRows), sep = " "))
      }

      return(selectedRows)
    }
  }
}



#' Filter TRY data
#'
#' This function filters data from the input data based on the specified criteria.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param attribute Attribute (column name) for filtering
#' @param ... Values for filtering
#' @param caseSensitive Default \code{TRUE} performs case-sensitive filtering
#' @param exactMatch Default \code{TRUE} performs exact match filtering, overrides all conflicting arguments
#' @param showOverview Default \code{TRUE} displays the dimension of data table after filtering
#' @return A data table of the input data after removing the duplicates
#' @export
rtry_filter <- function(input = "", attribute = "", ..., caseSensitive = TRUE, exactMatch = TRUE, showOverview = TRUE){
  attribute <- deparse(substitute(attribute))

  if(exactMatch == TRUE){
    if(caseSensitive == FALSE){
      message("argument 'caseSensitive = FALSE' will be ignored.")
    }
    exclude <- subset(input, input[,attribute] %in% ...)
  }

  else{
    exclude <- subset(input, grepl(paste(..., collapse = "|"), input[,attribute], ignore.case = !caseSensitive))
  }

  exclude <- unique(exclude$ObservationID)

  input$exclude <- input$ObservationID %in% exclude

  filteredData <- subset(input, input$exclude == FALSE, select = -(exclude))

  if(showOverview == TRUE){
    message("dim:   ", paste0(dim(filteredData), sep = " "))
  }

  return(filteredData)
}



#' Remove TRY columns
#'
#' This function removes specified columns from the imported data for further processing.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param ... Column names to be removed
#' @param showOverview Default \code{TRUE} displays the dimension of the selected columns
#' @return A data table of the remaining columns of the input data
#' @references \href{https://www.rdocumentation.org/packages/dplyr/versions/0.7.8/topics/select}{dplyr::select()}
#' @export
rtry_rm_col <- function(input, ..., showOverview = TRUE){
  if(missing(input)){
    message("Please specify the input data for removing the specified column(s).")
  }
  else{
    if(missing(...)){
      message("Please specify the column names you would like to remove")
      message("To remove the column Reference, Comment and V28 from the input data, refer to the following example:")
      message("   rtry_rm_col(input = TRYdata, Reference, Comment, V28, showOverview = TRUE)")
      message("\nAvailable column names: ", paste0(ls(input), sep = " "))
    }
    else{
      input <- dplyr::select(input, -c(...))
      remainingColumns <- input

      if(showOverview == TRUE){
        message("dim:   ", paste0(dim(remainingColumns), sep = " "))
      }

      return(remainingColumns)
    }
  }
}



#' Remove duplicates in TRY data
#'
#' This function identifies and removed the duplicates from the input data.
#' Once the function is called and executed, the number of duplicates removed will be displayed on the console as reference.
#'
#' @param input Input data, imported by \code{rtry_import()} or in data table format
#' @param showOverview Default \code{TRUE} displays the the dimension of data table after removal
#' @return A data table of the input data after removing the duplicates
#' @export
rtry_rm_dup <- function(input = "", showOverview = TRUE){
  if(missing(input)){
    message("Please specify the input data for removing duplicates.")
  }
  else{
    exclude <- subset(input, OrigObsDataID > 0)

    exclude <- unique(exclude$OrigObsDataID)

    input$exclude <- input$OrigObsDataID %in% exclude
    numDuplicates <- length(which(input$exclude == TRUE))

    input <- subset(input, input$exclude == FALSE, select = -(exclude))

    inputRemovedDuplicates <- input
    message(numDuplicates, "duplicates removed.")

    if(showOverview == TRUE){
      message("dim:   ", paste0(dim(inputRemovedDuplicates), sep = " "))
    }

    return(inputRemovedDuplicates)
  }
}



#' Transform TRY data from long to wide table
#'
#' This function transforms the original long table format of the TRY data into a wide table format.
#'
#' @param input Input data, imported by \code{rtry_import()} function or in data table format
#' @param names_from The column(s) from which the output column names to be obtained
#' @param values_from The column(s) from which the output values to be obtained
#' @param values_fn (Optional) Function to be applied to the output values
#' @param showOverview Default \code{TRUE} displays the dimension of the result data table
#' @return The transformed wide table
#' @references \href{https://www.rdocumentation.org/packages/tidytable/versions/0.5.7/topics/pivot_wider}{tidyr::pivot_wider()}
#' @export
rtry_trans_wider <- function(input = "", names_from = NULL, values_from = NULL, values_fn = NULL, showOverview = TRUE){
  longTable <- input

  wideTable <- tidyr::pivot_wider(longTable,
                                  names_from = {{names_from}},
                                  values_from = {{values_from}},
                                  values_fn = {{values_fn}})

  if(showOverview == TRUE){
    message("dim:   ", paste0(dim(wideTable), sep = " "))
  }

  return(wideTable)
}



#' Export pre-processed TRY data
#'
#' This function exports the pre-processed data as a CSV file.
#' If the specified output directory does not exist, it will be created.
#'
#' @param data The data to be saved
#' @param output Output path
#' @param encoding File encoding. Default \code{"UTF-8"}
#' @export
rtry_export <- function(data = "", output = "", encoding = 'UTF-8'){
  if(missing(data) || missing(output)){
    message("Please make sure you have specified the data to be saved or the output path.")
  }
  else{
    if (!dir.exists(dirname(output))){
      dir.create(dirname(output))
      message("New directory created at: ", paste0(dirname(output), sep = " "))
    }

    write.csv(x = data, file = output, quote = FALSE, fileEncoding = encoding)
    message("File saved at: ", output)
  }
}
