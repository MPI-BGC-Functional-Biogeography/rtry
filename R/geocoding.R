#' Perform Geocoding
#'
#' This function uses Nominatim, a search engine for OpenStreetMap data, to
#' perform Geocoding, i.e. converting an address into coordinates (latitudes, longitudes).
#' For details, please refer to: \url{https://wiki.openstreetmap.org/wiki/Nominatim}.
#'
#' @param address String of an address
#' @param email String of an email address
#' @return A data frame that contains latitudes (lat) and longitudes (lon) in WGS84 projection
#' @examples
#' \dontrun{
#' rtry_geocoding("Hans-Knoell-Strasse 10, 07745 Jena, Germany", email = email)
#' }
#' @seealso \code{\link{rtry_revgeocoding}}
#' @export
rtry_geocoding <- function(address = NULL, email = NULL){
  if(missing(address)){
    message("Please make sure you have entered an address.")
  }
  else{
    if(missing(email)){
      message("Please make sure you have provided a valid email address.")
    }
    else if(grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(email), ignore.case=TRUE)){
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

      return(data.frame(lat = as.numeric(geocode$lat), lon = as.numeric(geocode$lon)))
    }
    else{
      message("Please provide a valid email address.")
    }
  }
}
