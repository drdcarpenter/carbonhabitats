

carbonise <- function(x, habitats){
  # convert factors to character for join
  #x <- x %>% dplyr::mutate(dplyr::across(where(is.factor(~.x)), as.character))
  x <- dplyr::mutate_if(x, is.factor, as.character)
  
  # calculate feature areas
  x <- x %>% dplyr::mutate(Area = as.numeric(sf::st_area(x) / 10000))
  
  # join carbon data to habitats data
  cx <- dplyr::left_join(x, carbon, by = c("S41Habitat" = habitats))
  
  # calculate stored C and sequestered C per feature
  cx <- cx %>% 
    dplyr::mutate(storedC = as.numeric(Area * AGB)) %>% 
    dplyr::mutate(seqC = as.numeric(Area * Cseq))
  
  return(cx)
}
