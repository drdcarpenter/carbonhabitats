

#' @title carbonise
#' @description Calculate the carbon storage (above ground biomass and soil carbon) and sequestration for UK priority habitats.
#' @param x habitats data frame
#' @param habitats name of the column containing priority habitats types
#' @return sf features with stored above ground carbon and sequestered carbon per year for each feature
#' @details The function calculates the amount of above ground carbon stored in each priority habitat type using data taken from two papers (see main package description for references).
#' It also calculates stored soil carbon using data from the Global Soil Organic Carbon map.  The soil carbon data only covers the UK.  You need to supply the name of the field with the UK priority habitat descriptions in.
#' The function can be slow if you have a lot of habitat features, as it summarises soil carbon data from a large raster.
#' The input dataset needs to be an sf features dataset.
#' The CRS for this package is EPSG:27700.  You may need to transform your data for the function to work.
#' @examples 
#' c <- carbonise(x, habitats = "S41Habitat")
#' @seealso 
#'  \code{\link[dplyr]{mutate_all}},\code{\link[dplyr]{mutate}},\code{\link[dplyr]{mutate-joins}}
#'  \code{\link[sf]{geos_measures}}
#' @rdname carbonise
#' @export 
#' @importFrom dplyr mutate_if mutate left_join
#' @importFrom sf st_area
#' @importFrom exactextractr exact_extract

carbonise <- function(x, habitats){
  # convert factors to character for join
  x <- x %>% dplyr::mutate(across(where(is.factor), as.character))
  
  # calculate feature areas in hectares
  x <- x %>% dplyr::mutate(Area = as.numeric(sf::st_area(x) / 10000))
  
  # join carbon data to habitats data
  cx <- dplyr::left_join(x, carbon, by = c("S41Habitat" = habitats))
  
  # calculate stored C and sequestered C per feature
  # cx <- cx %>% 
  #   dplyr::mutate(storedC = as.numeric(.data$Area * .data$AGB)) %>% 
  #   dplyr::mutate(seqC = as.numeric(.data$Area * .data$Cseq))
  # 
  cx$storedC <- as.numeric(cx$Area * cx$AGB)
  cx$seqC <- as.numeric(cx$Area * cx$Cseq)
  
  # calculate soil carbon per feature
  cx$soilC <- exactextractr::exact_extract(soilcarbon, cx, "mean")
  
  # calculate total C
  # cx <- cx %>% dplyr::mutate(cx, totalC = (.data$storedC + .data$soilC))
  
  cx$totalC <- cx$storedC * cx$soilC
  
  return(cx)
}
