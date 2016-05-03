#' Power calculations.
#'
#' This function simply counts the proportion of people who selected the data plot,
#' in a set of lineups. It adjusts for multiple picks by the same individual, by weighting
#' by the total number of choices.
#' @param data summary of the results, containing columns id, pic_id, response, detected
#' @param m size of the lineup
#' @return vector of powers for each pic_id
#' @export
#' @examples
#' visual_power(15, 20, m=3) # triangle test

visual_power <- function(data, m=20) {
  data <- data %>% mutate(
    nchoices_wgt = (m-sapply(strsplit(as.character(full$response_0), ","), length))/19)
  visual_p <- data %>% group_by(pic_id) %>%
    summarise(sum(detected*nchoices_wgt))
  return(visual_p)
}