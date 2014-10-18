#' Get stock values from Google Finance
#'
#' @param symbols A character vector of symbols to look up on Google Finance
#' @param file_out An optional file name to append comma-delimited data to.
#'   This file must already exist.
#' @param file_name The name of the file to write to.
#' @param append Should the data be appended to \code{file_name}?
#' @importFrom httr GET content
#' @importFrom stringr str_extract
#' @importFrom lubridate today
#' @export
#' @return A data frame with current values for each stock symbol. The first
#'   column will contain today's date.

#' @examples
#' s <- c("VAB", "XRB", "ZRE", "XEC", "XEF", "XIC",
#'   "VUN", "TDB909", "TDB911")
#' google_dat(s)

google_dat <- function(symbols, file_out = FALSE,
  file_name = "investments.txt", append = TRUE) {

  v <- sapply(symbols, function(i) {
    x <- GET(paste0("http://finance.google.com/finance/info?client=ig&q=", i))
    as.numeric(str_extract(content(x, as = "text"), "[0-9]+\\.[0-9]+"))})
  vd <- data.frame(Date = today(), t(v))
  if(file_out) {
    write.table(vd, file_name, sep = ", ", append = append,
      col.names = FALSE, row.names = FALSE)
  }
  vd
}
