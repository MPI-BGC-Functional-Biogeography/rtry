#' Perform geocoding
#'
#' This function uses \href{https://wiki.openstreetmap.org/wiki/Nominatim}{Nominatim},
#' a search engine for OpenStreetMap (OSM) data, to perform Geocoding,
#' i.e. converting an address into coordinates (latitudes, longitudes).
#' The data provided by OSM is free to use for any purpose, including commercial use,
#' and is governed by the distribution license \href{https://wiki.osmfoundation.org/wiki/Licence}{ODbL}.
#'
#' @param address String of an address
#' @param email String of an email address
#' @return A data frame that contains latitudes (lat) and longitudes (lon) in WGS84 projection
#' @examples
#' # Convert the address of MPI-BGC ("Hans-Knoell-Strasse 10, 07745 Jena, Germany")
#' # into coordinates in latitudes and longitudes
#' # Note: please change to your own email address when executing this function
#' rtry_geocoding("Hans-Knoell-Strasse 10, 07745 Jena, Germany",
#'    email = "jkattge@bgc-jena.mpg.de")
#'
#' # Expected output:
#' #        lat      lon
#' # 1 50.91011 11.56682
#' @seealso \code{\link{rtry_revgeocoding}}
#' @export
rtry_geocoding <- function(address = NULL, email = NULL){
  # If the argument address is missing, show the message
  if(missing(address)){
    message("Please make sure you have entered an address.")
  }
  else{
    # If the argument email is missing, show the message
    if(missing(email)){
      message("Please make sure you have provided a valid email address.")
    }
    # Check if a valid email address is provided (can only check the syntax)
    # Proceed if the provided email address has a correct syntax
    else if(grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(email), ignore.case=TRUE)){
      # Perform geocoding using the OpenStreetMap Nominatim API
      # Return NA when address is NULL or when the API failed to search for the coordinates
      if(is.null(address))
        return(data.frame("NA"))

      tryCatch(
        geocode <- jsonlite::fromJSON(
          gsub('\\@addr\\@', gsub('\\s+', '\\%20', address),
               paste0("http://nominatim.openstreetmap.org/search/@addr@?format=json&addressdetails=0&limit=1", "&email=", email))
        ), error = function(c) return(data.frame("NA"))
      )

      if(length(geocode) == 0) {
        return(data.frame("NA"))
      }

      # Return the data frame that contains latitudes (lat) and longitudes (lon) in WGS84 projection
      return(data.frame(lat = as.numeric(geocode$lat), lon = as.numeric(geocode$lon)))
    }
    # If the syntax of the provided email address is not valid, show the message
    else{
      message("Please provide a valid email address.")
    }
  }
}
