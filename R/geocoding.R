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


#' Perform Reverse Geocoding
#'
#' This function uses Nominatim, a search engine for OpenStreetMap data, to
#' perform reverse Geocoding, i.e. converting coordinates (latitudes, longitudes) into an address.
#' For details, please refer to: \url{https://wiki.openstreetmap.org/wiki/Nominatim}.
#'
#' @param lat_lon A data frame consisting latitude and longitude in WGS84 projection
#' @param email String of an email address
#' @return A data frame that contains address
#' @examples
#' \dontrun{
#' rtry_revgeocoding(data.frame(50.91012, 11.56674), email = email)
#' }
#' @export
rtry_revgeocoding <- function(lat_lon = NULL, email = NULL){
  if(missing(lat_lon)){
    message("Please make sure you have entered a data frame with latitude and longitude.")
  }
  else{
    if(missing(email)){
      message("Please make sure you have provided a valid email address.")
    }
    else if(grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(email), ignore.case=TRUE)){
      lat = lat_lon[[1]]
      lon = lat_lon[[2]]

      if(is.na(lat) || is.na(lon) || is.null(lat) || is.null(lon)){
        return(data.frame("NA"))
      }

      tryCatch(
        rev_geocode <- jsonlite::fromJSON(
          paste0("https://nominatim.openstreetmap.org/reverse?format=json", "&lat=", lat, "&lon=", lon, "&accept-language=en","&addressdetails=1", "&zoom=10", "&email=", email)
        ), error = function(c) return(data.frame("NA"))
      )

      extracted_address <- data.frame(full_address = NA, town = NA, city = NA, country = NA, country_code = NA)

      if(length(rev_geocode) != 0){
        full_address <- rev_geocode$display_name
        town = rev_geocode$address$town
        city = rev_geocode$address$city
        country = rev_geocode$address$country
        country_code = rev_geocode$address$country_code

        tmp_data <- list(full_address, town, city, country, country_code)

        for(i in 1:length(tmp_data)){
          if(is.null(tmp_data[[i]])){
            tmp_data[[i]] <- NA
          }
        }

        extracted_address[1,] <- tmp_data

      } else{
        return(data.frame("NA"))
      }

      return(data.frame(extracted_address))
    }
    else{
      message("Please provide a valid email address.")
    }
  }
}
