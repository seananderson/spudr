#' Calculate residual sums of squares for weights and desired weights
#'
#' @param inv_weights a vector of weights. Should be missing the first weight.
#' @param desired_dist the desired weights. Should be one longer than
#'   inv_weights.
#' @param total total amount to invest
#' @param current amounts invested in the assets

rss <- function(inv_weights, desired_dist, total, current) {
  # so they sum to one:
  inv_weights <- c(1-sum(inv_weights), inv_weights)
  inv_totals <- inv_weights * total + current
  current_dist <- inv_totals / sum(inv_totals)
  sum((current_dist - desired_dist)^2)
}

#' Get investment recommendations
#'
#' @param invest the amount to invest
#' @param current a vector of current assets in the same order as \code{weights}
#' @param weights an optionally named vector of desired investment weights
#' @param positive_only Should investments be positive only? If \code{FALSE}
#'   then negative investments may be suggested (i.e. selling one asset and
#'   purchasing another
#' @param total Scalar numeric giving the total amount to be invested
#' @export
#' @examples
#' invest(30000, c(9000, 7000, 6000, 15000, 7000))
#' invest(30000, c(9000, 7000, 6000, 15000, 7000), positive_only = TRUE)
invest <- function(total, current, weights = c(cdn = .2, us = .2,
  eur = 0, cdn_b = .4, int = .2), positive_only = FALSE) {

  if(sum(weights) != 1L) {
    warning("Weights do not sum to one.")
    weights <- weights / sum(weights)
  }
  current_dist <- current / sum(current)
  if(positive_only) {
    o <- optim(weights[-1], rss, desired_dist = weights,
      method = "L-BFGS-B", lower = 0, upper = 1, total = total,
      current = current)
  } else {
    o <- optim(weights[-1], rss, desired_dist = weights,
      method = "L-BFGS-B", upper = 1, lower = -1, total = total,
      current = current)
  }

  o_weights <- c(1 - sum(o$par), o$par)
  names(o_weights) <- names(weights)
  names(current_dist) <- names(weights)
  names(current) <- names(weights)
  invest <- round(o_weights * total, 2)
  final_weights <- round((o_weights * total + current) /
      sum(o_weights * total + current), 3)

  list(invest = invest,
    current_invest = current,
    weights = round(o_weights, 2),
    current_weights = round(current_dist, 2),
    desired_final_weights = weights,
    final_weights = final_weights)
}
