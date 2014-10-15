#' Modified Dietz method
#'
#' @param start_value The starting value
#' @param end_value The ending value
#' @param f A vector of in and out cash flows
#' @param f_day A numeric vector of days since start in which cash flows occured
#' @param days The (numeric) total number of days (end day minus first day + 1)
#'
#' @references
#' http://en.wikipedia.org/wiki/Modified_Dietz_method
#'
#' @export
#' @return A percent return
#'
#' @examples
#'  mdietz(start_value = 100, end_value = 300, f = c(50),
#'    f_day = c(365), days <- 365*2)
#'
#'  mdietz(start_value = 100, end_value = 300, f = c(50, 150),
#'    f_day = c(365, 380), days <- 365*2)
#'
#'  mdietz(start_value = 100, end_value = 300, f = c(50, 10),
#'    f_day = c(365, 380), days <- 365*2)

mdietz <- function(start_value, end_value, f, f_day, days) {
  w <- (days - f_day) / days
  100 * (end_value - start_value - sum(f)) / (start_value + sum(w * f))
}

#' Get rate of return
#'
#' @param investment_net Net value invested
#' @param contributions A vector of contributions
#' @param buys A vector of value bought
#' @export
#' @return A scalar numeric value representing the rate of return

ror <- function(investment_net, contributions, buys) {
  100 * (sum(contributions) + investment_net) / sum(abs(buys))
}

#
# Imports:
#     dplyr (>= 0.3),
#     tidyr (>= 0.1),
#     ggplot2 (>= 1.0),
#     lubridate (>= 1.3.3)
# Suggests:
#     knitr
