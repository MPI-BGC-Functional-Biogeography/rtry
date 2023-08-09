library(arrow)
library(data.table)


#' @author Brian Maitner <bmaitner@gmail.com>
#' @note Received on 2022-03-25
#' @description Quick and dirty function to convert TRY's .txt files to a more useful parquet format
#' @param file A file to be converted
#' @param output_directory Where you want all the files deposited
#' @param batch_size The number of lines to load in at once
try_to_parquet <- function(file,
                           output_directory = "manual_downloads/TRY/TRY_parquet/",
                           batch_size = 80000){

  #Setup variables

    i <- 0
    error_found <- FALSE

  #Iterate through batches

    while(!error_found){


        if(i == 0){

          data <- fread(file = file,
                        nrows = batch_size,
                        skip = i, quote = "", sep = "\t",header = TRUE)

          col_names <- colnames(data)

        }else{

          data <- fread(file = file,
                        nrows = batch_size,
                        skip = i, quote = "", sep = "\t",header = FALSE)

          colnames(data) <- col_names

        }



      tryCatch(
        expr = write_parquet(x = data,
                             sink = file.path(output_directory,paste(basename(file),".",as.integer(i),".gz.parquet",sep = "")),
                             compression = "gzip"),
        error = function(e){
          error_found <- TRUE
          message(paste("Finished converting TRY file",file,"to parquet"))
          return(invisible(NULL))

        }


      )


      #check whether you're done
      if(nrow(data) < batch_size){

        message(paste("Finished converting TRY file",file,"to parquet"))
        return(invisible(NULL))

      }


      i <- i+nrow(data)

      print(i)

      rm(data)


    } #while loop




}# end fx


try_to_parquet("H:/My Drive/WISC/Research/rtry/TRY_R_backup/input/7571.txt", "H:/My Drive/WISC/Research/rtry/parquet_output_500000", batch_size = 500000)


TRYdata <- arrow::open_dataset(sources = "C:/Users/hlam9/Desktop/parquet_output/")

my_df <-data.table::rbindlist(lapply(Sys.glob("C:/Users/hlam9/Desktop/parquet_output/*.parquet"), arrow::read_parquet))



TRYdata %>%
  dplyr::filter(!is.na(TraitID))%>%
  dplyr::group_by(AccSpeciesName, TraitName) %>%
  dplyr::summarise(Count = dplyr::n(),
                   .groups = "drop") %>%
  collect() -> trait_summary


tmp_2 <- TRYdata %>%
  # dplyr::filter(!is.na(TraitID))%>%
  dplyr::group_by(AccSpeciesName, TraitName) %>%
  dplyr::summarise(Count = dplyr::n(),
                   .groups = "drop") %>%
  dplyr::arrange(AccSpeciesName) %>%
  collect()

collect(TRYdata)


rtry_explore <- function (input, ..., sortBy = "", showOverview = TRUE)
{
  if (missing(input) || missing(...)) {
    message("Please specify the input data and/or attribute names you would like to group together.")
  }
  else {
    input <- dplyr::group_by(input, ...)
    input <- dplyr::summarise(input, Count = dplyr::n(),
                              .groups = "drop")
    input <- dplyr::arrange(input, {
      {
        sortBy
      }
    })
    input <- collect(input)
    uniqueData <- input
    if (showOverview == TRUE) {
      message("dim:   ", paste0(dim(uniqueData),
                                sep = " "))
    }
    return(uniqueData)
  }
}
