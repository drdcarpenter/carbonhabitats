

#' @title carbonise
#' @description FUNCTION_DESCRIPTION
#' @param x habitats data frame
#' @param habitats name of the column containing priority habitats types
#' @return sf features with stored above ground carbon and sequestered carbon per year for each feature
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
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
  x <- dplyr::mutate_if(x, is.factor, as.character)
  
  # calculate feature areas
  x <- x %>% dplyr::mutate(Area = as.numeric(sf::st_area(x) / 10000))
  
  # join carbon data to habitats data
  cx <- dplyr::left_join(x, carbon, by = c("S41Habitat" = habitats))
  
  # calculate stored C and sequestered C per feature
  cx <- cx %>% 
    dplyr::mutate(storedC = as.numeric(Area * AGB)) %>% 
    dplyr::mutate(seqC = as.numeric(Area * Cseq))
  
  # calculate soil carbon per feature
  cx$soilC <- exactextractr::exact_extract(soilcarbon, cx, "mean")
  
  # calculate total C
  cx <- cx %>% dplyr::mutate(cx, totalC = (storedC + soilC))
  
  return(cx)
}
