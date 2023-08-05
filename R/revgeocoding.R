#' Perform reverse geocoding
#'
#' This function uses \href{https://wiki.openstreetmap.org/wiki/Nominatim}{Nominatim},
#' a search engine for OpenStreetMap data, to perform reverse geocoding,
#' i.e. converting coordinates (latitudes, longitudes) into an address.
#' The data provided by OSM is free to use for any purpose, including commercial use,
#' and is governed by the distribution license \href{https://wiki.osmfoundation.org/wiki/Licence}{ODbL}.
#'
#' @param lat_lon A data frame containing latitude and longitude in WGS84 projection.
#' @param email String of an email address.
#' @return A data frame that contains address.
#' @seealso \code{\link{rtry_geocoding}}
#' @examples
#' \dontrun{
#' # Convert the coordinates of MPI-BGC (50.9101, 11.56674) into an address
#' # Note: Please change to your own email address when executing this function
#' rtry_revgeocoding(data.frame(50.9101, 11.56674),
#'   email = "john.doe@example.com")
#'
#' # Expected message:
#' #               full_address town city country country_code
#' # 1 Jena, Thuringia, Germany   NA Jena Germany           de
#' }
#'
#' # Learn to perform reverse geocoding to a list of coordinates via the vignette
#' # (Workflow for geocoding using rtry): vignette("rtry-workflow-geocoding").
#' @export
rtry_revgeocoding <- function(lat_lon, email){
  # If the argument lat_lon is missing, show the message
  if(missing(lat_lon)){
    message("Please make sure you have entered a data frame with latitude and longitude.")
  }
  else{
    # If the argument email is missing, show the message
    if(missing(email)){
      message("Please make sure you have provided a valid email address.")
    }
    # Check if a valid email address is provided (can only check the syntax)
    # Proceed if the provided email address has a correct syntax
    else if(grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(email), ignore.case=TRUE)){
      # Perform reverse geocoding using the OpenStreetMap Nominatim API
      # Return NA when the provided coordinates are NULL or NA or when the API failed to search for an address
      lat = lat_lon[[1]]
      lon = lat_lon[[2]]

      if(is.na(lat) || is.na(lon) || is.null(lat) || is.null(lon)){
        return(data.frame("NA"))
      }

      osm_reverse_url <- "https://nominatim.openstreetmap.org/reverse?format=json"

      tryCatch(
        rev_geocode <- jsonlite::fromJSON(
          paste0(osm_reverse_url, "&lat=", lat, "&lon=", lon, "&accept-language=en","&addressdetails=1", "&zoom=10", "&email=", email)
        ),
        error = function(e){
          message("Nominatim (OSM) is giving errors, please check if the service is running on: ")
          message(paste0(osm_reverse_url, "&lat=", lat, "&lon=", lon))
        },
        warning = function(w){
          message("Nominatim (OSM) is giving warnings, please check if the service is running on: ")
          message(paste0(osm_reverse_url, "&lat=", lat, "&lon=", lon))
        }
      )

      # Create an "empty" variable
      extracted_address <- data.frame(full_address = NA, town = NA, city = NA, country = NA, country_code = NA)

      # If an address exists, extract the relevant information from the result
      if(exists("rev_geocode") && length(rev_geocode) != 0){
        full_address <- rev_geocode$display_name
        town = rev_geocode$address$town
        city = rev_geocode$address$city
        country = rev_geocode$address$country
        country_code = rev_geocode$address$country_code

        # Obtain a list that contains the full address, town, city, country and country code information
        tmp_data <- list(full_address, town, city, country, country_code)

        for(i in 1:length(tmp_data)){
          if(is.null(tmp_data[[i]])){
            tmp_data[[i]] <- NA
          }
        }

        # Copy the obtained data into the variable
        extracted_address[1,] <- tmp_data

      } else{
        return(extracted_address)
      }

      # Return a data frame that contains a list of addresses
      return(data.frame(extracted_address))
    }
    # If the syntax of the provided email address is not valid, show the message
    else{
      message("Please provide a valid email address.")
    }
  }
}
